//
//  FilterDemoViewController.h
//  AudioUnitV3Example
//
//  Created by ALICIA JACKSON on 3/3/16.
//
//

#import <UIKit/UIKit.h>
#import <CoreAudioKit/CoreAudioKit.h>
#import <FilterDemoFramework/FilterDemo.h>

@interface FilterDemoViewController : AUViewController<AUAudioUnitFactory>

@property (nonatomic, strong) AUv3FilterDemo* audioUnit;

// CB: figure out what this is for
@property (nonatomic, strong) AUParameter* gainParameter;
@property (nonatomic, strong) AUParameter* panParameter;

@property (nonatomic) AUParameterObserverToken parameterObserverToken;



@end
