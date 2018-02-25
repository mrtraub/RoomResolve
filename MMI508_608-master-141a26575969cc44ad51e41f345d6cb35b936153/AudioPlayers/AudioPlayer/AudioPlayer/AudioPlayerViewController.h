//
//  AudioPlayerViewController.h
//  AudioPlayer
//
//  Created by William Pirkle on 2/16/12.
//  Copyright (c) 2012 University of Miami. All rights reserved.
//  Edited by Dr. Bennett on 2/4/2016

#import <UIKit/UIKit.h>
#import "AudioEngine.h"
#import "MeterView.h"


@interface AudioPlayerViewController : UIViewController
{
    
    IBOutlet UISlider *scrubSlider;
    IBOutlet UILabel *timeLabel;
    // left - you do right
    IBOutlet MeterView   *leftMeterView;

    // 8) timer for metering and scrub slider
    NSTimer *playbackMonitorTimer;
}

// get/set my engine
@property (nonatomic, assign) AudioEngine *audioEngine;
- (IBAction)scrubSliderDidChange:(id)sender;

-(IBAction)startButtonPressed:(id)sender;
-(IBAction)stopButtonPressed:(id)sender;

@end
