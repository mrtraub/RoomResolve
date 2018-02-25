//
//  AudioPlayerAppDelegate.h
//  AudioPlayer
//
//  Created by William Pirkle on 2/16/12.
//  Copyright (c) 2012 University of Miami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioEngine.h"

@interface AudioPlayerAppDelegate : UIResponder <UIApplicationDelegate>
{
    // 1) our one and only engine object 
    
}

@property AudioEngine *audioEngine;
@property (strong, nonatomic) IBOutlet UIWindow *window;

@end
