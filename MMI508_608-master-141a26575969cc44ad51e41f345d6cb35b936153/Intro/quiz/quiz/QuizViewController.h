//
//  QuizViewController.h
//  quiz
//
//  Created by ALICIA JACKSON on 1/6/16.
//  Copyright © 2016 oygo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myModel.h"

@interface QuizViewController : UIViewController


// Outlets here
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UISlider *mySlider;

// any other variables
@property (strong, nonatomic) myModel *model;


// Actions here
- (IBAction)mySliderDidChange:(id)sender;




// Other methods here


// test comment here


@end
