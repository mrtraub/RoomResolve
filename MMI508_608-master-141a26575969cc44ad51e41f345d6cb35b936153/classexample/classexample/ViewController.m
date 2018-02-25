//
//  ViewController.m
//  classexample
//
//  Created by Christopher Bennett on 1/30/18.
//  Copyright © 2018 Christopher Bennett. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *mainLabel;
@property (strong, nonatomic) IBOutlet UISlider *theSlider;
- (IBAction)sliderChanged:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sliderChanged:(id)sender {
    
    float sliderVal = self.theSlider.value;
    
    self.mainLabel.text = [[NSString alloc] initWithFormat:@"%f", sliderVal];
    
}
@end
