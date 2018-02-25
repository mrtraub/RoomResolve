//
//  EQCalculatorAppDelegate.h
//  EQCalculator
//
//  Created by willpirkle on 12/22/10.
//  Copyright 2010 University of Miami. All rights reserved.
//  Edited by Chris Bennett on 11/20/15.

#import <UIKit/UIKit.h>

// our only VC
#import "EQViewController.h"

@interface EQCalculatorAppDelegate : UIResponder

<UIApplicationDelegate>

@property (strong, nonatomic)  UIWindow *window;
@property (strong, nonatomic) EQViewController *rootVC;



@end

