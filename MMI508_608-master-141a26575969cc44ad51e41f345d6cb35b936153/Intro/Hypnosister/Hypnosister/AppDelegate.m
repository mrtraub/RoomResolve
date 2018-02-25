//
//  AppDelegate.m
//  Hypnosister
//
//  Created by ALICIA JACKSON on 1/14/16.
//  Copyright © 2016 UM. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 4b) add the root VC and attach it to the window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.rootVC = [[RootViewController alloc] init];
    
    
    /*
     31b) alloc-init the reminder vc
    //self.remindVC = [[ReminderViewController alloc] init];
    
    // 32) UITabBarController hold an array of VCs, and present a radio-style selector. Make a UITabBarController, set it to root, and give it the Hypnosis VC and the reminder VC
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[self.rootVC, self.remindVC];
    
    //////////  A QUICK NOTE ON @ LITERALS
    // the @ is the "literal operator" that tidys up complicated statements. For example, you can easily convert a char array to an NSString using the @ literal"
    NSString *myString = @"meow";
    // This is functionally equivalent to:
    NSString *myString2 = [[NSString alloc] initWithUTF8String:"meow"];
    
    NSLog(@"%@ .. %@", myString, myString2);
    
    // These are also handy for quickly making arrays, for example
    NSArray *myArray = @[@1, @2, @3];
    // the outside literal @[...] turns everything inside [..] into an NSObject (in this case an NSArray), and the literals on the inside [@1, @2, @3] also turn each element into an NSObject (in this case an NSNumber)
    
    NSArray *myArray2 = [[NSArray alloc] initWithObjects:[[NSNumber alloc] initWithInt:1],
                                                        [[NSNumber alloc] initWithInt:2],
                                                        [[NSNumber alloc] initWithInt:3],
                                                            nil];
    NSLog(@"%@ ... %@", myArray, myArray2);
    // use whichever you prefer...
    
    // so in the line above: @[self.rootVC, self.remindVC]; tabBarController.viewControllers is expecting an NSArray of view controllers, so we use the @ literal to quickly make that array, which is functionally equivalent to:
    UITabBarController *tabBarController2 = [[UITabBarController alloc] init];
    tabBarController2.viewControllers = [[NSArray alloc] initWithObjects:self.rootVC,self.remindVC, nil];
    
    ///////////
    */
    
    self.window.rootViewController = self.rootVC;
    //self.window.rootViewController = self.remindVC;
    //self.window.rootViewController = tabBarController;
    
    // 33a) Each tab on the tab bar can display a title and an image using a tabBarItem. Update these properties by overriding the designated initializer in RootVC and ReminderVC
    

    [self.window makeKeyAndVisible];
    return YES;
    
    // 5a) go to our RootViewController.m and add our custom View to it
    
    

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
