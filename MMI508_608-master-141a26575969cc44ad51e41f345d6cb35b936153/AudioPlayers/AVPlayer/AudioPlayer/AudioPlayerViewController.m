//
//  AudioPlayerViewController.m
//  AudioPlayer
//
//  Created by William Pirkle on 2/16/12.
//  Copyright (c) 2012 University of Miami. All rights reserved.
//  Edited by Dr. Bennett on 2/4/2016

#import "AudioPlayerViewController.h"

@interface AudioPlayerViewController()
{
  NSTimer *playbackMonitorTimer;
}

@end


@implementation AudioPlayerViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}



-(IBAction)startButtonPressed:(id)sender
{
    
    // start the player
    [self.avEngine startAudioPlayer];
    
    
    // create timer and set callback (selector) function/method:
    playbackMonitorTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                            target:self
                                                          selector:@selector(playbackMonitorTimerFired:)
                                                          userInfo:nil
                                                           repeats:YES];

}

- (void)playbackMonitorTimerFired:(NSTimer *)timer
{
    FFTplot.FFTmags=self.avEngine.FFTmags;
    [FFTplot setNeedsDisplay];
}

-(IBAction)stopButtonPressed:(id)sender
{
    // stop the player
    [self.avEngine stopAudioPlayer];
    [playbackMonitorTimer invalidate];

}

- (IBAction)delaySliderChanged:(id)sender {
    self.avEngine.delay.delayTime = delaySlider.value;
    
}

- (IBAction)distortionSliderChanged:(id)sender {
    self.avEngine.distortion.preGain = distortionSlider.value;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    // set the size of the fft plot to the size of the fft (in the engine) divided by 2 ... since we dont care about conjugate portion
    FFTplot.fftSize=self.avEngine.N/2;

    
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
