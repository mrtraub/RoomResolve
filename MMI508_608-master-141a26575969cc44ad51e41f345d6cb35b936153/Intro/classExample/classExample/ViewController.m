//
//  ViewController.m
//  classExample
//
//  Created by THE ONE AND ONLY DR. BENNETT on 1/1/18.
//  Copyright © 2018 UM. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.model = [[theRounder alloc] init];
    
}



- (IBAction)sliderValueChanged:(UISlider *)sender {
    
    float sliderVal = [self.theSlider value];
    NSLog(@"sliderVal is %f", sliderVal);
    
// make a call to the Model and send it sliderVal
   // float roundedVal = [self.model roundFloat:sliderVal];
    
//    float roundedVal = [theRounder roundFloat:sliderVal];
    
    self.model.myNumber = sliderVal;
    
    float roundedVal = self.model.myNumber;


    // print the return of the Model to theMainLabel
    self.theMainLabel.text = [[NSString alloc] initWithFormat:@"%f",roundedVal];
    
}
@end
