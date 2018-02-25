//
//  AudioPlayerViewController.m
//  AudioPlayer
//
//  Created by William Pirkle on 2/16/12.
//  Copyright (c) 2012 University of Miami. All rights reserved.
//  Edited by Dr. Bennett on 2/4/2016
//  Edited 2/19/18 by Dr. Bennett

#import "AudioPlayerViewController.h"

@implementation AudioPlayerViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// our first CALLBACK! 
- (void)playbackMonitorTimerFired:(NSTimer *)timer
{
    // get the left meter value
    float leftMeterdB = [self.audioEngine getLeftMeterValue];
    
    // update the meter - it takes dB values! 
    [leftMeterView updateMeter:leftMeterdB];
    
    // next lets get the current time
    float temp =[self.audioEngine getTimePercentage];
    
    scrubSlider.value = temp;

}

- (IBAction)scrubSliderDidChange:(id)sender {
    
    
}


-(IBAction)startButtonPressed:(id)sender
{
    // start the player
    [self.audioEngine startAudioPlayer];

    
    // create timer and set callback (selector) function/method:
    playbackMonitorTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 
                                                target:self
                                                selector:@selector(playbackMonitorTimerFired:)
                                                userInfo:nil
                                                repeats:YES];
}

-(IBAction)stopButtonPressed:(id)sender
{
    // stop the player
    [self.audioEngine stopAudioPlayer];
    
    // stop the timer
    [playbackMonitorTimer invalidate];
    
    // clear the meter
    [leftMeterView clearMeter];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
