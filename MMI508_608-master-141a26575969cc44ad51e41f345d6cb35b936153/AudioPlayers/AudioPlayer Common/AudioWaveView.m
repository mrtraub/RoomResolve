//
//  AudioWaveView.h
//  VoiceRecorder
//
//  Created by willpirkle on 4/6/11.
//  Copyright 2011 University of Miami. All rights reserved.
//
#import "AudioWaveView.h"

@interface AudioWaveView()

    // array for RMSDetectorOutput
    @property NSMutableArray *rmsPowerLevels;

    // all of our colors (combine into one type?)
    @property float red, green, blue, alpha_value; // "alpha" is a reserved word

    @property (readonly) Float32 minWaveValue;

@end

@implementation AudioWaveView


// initialize the AudioWaveView
- (id)initWithCoder:(NSCoder *)aDecoder
{
   // if the superclass initializes properly
   if (self = [super initWithCoder:aDecoder])
   {
       // set the minimum value (0 on the waveform)
       _minWaveValue=-40;
       
       // initialize powers with an entry for every other pixel width
	   self.rmsPowerLevels = [[NSMutableArray alloc] initWithCapacity:self.frame.size.width];

       self.showColorLevels = NO;
	   
	   [self setColorWithRed:0 Green:0.1 Blue:1 Alpha:0.9]; // set the color of wave

   } 
   
   return self; 
} 

- (void)setPower:(float)p
{
	// add the point to the array
    // these three lines the same
   // [self.rmsPowerLevels addObject:[[NSNumber alloc] initWithFloat:p]];
//	[self.rmsPowerLevels addObject:[NSNumber numberWithFloat:p]];
    [self.rmsPowerLevels addObject:@(p)];
   
	// NSLog(@"power = %f" ,p);
	
	// remove the leading points. until the array fits in the frame width
	while (self.rmsPowerLevels.count > self.frame.size.width)
	{
		// remove leading edge
		[self.rmsPowerLevels removeObjectAtIndex:0];
	}

    
    [self setNeedsDisplay];
} 

// clears all the points from the AudioWaveView
// remember to call setNeedsUpdate to repaint
- (void)clear
{
	// remove all objects 
   [self.rmsPowerLevels removeAllObjects];
	
	// reset
    [self setNeedsDisplay];
} 

// set the color
- (void)setColorWithRed:(float)r Green:(float)g Blue:(float)b Alpha:(float)a // set the color of wave
{
	self.red = r;
	self.green = g;
	self.blue = b;
	self.alpha_value = a;
}

// draws the AudioWaveView Histogram
- (void)drawRect:(CGRect)rect
{
   // get the current device context
   CGContextRef context = UIGraphicsGetCurrentContext();
   
	// experiment with different widths .... experiment
	CGContextSetLineWidth(context, 1.0);

	// get our width and height
	CGSize size = self.frame.size;
   
	// draw a line for each point in rmsPowerLevels
    for (int i = 0; i < self.rmsPowerLevels.count; i++)
	{
	   // get next power level
        //[self.rmsPowerLevels objectAtIndex:i]
       float newPower =  [self.rmsPowerLevels[i] floatValue];
	   
	   // clamp at -minWaveValue: this is y = 0, right on the x-axis
	   newPower = (newPower < self.minWaveValue) ? self.minWaveValue : newPower;
	   
	   // calculate the height for this power level; minWaveValue is the "min power"
	   float lineHeight = (1 - (newPower/self.minWaveValue)) * (size.height / 2);

	   // Draw lines down each x-axis pixel; the total hieght of each line
	   // is calculated from the difference between the power and the minRMSPower
	   //
	   // move to a point ABOVE the center of the window
	   CGContextMoveToPoint(context, i, size.height/2 - lineHeight);
      
	   // add a line to a point below the middle of the view
	   CGContextAddLineToPoint(context, i , size.height/2 + lineHeight);
      
	   // set the color for this line segment
        if(self.showColorLevels && newPower > -12)
            CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
        else 
           CGContextSetRGBStrokeColor(context, self.red, self.green, self.blue, self.alpha_value);
        
	   // stroke 
	   CGContextStrokePath(context);    
	} 
}



@end 
