//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by ALICIA JACKSON on 1/21/16.
//  Copyright © 2016 UM. All rights reserved.
//

#import "BNRHypnosisView.h"



@implementation BNRHypnosisView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    
    self.myRect = rect;
    
    NSLog(@"redraw!");
    // Drawing code
    
    // 15b) get the bounds of our drawing area
    CGRect bounds = self.bounds;
    
    // 16) determine center and radius of a circle
    CGPoint center;
    center.x = bounds.origin.x+bounds.size.width/2.f;
    center.y = bounds.origin.y+bounds.size.height/2.f;
    float radius = MIN(bounds.size.width, bounds.size.height) /2.f;
    
    
    // 17) use Utilitize Pane > Quick Help to see about Bezier paths
 
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:0
                                                      endAngle:2*M_PI
                                                     clockwise:YES];
    
 
    // 18) add some properties to the path
    path.lineWidth = 10;

    
    // 19) add some properties to the stroke
    // Sets the color property **of subsequent stroke operations** to the color that the receiver represents.
    // [[UIColor lightGrayColor] setStroke];
    
    // run Simulation
    
    // now go to top of file...
    
 
    // 22) lets use out new property to setStroke (comment out line above)
     [self.circleColor setStroke];
 
    
    // Draws a line along the receiver’s path **using the current drawing properties**.
    [path stroke];
    
}




// 21) override initWithFrame
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    // let's make the default value blue
    self.circleColor = [UIColor blueColor];

    return self;
}



// 23) override touchEvents
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched", self);
    
 
    // Get 3 random numbers between 0 and 1
    // arc4number returns a pseudo-random number in the range of 2^32
    float red = (arc4random()  / (2^32-1));
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    UIColor *randomColor = [UIColor colorWithRed:red
                                           green:green
                                            blue:blue
                                           alpha:1.0];
    

    self.circleColor = randomColor;

    
    // 24) RUN SIMULATION!!!
    // what happened to the color? Why doesn't it draw?
    // Need to let the drawing layer know that some visual property has changed
}




// 25) override the set function of circleColor
- (void)setCircleColor:(UIColor *)newCircleColor
{
    // normally, our i-var would be set by using a property
    // here, we must manually set it
    _circleColor = newCircleColor;
    
    // indicate that we need to redraw!
    [self setNeedsDisplay];
  //  [self drawRect:self.myRect];
}

  
  // 26) create a new class called ReminderViewController:UIViewController with Xib
  // 27a) add a datePicker and provide it an IBOutlet in ReminderViewController



@end
