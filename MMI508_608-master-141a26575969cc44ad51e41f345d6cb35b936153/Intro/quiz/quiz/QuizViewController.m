//
//  QuizViewController.m
//  quiz
//
//  Created by ALICIA JACKSON on 1/6/16.
//  Copyright © 2016 oygo. All rights reserved.
//

#import "QuizViewController.h"


@implementation QuizViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.model = [[myModel alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)mySliderDidChange:(id)sender {
    
    float roundedVal = [self.model roundFloat:self.mySlider.value];
    
    self.myLabel.text = [[NSString alloc] initWithFormat:@"%f",roundedVal];
    
}
@end
