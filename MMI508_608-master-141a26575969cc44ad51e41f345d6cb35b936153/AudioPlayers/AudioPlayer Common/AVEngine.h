//
//  AVEngine.mm
//  Created by Dr. Bennett on 2/16/2016
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Accelerate/Accelerate.h>



@interface AVEngine : NSObject


// default initializer
- (id)initWithBufferSize:(int) bufferSize;

- (BOOL)startAudioPlayerWithFile:(NSString *)audioFilePath;

// start/stop functions; if you have multuple players you need to index them
- (void)startAudioPlayer;
- (void)stopAudioPlayer;

@property (strong, nonatomic) AVAudioEngine* engine;
@property (strong, nonatomic) AVAudioPlayerNode* player;
@property (strong, nonatomic) AVAudioUnitDelay* delay;
@property (strong, nonatomic) AVAudioUnitDistortion* distortion;


// public fft properties
@property (nonatomic, readonly) UInt32 N;
@property (nonatomic) float* FFTmags;


@end







