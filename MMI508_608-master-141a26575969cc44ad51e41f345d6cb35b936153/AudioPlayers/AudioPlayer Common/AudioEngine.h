//
//  AudioEngine.h
//  Copyright 2011 University of Miami. All rights reserved.
//  Edited 2/19/18 by Dr. Bennett

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>



// our audio engine is a delegate of AVAudioPlayer ... that means we must conform and handle certain callbacks
@interface AudioEngine : NSObject <AVAudioPlayerDelegate>




- (BOOL)initAudioPlayerWithFile:(NSString *)audioFilePath;

// start/stop functions; if you have multuple players you need to index them
- (void)startAudioPlayer;
- (void)stopAudioPlayer;

- (NSTimeInterval) getTimeInterval;

- (float) getTimePercentage;

// metering methods; if you have multuple players you need to index them
- (float)getLeftMeterValue;


- (float)getPeakPowerForBus:(int)bus;

// you do the right one!

// you need to implement some kind of return to beginning (rewind button)

// NOTE we are a delegate of AVAudioPlayerDelegate but I have not implemented any of the functions here. You do it?



@end







