//
//  MeterView.m
//  iPhoneAudio
//
//  Created by willpirkle on 4/15/11.
//  Copyright 2011 University of Miami. All rights reserved.
//  Edited by Dr. Bennett on 2/4/2016
//  Edited by Dr. Bennett on 2/21/2018

#import "MeterView.h"

@interface MeterView()

@property (nonatomic)Float32 minMeterValue;
@property (nonatomic)float meterValue_dB;


@end

@implementation MeterView




// initialize the AudioWaveView
- (id)initWithCoder:(NSCoder *)aDecoder
{
	// if the superclass initializes properly
	if (self = [super initWithCoder:aDecoder])
	{
        self.minMeterValue = 40;
		self.meterValue_dB = -self.minMeterValue;
	} 
	
	return self; 
} 



- (void)updateMeter:(float)fdB
{
	self.meterValue_dB = fdB;
	[self setNeedsDisplay];// redraw happens here
}

- (void)clearMeter
{
    [self updateMeter:-self.minMeterValue];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect 
{
    // Drawing code.
    
    // get our width and height
    CGSize size = self.frame.size;
    
    // find the meter height (normal coordinate system)
    float fPixelPer_dB =  self.frame.size.height/self.minMeterValue;
    
    float fMeterPos =  self.frame.size.height + (self.meterValue_dB*fPixelPer_dB);
    
    
    
    
	// get the current device context
	CGContextRef context = UIGraphicsGetCurrentContext();
    
    // color for fill
    CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 0.5); // green color, half transparent
	
	// experiment with different widths
	CGContextSetLineWidth(context, 1.0);
	

	
	// fill with color
    // -- note flipping of height here
		CGContextFillRect(context,  CGRectMake(0.0, size.height-fMeterPos, size.width, fMeterPos)); // normal, flipped ht


}




@end
