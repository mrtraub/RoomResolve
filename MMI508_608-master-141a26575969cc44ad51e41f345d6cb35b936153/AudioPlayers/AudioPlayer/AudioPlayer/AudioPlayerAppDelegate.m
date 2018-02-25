//
//  AudioPlayerAppDelegate.m
//  AudioPlayer
//
//  Created by William Pirkle on 2/16/12.
//  Copyright (c) 2012 University of Miami. All rights reserved.
//  Edited 2/19/18 by Dr. Bennett

#import "AudioPlayerAppDelegate.h"
#import "AudioPlayerViewController.h"

@implementation AudioPlayerAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 2) create our engine
    self.audioEngine = [AudioEngine alloc];
    
    // 3) init with a file
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"ynq" ofType:@"mp3"];

    // 4) init it
    bool succeeded = [self.audioEngine initAudioPlayerWithFile:musicPath];
    if(!succeeded)
        NSLog(@"initAudioPlayerWithFile FAILED!");

    // 5) create our VC and set as the RootVC
	AudioPlayerViewController *playerViewController = [[AudioPlayerViewController alloc] init];
    
    // 6) set the engine (if it passed)
    if(succeeded)
        playerViewController.audioEngine = self.audioEngine;

    // 7) SHOW IT
    self.window.rootViewController = playerViewController;

    [[self window] makeKeyAndVisible];
    return YES;
}

@end
