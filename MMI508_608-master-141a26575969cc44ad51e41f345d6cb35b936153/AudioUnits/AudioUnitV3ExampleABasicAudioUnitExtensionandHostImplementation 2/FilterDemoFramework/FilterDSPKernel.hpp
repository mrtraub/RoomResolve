/*
	<samplecode>
		<abstract>
			A DSPKernel subclass implementing the realtime signal processing portion of the FilterDemo audio unit.
		</abstract>
	</samplecode>
*/

#ifndef FilterDSPKernel_hpp
#define FilterDSPKernel_hpp

#import "DSPKernel.hpp"
#import "ParameterRamper.hpp"
#import <vector>

static inline float convertBadValuesToZero(float x) {
	/*
		Eliminate denormals, not-a-numbers, and infinities.
		Denormals will fail the first test (absx > 1e-15), infinities will fail 
        the second test (absx < 1e15), and NaNs will fail both tests. Zero will
        also fail both tests, but since it will get set to zero that is OK.
	*/
		
	float absx = fabs(x);

    if (absx > 1e-15 && absx < 1e15) {
		return x;
	}

    return 0.0;
}


enum {
	FilterParamGain = 0,
	FilterParamPan
};

static inline double squared(double x) {
    return x * x;
}

/*
	FilterDSPKernel
	Performs our filter signal processing.
	As a non-ObjC class, this is safe to use from render thread.
*/
class FilterDSPKernel : public DSPKernel {
public:

    FilterDSPKernel() {}
	
	void init(int channelCount, double inSampleRate) {
		numChans= channelCount;
		sampleRate = float(inSampleRate);
		nyquist = 0.5 * sampleRate;
	}
	
	void reset() {
		// reset and state variables here (eg, filter delays)
        
	}
	
	void setParameter(AUParameterAddress address, AUValue value) {
        switch (address) {
            case FilterParamGain:
				gainRamper.set(clamp(value, 0.0f, 1.0f));
				break;
                
            case FilterParamPan:
                panRamper.set(clamp(value, -1.f, 1.f));
				break;
        }
	}

	AUValue getParameter(AUParameterAddress address) {
        switch (address) {
            case FilterParamGain:
                // Return the goal. It is not thread safe to return the ramping value.
                return gainRamper.goal();

            case FilterParamPan:
                return panRamper.goal();
				
			default: return 0.0f;
        }
	}

	void startRamp(AUParameterAddress address, AUValue value, AUAudioFrameCount duration) override {
        switch (address) {
			case FilterParamGain:
				gainRamper.startRamp(clamp(value, 0.0f, 1.0f), duration);
				break;
			
            case FilterParamPan:
                panRamper.startRamp(clamp(value, -1.f, 1.0f), duration);
                break;
				
		}
	}
	
	void setBuffers(AudioBufferList* inBufferList, AudioBufferList* outBufferList) {
		inBufferListPtr = inBufferList;
		outBufferListPtr = outBufferList;
	}
	
	void process(AUAudioFrameCount frameCount, AUAudioFrameCount bufferOffset) override {
		
        // For each sample.
		for (int frameIndex = 0; frameIndex < frameCount; ++frameIndex) {
			/*
                The filter coefficients are updated every sample! This is very
                expensive. You probably want to do things differently.
            */
			double gain    = double(gainRamper.getStep());
            
            double pan = double(panRamper.getStep());

            int frameOffset = int(frameIndex + bufferOffset);
			
			for (int channel = 0; channel < numChans; ++channel) {

				float* in  = (float*)inBufferListPtr->mBuffers[channel].mData  + frameOffset;
				float* out = (float*)outBufferListPtr->mBuffers[channel].mData + frameOffset;

                
                // put dsp code here
				float x0 = *in;
                float y0 = x0*gain;
                if (channel ==0)
                {
                    // figure out how to apply pan here...
                    float lGain = 1-(pan+1)/2;
                    y0 = y0*lGain;
                }
                if (channel ==1)
                {
                    // figure out how to apply pan here...
                    float rGain = (pan+1)/2;
                    y0 = y0*rGain;
                }
				*out = y0;

			}
		}

	}
	
    // MARK: Member Variables

private:
	
	float sampleRate = 44100.0;
	float nyquist = 0.5 * sampleRate;
    float numChans = 1;
	
	AudioBufferList* inBufferListPtr = nullptr;
	AudioBufferList* outBufferListPtr = nullptr;

public:

	// Parameters.
	ParameterRamper gainRamper = 1.0;
    ParameterRamper panRamper = 0.0;
	
};

#endif /* FilterDSPKernel_hpp */
