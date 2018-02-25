//
//  EQViewController.h
//  EQCalculator
//
//  Created by Christopher Bennett on 11/20/15.
//
//

#import <UIKit/UIKit.h>
#import "FilterPlayerProtocol.h"
#import "LPFCalculator.h"

@interface EQViewController : UIViewController<FilterPlayerProtocol>
{
    IBOutlet UITextField *centerFrequencyEdit;
    IBOutlet UITextField *qualityFactorEdit;
    IBOutlet UILabel *a0Edit;
    IBOutlet UILabel *a1Edit;
    IBOutlet UILabel *a2Edit;
    IBOutlet UILabel *b1Edit;
    IBOutlet UILabel *b2Edit;
    IBOutlet UIButton *resetButton;
    
    IBOutlet UISlider *centerFrequencySlider;
    IBOutlet UISlider *qualityFactorSlider;
}


@property LPFCalculator *myCoeffsModel;

// the supposed easier to read version (selector:argument selector:argument ...)
- (BOOL)calculateFilterCoeffsWithCenterFrequency:(float)fCenterFreq andQ:(float)fQ returnA0:(float*)a0 returnA1:(float*)a1 returnA2:(float*)a2  returnB1:(float*)b1  returnB2:(float*)b2;

// handlers (actions)
- (IBAction)updateFilterCoeffs:(id)sender;

//
- (IBAction)reset:(id)sender;


@end
