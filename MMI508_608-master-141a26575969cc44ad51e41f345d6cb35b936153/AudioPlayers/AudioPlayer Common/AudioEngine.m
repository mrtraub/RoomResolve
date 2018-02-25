//
//  AudioEngine.mm
//  Created by willpirkle on 2/16/12.
//  Copyright 2011 University of Miami. All rights reserved.
//

#import "AudioEngine.h"

@interface AudioEngine()

    // first one - you (probably) need to make an array if you want more than one
    @property (strong, nonatomic) AVAudioPlayer *audioPlayer;
    /*
     With audio player you can:
     -Play sounds of any duration
     -Play sounds from files or memory buffers
     -Loop sounds
     -Play multiple sounds simultaneously, one sound per audio player, with precise synchronization
     -Control relative playback level, stereo positioning, and playback rate for each sound you are playing
     -Seek to a particular point in a sound file, which supports such application features as fast forward and rewind
     -Obtain data you can use for playback-level metering
     */
@end


@implementation AudioEngine



// give me a file path, I load my player and queue it up!
- (BOOL)initAudioPlayerWithFile:(NSString *)audioFilePath
{
    if(audioFilePath)
	{
		// 1) URL
		NSURL *url = [NSURL fileURLWithPath:audioFilePath];
        
        // error check!!!! every step of the way
        if(!url)
            return NO; // fail
		
		// 2) alloc-init audio player with this mp3
		self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
		
		// 3) set the delegate
		[self.audioPlayer setDelegate:self];
        
        // 4) preload first buffer
        [self.audioPlayer prepareToPlay];
        
        // 5) enable metering
        [self.audioPlayer setMeteringEnabled:YES];
        
        // 6) are we enabling rate changes to happen?
        
        // rockin
        return YES;
	}
    
    // fail
    return NO;
}

- (void)startAudioPlayer
{
    // start it
    [self.audioPlayer play];
}

- (void)stopAudioPlayer
{
    // stop it
    [self.audioPlayer stop];
    
}

// returns meter value, -120dBFS -> 0dBFS
- (float)getLeftMeterValue
{
    // 1) as per documentation, call this first
    [self.audioPlayer updateMeters];

    // 2) now ask for the value and return it 
    return [self.audioPlayer averagePowerForChannel:0]; // channel 0 is LEFT
    
}

- (float)getPeakPowerForBus:(int)bus
{
    // 1) as per documentation, call this first
    [self.audioPlayer updateMeters];
    
    // 2) now ask for the value and return it
    return [self.audioPlayer peakPowerForChannel:bus];
    
}


- (NSTimeInterval) getTimeInterval
{
    return [self.audioPlayer currentTime];

}

- (float) getTimePercentage
{
    return 100*[self getTimeInterval]/[self.audioPlayer duration];
}


@end
