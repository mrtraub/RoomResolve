//
//  EQCalculatorAppDelegate.m
//  EQCalculator
//
//  Created by willpirkle on 12/22/10.
//  Copyright 2010 University of Miami. All rights reserved.
//
//  Edited by Chris Bennett on 1/6/16

#import "EQCalculatorAppDelegate.h"

@implementation EQCalculatorAppDelegate


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // A UIScreen object defines the properties associated with a hardware-based display. iOS devices have a main screen and zero or more attached screens. Use this class to obtain screen objects for each display attached to the device. Each screen object defines the bounds rectangle for the associated display and other interesting properties such as its brightness.
    // The UIWindow class defines an object known as a window that manages and coordinates the views an app displays on a device screen. Unless an app can display content on an external device screen, an app has only one window.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // create our VC and set as the RootVC
    self.rootVC = [[EQViewController alloc] init];
    [self.window setRootViewController:self.rootVC];
    
    // visibilize
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}



@end
