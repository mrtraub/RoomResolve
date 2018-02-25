//
//  AVEngine.mm
//  Created by Dr. Bennett on 2/16/2016
//

#import "AVEngine.h"

@interface AVEngine()
{
    COMPLEX_SPLIT FFTData;
}

// FFT properties

@property (nonatomic) float* hammingWindow;
@property (nonatomic) float* windowedBuffer;

@end

@implementation AVEngine

// default initializer
- (id)initWithBufferSize:(int)bufferSize
{
	self = [super init];
    if (self) 
	{
        // lets set the fftsize
        _N = bufferSize;
        
        // and alloc-init the magnitudes array
        self.FFTmags = (float*) calloc(self.N/2, sizeof(float));
		
		// end init
    }
	
    return self;
}

// give me a file path, I load my player and queue it up!
- (BOOL)startAudioPlayerWithFile:(NSString *)audioFilePath
{
    if(audioFilePath)
	{
        
        
        
        // 0) start up audio session
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *error = nil;
        BOOL success = NO;
        
        success = [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
        if(error || !success){
            NSLog(@"set Audio Session Category Fail :%@", error);
        }
        
        success = [session setPreferredSampleRate:44100.0 error:&error];
        if(error || !success){
            NSLog(@"set Preferred sample rate Fail :%@", error);
        }
        
        error = nil;
        success = [session setPreferredIOBufferDuration:self.N/44100.0 error:&error];
        if(error || !success){
            NSLog(@"set Preferred IO Buffer Duration Fail :%@", error);
        }
        
        error = nil;
        success = [session setActive:YES error:&error];
        if(error || !success){
            NSLog(@"Activated Fail :%@", error);
        }
        
        // register for interruptions with notification center
        
        
		// 1) load in file
		NSURL *url = [NSURL fileURLWithPath:audioFilePath];
        AVAudioFile *file = [[AVAudioFile alloc] initForReading:url error:nil];
        
        // 2) load engine and player and attach
        self.engine = [[AVAudioEngine alloc] init];
        self.player = [[AVAudioPlayerNode alloc] init];
        [self.engine attachNode:self.player];
        
        // 3) create delay and attach
        self.delay = [[AVAudioUnitDelay alloc] init];
        self.delay.delayTime = 0;
        self.delay.feedback = 25;
        self.delay.lowPassCutoff = 1000;
        self.delay.wetDryMix = 50;
        [self.engine attachNode:self.delay];
        
        // 4) create distortion and attach
        self.distortion = [[AVAudioUnitDistortion alloc] init];
        self.distortion.preGain=-6;
        self.distortion.wetDryMix = 75;
        [self.engine attachNode:self.distortion];
        

        
        
        // 6) FFT Setup - You should do this once, and keep these variables for subsequent FFTs.
        UInt32 log2N          = log2f(self.N);
        FFTSetup FFTSettings  = vDSP_create_fftsetup(log2N, kFFTRadix2);
        
        FFTData.realp    = (float *) malloc(sizeof(float) * self.N/2);
        FFTData.imagp    = (float *) malloc(sizeof(float) * self.N/2);
        
        
        // 7) setup windowing
        self.hammingWindow = (float *) malloc(sizeof(float) * self.N);
        vDSP_hamm_window(self.hammingWindow, self.N, 0);
        self.windowedBuffer = (float *) malloc(sizeof(float) * self.N);
        
       
        // 8) install a tap
        [self.distortion installTapOnBus:0 bufferSize:self.N format:file.processingFormat block:^(AVAudioPCMBuffer* buffer, AVAudioTime* when) {

            // make sure there is something to process
            if (buffer == NULL)
                return;
            
            // FFT Time ----------
            vDSP_vmul(*(buffer.floatChannelData), 1, self.hammingWindow, 1, self.windowedBuffer, 1, self.N);
            
            // Converting data into split complex form
            vDSP_ctoz((COMPLEX *) self.windowedBuffer, 2, &(FFTData), 1, self.N/2);
            
            // Doing the FFT
            vDSP_fft_zrip(FFTSettings, &(FFTData), 1, log2N, kFFTDirection_Forward);
            
            // get magnitude response
            vDSP_zvabs(&(FFTData), 1, self.FFTmags, 1, self.N/2);
            
        }];
        

        
        
        
        // 5) make connections
        [self.engine connect:self.player to:self.distortion format:file.processingFormat];
        [self.engine connect:self.distortion to:self.delay format:file.processingFormat];
        [self.engine connect:self.delay to:self.engine.outputNode format:file.processingFormat];
        
        // schedule players
        [self.player scheduleFile:file atTime:nil completionHandler:nil];
        
        // prepare engine
        [self.engine prepare];
        [self.engine startAndReturnError:nil];
        
        // rockin
        return YES;
	}
    
    // fail
    return NO;
}

// handle interruptsion here


- (void)startAudioPlayer
{
    // start it
    
    [self.player play];
}

- (void)stopAudioPlayer
{
    [self.player pause];
    
}


@end