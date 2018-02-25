//
//  AudioPlayerAppDelegate.m
//  AudioPlayer
//
//  Created by William Pirkle on 2/16/12.
//  Copyright (c) 2012 University of Miami. All rights reserved.
//  Edited by Dr. Bennett on 02/22/2016
//

#import "AudioPlayerAppDelegate.h"
#import "AudioPlayerViewController.h"

@implementation AudioPlayerAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // create our engine
    self.avEngine = [[AVEngine alloc] initWithBufferSize:4096];
    
    // init with a file
      NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"sin_1000Hz" ofType:@"wav"];
   // NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"ynq" ofType:@"mp3"];

    // init it
    bool succeeded = [self.avEngine startAudioPlayerWithFile:musicPath];
    if(!succeeded)
        NSLog(@"startAudioPlayerWithFile FAILED!");

    // create our VC and set as the RootVC
	AudioPlayerViewController *playerViewController = [[AudioPlayerViewController alloc] init];
    
    // set the engine (if it passed)
    if(succeeded)
        playerViewController.avEngine = self.avEngine;

    self.window.rootViewController = playerViewController;


    [[self window] makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
