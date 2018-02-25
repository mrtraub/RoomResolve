//
//  VisualizerView.m
//  iPodVisualizer
//
//  Created by ALICIA JACKSON on 4/11/16.
//  Copyright © 2016. All rights reserved.
//

#import "VisualizerView.h"

#import <QuartzCore/QuartzCore.h>


@implementation VisualizerView {

    
    CAEmitterLayer *emitterLayer;
}

// 12) Overrides render layer to return CAEmitterLayer, which allows this view to act as a particle emitter.
+ (Class)layerClass {
    return [CAEmitterLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor blackColor]];
        emitterLayer = (CAEmitterLayer *)self.layer;
        
        // 13) Shapes the emitter as a rectangle that extends across most of the center of the screen. Particles are initially created within this area.
        CGFloat width = MAX(frame.size.width, frame.size.height);
        CGFloat height = MIN(frame.size.width, frame.size.height);
        emitterLayer.emitterPosition = CGPointMake(width/2, height/2);
        emitterLayer.emitterSize = CGSizeMake(width-80, 60);
        emitterLayer.emitterShape = kCAEmitterLayerRectangle;
        emitterLayer.renderMode = kCAEmitterLayerAdditive;
        
        // 14) Creates a CAEmitterCell that renders particles using particleTexture.png (included in Resources)
        CAEmitterCell *cell = [CAEmitterCell emitterCell];
        cell.name = @"cell";
        CAEmitterCell *childCell = [CAEmitterCell emitterCell];
        childCell.name = @"childCell";
        childCell.lifetime = 1.0f / 60.0f;
        childCell.birthRate = 60.0f;
        childCell.velocity = 0.0f;
        childCell.contents = (id)[[UIImage imageNamed:@"particleTexture.png"] CGImage];
        
        cell.emitterCells = @[childCell];
        
        // 15) Sets the particle color, along with a range by which each of the red, green, and blue color components may vary.
        cell.color = [[UIColor colorWithRed:1.0f green:0.53f blue:0.0f alpha:0.8f] CGColor];
        cell.redRange = 0.46f;
        cell.greenRange = 0.49f;
        cell.blueRange = 0.67f;
        cell.alphaRange = 0.55f;
        
        // 16) Sets the speed at which the color components change over the lifetime of the particle.
        cell.redSpeed = 0.11f;
        cell.greenSpeed = 0.07f;
        cell.blueSpeed = -0.25f;
        cell.alphaSpeed = 0.15f;
        
        // 17) Sets the scale and the amount by which the scale can vary for the generated particles.
        cell.scale = 0.5f;
        cell.scaleRange = 0.5f;
        
        // 18) Sets the amount of time each particle will exist to between .75 and 1.25 seconds, and sets it to create 80 particles per second.
        cell.lifetime = 1.0f;
        cell.lifetimeRange = .25f;
        cell.birthRate = 80;
        
        // 19) Configures the emitter to create particles with a variable velocity, and to emit them in any direction.
        cell.velocity = 100.0f;
        cell.velocityRange = 300.0f;
        cell.emissionRange = M_PI * 2;
        
        // 20) Adds the emitter cell to the emitter layer.
        emitterLayer.emitterCells = @[cell];
        
        // 21)a. go back to ViewController.m and add this VisualizerView
        
        
        // 26)b. CADisplayLink is a timer that allows your application to synchronize its drawing to the refresh rate of the display.
       // CADisplayLink *dpLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        
        // ( think of this as starting the timer. if you want to read more about run loops, see: http://apple.co/1VkHi4g )
      //  [dpLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        // RUN!
    }
    return self;
}


// 25) Each time update is called, it changes the size of the visualizer’s particles based on the level of the audio.
/*
- (void)update
{
    // 25)a. You set scale to a default value of 0.5 and then check to see whether or not _audioPlayer is playing.
    float scale = 0.5;
    if (_audioPlayer.playing )
    {
        // 25)b. If it is playing, you call updateMeters on _audioPlayer, which refreshes the AVAudioPlayer data based on the current audio.
        [_audioPlayer updateMeters];
        
        // 25)c. This is the meat of the method. For each audio channel (e.g. two for a stereo file), the average power for that channel is accumulate. After the levels of all the channels have been added together, level is divided by the number of channels.
        float power = 0.0f;
        float level = 0.0f;
        for (int i = 0; i < [_audioPlayer numberOfChannels]; i++) {
            power = [_audioPlayer averagePowerForChannel:i];
            level += pow(10, power/20);
        }
        level /= [_audioPlayer numberOfChannels];
        
        // scale up to match an appropriate particle size
        scale = fmax(scale, level * 5);
    }
    
    // 25)d. Finally, the scale of the emitter’s particles is set to the new scale value. (If _audioPlayer was not playing, this will be the default scale of 0.5; otherwise, it will be some value based on the current audio levels.
    [emitterLayer setValue:@(scale) forKeyPath:@"emitterCells.cell.emitterCells.childCell.scale"];
    
    // Particles are created and destroyed at the same rate as a screen refresh. That means that every time the screen is redrawn, a new set of particles is created and the previous set is destroyed. Since new particles are always created with a size calculated from the audio-levels at that moment, the particles appear to pulse with the music.
    
    
    // 26)a. make a call to update inside initWithFrame
}
 */

@end