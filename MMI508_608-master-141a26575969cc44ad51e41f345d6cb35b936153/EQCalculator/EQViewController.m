//
//  EQViewController.m
//  EQCalculator
//
//  Created by Christopher Bennett on 11/20/15.
//
//

#import "EQViewController.h"


@implementation EQViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self updateFilterCoeffs:nil];
    
    [self.myCoeffsModel registerDelegate:self];
}



- (IBAction)reset:(id)sender
{
    float fCenterFreq = 1000.0;
    float fQ = 0.707;
    
    centerFrequencySlider.value = fCenterFreq;
    qualityFactorSlider.value = fQ;
    
    centerFrequencyEdit.text =  [NSString stringWithFormat:@"%.02f", fCenterFreq];
    qualityFactorEdit.text =  [NSString stringWithFormat:@"%.03f", fQ];
    
    [self updateFilterCoeffs:nil];
}

// handler; called when a slider or edit box changes
- (IBAction)updateFilterCoeffs:(id)sender
{

    float fCenterFreq = 0.0;
    float fQ = 0.0;
    
    if(sender == centerFrequencySlider || sender == qualityFactorSlider)
    {
        fCenterFreq = centerFrequencySlider.value;
        fQ = qualityFactorSlider.value;
    }
    else // must be edit boxes
    {
        NSString *sCenterFreq = centerFrequencyEdit.text;
        NSString *sQ = qualityFactorEdit.text;
        
        fCenterFreq = [sCenterFreq floatValue];
        fQ = [sQ floatValue];
    }
    
    float a0 = 0;
    float a1 = 0;
    float a2 = 0;
    float b1 = 0;
    float b2 = 0;
    

    [self.myCoeffsModel updateCoeffs:fCenterFreq :fQ];
    
    BOOL bSuccess = [self calculateFilterCoeffsWithCenterFrequency:fCenterFreq andQ:fQ returnA0:&a0 returnA1:&a1 returnA2:&a2 returnB1:&b1 returnB2:&b2];
    
    
    // now write to the edit controls
    if(bSuccess)
    {
        a0Edit.text = [NSString stringWithFormat:@"%.08f", a0];
        a1Edit.text = [NSString stringWithFormat:@"%.08f", a1];
        a2Edit.text = [NSString stringWithFormat:@"%.08f", a2];
        b1Edit.text = [NSString stringWithFormat:@"%.08f", b1];
        b2Edit.text = [NSString stringWithFormat:@"%.08f", b2];
    }
    else
    {
        a0Edit.text = @"n/a";
        a1Edit.text = @"n/a";
        a2Edit.text = @"n/a";
        b1Edit.text = @"n/a";
        b2Edit.text = @"n/a";
    }
    
    // if a slider, change the text to match
    if(sender == centerFrequencySlider || sender == qualityFactorSlider)
    {
        centerFrequencyEdit.text =  [NSString stringWithFormat:@"%.02f", fCenterFreq];
        qualityFactorEdit.text =  [NSString stringWithFormat:@"%.03f", fQ];
    }
    else 
    {
        centerFrequencySlider.value = fCenterFreq;
        qualityFactorSlider.value = fQ;
    }
    
}

- (BOOL)calculateFilterCoeffsWithCenterFrequency:(float)fCenterFreq andQ:(float)fQ returnA0:(float*)a0 returnA1:(float*)a1 returnA2:(float*)a2  returnB1:(float*)b1  returnB2:(float*)b2
{
    // validate data entry; are we within the bounds?
    if(fCenterFreq < centerFrequencySlider.minimumValue || fCenterFreq > centerFrequencySlider.maximumValue || fQ < qualityFactorSlider.minimumValue || fQ > qualityFactorSlider.maximumValue)
        return FALSE;
    
    float fSampleRate = 44100;
    
    float fTheta = 2.0*M_PI*fCenterFreq/fSampleRate;
    float d = 1.0/fQ;
    
    float fBeta = (1.0 - (d/2.0)*(sin(fTheta)))/(1.0 + (d/2.0)*(sin(fTheta)));
    float fGamma = (0.5 + fBeta)*cos(fTheta);
    
    *a0 = (0.5 + fBeta - fGamma)/2.0;
    *a1 = (0.5 + fBeta - fGamma);
    *a2 = *a0;
    *b1 = -2.0*fGamma;
    *b2 = 2.0*fBeta;
    
    return TRUE;
    
}


-(void) didUpdateCoeffs:(NSDictionary*)coeffs
{
    //grab coefficients out of dictionary
    
    
}

@end
