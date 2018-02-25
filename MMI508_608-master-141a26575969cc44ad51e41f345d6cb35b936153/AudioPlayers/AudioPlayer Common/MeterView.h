//
//  MeterView.h
//  iPhoneAudio
//
//  Created by willpirkle on 4/15/11.
//  Copyright 2011 University of Miami. All rights reserved.
//  Edited by Dr. Bennett on 2/4/2016

#import <UIKit/UIKit.h>


@interface MeterView : UIView 


- (void)updateMeter:(float)fdB;
- (void)clearMeter;

@end
