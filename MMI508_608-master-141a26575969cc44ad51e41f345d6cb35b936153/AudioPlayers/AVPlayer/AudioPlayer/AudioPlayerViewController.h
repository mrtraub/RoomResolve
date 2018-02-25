//
//  AudioPlayerViewController.h
//  AudioPlayer
//
//  Created by William Pirkle on 2/16/12.
//  Copyright (c) 2012 University of Miami. All rights reserved.
//  Edited by Dr. Bennett on 2/4/2016

#import <UIKit/UIKit.h>
#import "AVEngine.h"
#import "AudioFFTView.h"


@interface AudioPlayerViewController : UIViewController
{
    IBOutlet AudioFFTView *FFTplot;
    IBOutlet UISlider *delaySlider;
    IBOutlet UISlider *distortionSlider;
}

// get/set my engine
@property (nonatomic, assign) AVEngine *avEngine;

-(IBAction)startButtonPressed:(id)sender;
-(IBAction)stopButtonPressed:(id)sender;
- (IBAction)delaySliderChanged:(id)sender;
- (IBAction)distortionSliderChanged:(id)sender;

@end
