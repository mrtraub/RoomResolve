//
//  VisualizerView.h
//  iPodVisualizer
//
//  Created by ALICIA JACKSON on 4/11/16.
//  Copyright © 2016 Xinrong Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
//Add with the other imports
#import <AVFoundation/AVFoundation.h>


@interface VisualizerView : UIView

// 23)b. import AVFoundation, and add a pointer to the audioPlayer
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

// 24)a. now need to go back to the VC and make sure that anywhere we setup the audioPlayer, we enable metering and pass a copy to this Visualizer

@end
