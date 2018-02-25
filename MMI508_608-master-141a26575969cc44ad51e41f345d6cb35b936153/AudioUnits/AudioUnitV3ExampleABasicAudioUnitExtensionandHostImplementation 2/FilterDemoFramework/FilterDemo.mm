/*
	Copyright (C) 2015 Apple Inc. All Rights Reserved.
	See LICENSE.txt for this sample’s licensing information
	
	Abstract:
	An AUAudioUnit subclass implementing a low-pass filter with resonance. Illustrates parameter management and rendering, including in-place processing and buffer management.
*/

#import "FilterDemo.h"
#import <AVFoundation/AVFoundation.h>
#import "FilterDSPKernel.hpp"
#import "BufferedAudioBus.hpp"

@interface AUv3FilterDemo ()
{
    AUParameter *gainParam;
    AUParameter *panParam;
}

@property AUAudioUnitBus *outputBus;
@property AUAudioUnitBusArray *inputBusArray;
@property AUAudioUnitBusArray *outputBusArray;

@property (nonatomic, readwrite) AUParameterTree *parameterTree;

@end


@implementation AUv3FilterDemo {
	// C++ members need to be ivars; they would be copied on access if they were properties.
    // these provide objective-c wrappers to C++ objects
    FilterDSPKernel _kernel;

    BufferedInputBus _inputBus;
}
@synthesize parameterTree = _parameterTree;

- (instancetype)initWithComponentDescription:(AudioComponentDescription)componentDescription options:(AudioComponentInstantiationOptions)options error:(NSError **)outError {
    self = [super initWithComponentDescription:componentDescription options:options error:outError];

    if (self == nil) {
    	return nil;
    }
	
	// Initialize a default format for the busses.
    AVAudioFormat *defaultFormat = [[AVAudioFormat alloc] initStandardFormatWithSampleRate:44100. channels:2];

	// Create a DSP kernel to handle the signal processing.
	_kernel.init(defaultFormat.channelCount, defaultFormat.sampleRate);
	
    // Create a parameter object for the gain.
    gainParam = [AUParameterTree createParameterWithIdentifier:@"gain"
                                                          name:@"Gain"
                                                       address:FilterParamGain
                                                           min:0.0
                                                           max:1.0
                                                          unit:kAudioUnitParameterUnit_LinearGain
                                                      unitName:nil
                                                         flags:0
                                                  valueStrings:nil
                                           dependentParameters:nil];

	
	// Initialize the parameter values.
    gainParam.value = 1.0;
	_kernel.setParameter(FilterParamGain, gainParam.value);

    
    // Create a AU parameter object for the pan.
    panParam = [AUParameterTree createParameterWithIdentifier:@"pan"
                                                          name:@"Pan"
                                                       address:FilterParamPan
                                                           min:-1.0
                                                           max:1.0
                                                          unit:kAudioUnitParameterUnit_Pan
                                                      unitName:nil
                                                         flags:0
                                                  valueStrings:nil
                                           dependentParameters:nil];
    
    
    // Initialize the parameter values.
    panParam.value = 0.0;
    _kernel.setParameter(FilterParamPan, panParam.value);
    
    
    
	
	// Create the parameter tree.
    _parameterTree = [AUParameterTree createTreeWithChildren:@[
		gainParam,
        panParam//, list more comma separated
	]];

	// Create the input and output busses.
	_inputBus.init(defaultFormat, 8);
    _outputBus = [[AUAudioUnitBus alloc] initWithFormat:defaultFormat error:nil];

	// Create the input and output bus arrays.
	_inputBusArray  = [[AUAudioUnitBusArray alloc] initWithAudioUnit:self busType:AUAudioUnitBusTypeInput  busses: @[_inputBus.bus]];
	_outputBusArray = [[AUAudioUnitBusArray alloc] initWithAudioUnit:self busType:AUAudioUnitBusTypeOutput busses: @[_outputBus]];

	// Make a local pointer to the kernel to avoid capturing self.
	__block FilterDSPKernel *filterKernel = &_kernel;

	// implementorValueObserver is called when a parameter changes value.
	_parameterTree.implementorValueObserver = ^(AUParameter *param, AUValue value) {
		filterKernel->setParameter(param.address, value);
	};
	
	// implementorValueProvider is called when the value needs to be refreshed.
	_parameterTree.implementorValueProvider = ^(AUParameter *param) {
		return filterKernel->getParameter(param.address);
	};
	
	// A function to provide string representations of parameter values.
    // shoudl make as compact as possible
	_parameterTree.implementorStringFromValueCallback = ^(AUParameter *param, const AUValue *__nullable valuePtr) {
		AUValue value = valuePtr == nil ? param.value : *valuePtr;
	
		switch (param.address) {
			case FilterParamGain:
            case FilterParamPan:
				return [NSString stringWithFormat:@"%.2f", value];
			
			default:
				return @"?";
		}
	};

	self.maximumFramesToRender = 512;
	
	return self;
}

#pragma mark - AUAudioUnit Overrides

- (AUAudioUnitBusArray *)inputBusses {
    return _inputBusArray;
}

- (AUAudioUnitBusArray *)outputBusses {
    return _outputBusArray;
}

- (BOOL)allocateRenderResourcesAndReturnError:(NSError **)outError {
	if (![super allocateRenderResourcesAndReturnError:outError]) {
		return NO;
	}
	
    if (self.outputBus.format.channelCount != _inputBus.bus.format.channelCount) {
        if (outError) {
            *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:kAudioUnitErr_FailedInitialization userInfo:nil];
        }
        // Notify superclass that initialization was not successful
        self.renderResourcesAllocated = NO;
        
        return NO;
    }
	
	_inputBus.allocateRenderResources(self.maximumFramesToRender);
	
	_kernel.init(self.outputBus.format.channelCount, self.outputBus.format.sampleRate);
	_kernel.reset();
	
	/*	
		While rendering, we want to schedule all parameter changes. Setting them 
        off the render thread is not thread safe.
	*/
	__block AUScheduleParameterBlock scheduleParameter = self.scheduleParameterBlock;
	
	// Ramp over 20 milliseconds.
	__block AUAudioFrameCount rampTime = AUAudioFrameCount(0.02 * self.outputBus.format.sampleRate);
	
	self.parameterTree.implementorValueObserver = ^(AUParameter *param, AUValue value) {
		scheduleParameter(AUEventSampleTimeImmediate, rampTime, param.address, value);
	};
	
	return YES;
}
	
- (void)deallocateRenderResources {
	[super deallocateRenderResources];
	
	_inputBus.deallocateRenderResources();
	
	// Make a local pointer to the kernel to avoid capturing self.
	__block FilterDSPKernel *filterKernel = &_kernel;

	// Go back to setting parameters instead of scheduling them.
	self.parameterTree.implementorValueObserver = ^(AUParameter *param, AUValue value) {
		filterKernel->setParameter(param.address, value);
	};
}
	
- (AUInternalRenderBlock)internalRenderBlock {
	/*
		Capture in locals to avoid ObjC member lookups. If "self" is captured in
        render, we're doing it wrong.
	*/
	__block FilterDSPKernel *state = &_kernel;
	__block BufferedInputBus *input = &_inputBus;
    
    return ^AUAudioUnitStatus(
			 AudioUnitRenderActionFlags *actionFlags,
			 const AudioTimeStamp       *timestamp,
			 AVAudioFrameCount           frameCount,
			 NSInteger                   outputBusNumber,
			 AudioBufferList            *outputData,
			 const AURenderEvent        *realtimeEventListHead,
			 AURenderPullInputBlock      pullInputBlock)
    
//// start code completion block
    {
		AudioUnitRenderActionFlags pullFlags = 0;

		AUAudioUnitStatus err = input->pullInput(&pullFlags, timestamp, frameCount, 0, pullInputBlock);
		
        if (err != 0) {
			return err;
		}
		
		AudioBufferList *inAudioBufferList = input->mutableAudioBufferList;
		
		/* 
			If the caller passed non-nil output pointers, use those. Otherwise,     
            process in-place in the input buffer. If your algorithm cannot process 
            in-place, then you will need to preallocate an output buffer and use 
            it here.
		*/
		AudioBufferList *outAudioBufferList = outputData;
		if (outAudioBufferList->mBuffers[0].mData == nullptr) {
			for (UInt32 i = 0; i < outAudioBufferList->mNumberBuffers; ++i) {
				outAudioBufferList->mBuffers[i].mData = inAudioBufferList->mBuffers[i].mData;
			}
		}
		
		state->setBuffers(inAudioBufferList, outAudioBufferList);
        // this calls a function that calls 'process()' inside FilterDSPKernel.hpp
		state->processWithEvents(timestamp, frameCount, realtimeEventListHead);

		return noErr;
	};
//// end code completion block
}



- (void) setGainValue:(float)newGain
{
    _kernel.setParameter(FilterParamGain, newGain);
}

- (void) setPanValue:(float)newPan
{
    _kernel.setParameter(FilterParamPan, newPan);
}

@end


