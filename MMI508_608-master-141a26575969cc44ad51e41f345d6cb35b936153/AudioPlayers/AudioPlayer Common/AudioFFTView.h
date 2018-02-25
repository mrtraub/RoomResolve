//
//  AudioFFTView.h
//
//  Created on 2/19/2016 by Dr. Bennett.
//


#import <UIKit/UIKit.h>

@interface AudioFFTView : UIView

@property (nonatomic) float* FFTmags;
@property (nonatomic) UIColor* plotColor;
@property (nonatomic) int fftSize;



@end 
