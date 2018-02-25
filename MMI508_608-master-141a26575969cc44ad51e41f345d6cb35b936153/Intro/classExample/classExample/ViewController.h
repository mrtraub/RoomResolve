//
//  ViewController.h
//  classExample
//
//  Created by THE ONE AND ONLY DR. BENNETT on 1/1/18.
//  Copyright © 2018 UM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "theRounder.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISlider *theSlider;
@property (strong, nonatomic) IBOutlet UILabel *theMainLabel;


@property theRounder *model;



- (IBAction)sliderValueChanged:(UISlider *)sender;



@end
