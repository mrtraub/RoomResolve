//
//  AppDelegate.h
//  iPodVisualizer
//
//  Created by Xinrong Guo on 13-3-30.
//  Copyright (c) 2013年 Xinrong Guo. All rights reserved.
//

// 1) First, we want to include AVFoundation, so select the iPodVisualizer under TARGETS. Choose the Build Phases tab, expand the Link Binary With Libraries section, then click the + (plus) button. Search for AVFoundation.framework in the pop up list, select it, and click Add.

// 2)a. go to ViewController.m




// 11) Create a custom View to be our cool visualizer. First, add the QuartzCore.framework to your project. Next, make a new cocoa class called VisualizerView, and make it a subclass of UIView. 

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
