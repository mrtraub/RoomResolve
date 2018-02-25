//
//  AudioWaveView.h
//  VoiceRecorder
//
//  Created by willpirkle on 4/6/11.
//  Copyright 2011 University of Miami. All rights reserved.
//  Edited on 2/16/2016 by Dr. Bennett.

#import <UIKit/UIKit.h>

@interface AudioWaveView : UIView

// set this flag to have a clip warning
@property (nonatomic, readwrite) bool showColorLevels;

// manipulate the look and feel
- (void)setColorWithRed:(float)r Green:(float)g Blue:(float)b Alpha:(float)a; // set the color of wave

// set the level to any dB you like
- (void)setPower:(float)p; // set the powerLevel


- (void)clear; // clear all the past power levels

/* other ideas:
 - change background color
 - grid lines
 - x and y labels
 - zoom x or y (or both) axes
 - dynamic scaling of y-axis
 - gradient of waveform color
 - set clip level dynamically

*/
@end 
