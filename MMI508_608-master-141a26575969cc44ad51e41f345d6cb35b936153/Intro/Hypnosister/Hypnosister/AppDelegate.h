//
//  AppDelegate.h
//  Hypnosister
//
//  Created by ALICIA JACKSON on 1/14/16.
//  Copyright © 2016 UM. All rights reserved.
//

#import <UIKit/UIKit.h>
// 2b) include our root VC class
#import "RootViewController.h"

// 30bi) import and add a property
#import "ReminderViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// 3) add a property for the root VC
@property (strong, nonatomic) RootViewController *rootVC;

// 30bii)
@property (strong) ReminderViewController *remindVC;

// 31a) alloc-init the remind VC in the @implementation


// 4a) goto AppDelegate.m and add the root VC


@end

