//
//  AudioPlayerAppDelegate.h
//  AudioPlayer
//
//  Created by William Pirkle on 2/16/12.
//  Copyright (c) 2012 University of Miami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVEngine.h"

@interface AudioPlayerAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) AVEngine *avEngine;

@property (strong, nonatomic) IBOutlet UIWindow *window;

@end
