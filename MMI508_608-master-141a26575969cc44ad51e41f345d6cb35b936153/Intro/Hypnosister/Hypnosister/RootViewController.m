//
//  RootViewController.m
//  Hypnosister
//
//  Created by ALICIA JACKSON on 1/20/16.
//  Copyright © 2016 UM. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
   /*
    // 5b) create a CGRect to init our View with
    CGRect firstFrame = CGRectMake(160, 240, 100, 150);
  
    // 6) create an instance of a UIView
    UIView *firstView = [[UIView alloc] initWithFrame:firstFrame];
    
    // 7) color our new View red
    firstView.backgroundColor = [UIColor redColor];
    
    
    // 8) add our new View to the window
   // WE GET A self.view BY INHERITING FROM UIViewController!
    [self.view addSubview:firstView];
   
    // 9) READY FOR FIRST SIMULATION

   
    // 10) Add a new frame and attach it
    CGRect secondFrame = CGRectMake(1, 1, 50, 50);
    UIView *secondView = [[UIView alloc] initWithFrame:secondFrame];
    secondView.backgroundColor = [UIColor blueColor];
    //[self.view addSubview:secondView];
    
     // 10b) READY FOR SECOND SIMULATION

    
     // 11) remove secondView from root VC, and add to firstView
    [firstView addSubview:secondView];
     
     // 12b) READY FOR THIRD SIMULATION

*/
    
    
    // 13) Next, create a custom UIView Class, called BNRHypnosisView, and import its header in RootViewController.h
    // BLOCK OFF 5-12b AND UNBLOCK 14
    
 
    // 14) Create a thirdView using our new subclass
    CGRect thirdFrame = self.view.bounds;
    BNRHypnosisView *thirdView = [[BNRHypnosisView alloc] initWithFrame:thirdFrame];
    thirdView.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:thirdView];
     
    
    // 14b) READY FOR FOURTH SIMULATION
    
    // 15 a) goto BNRHypnosisView.m and override drawRect
    
    
}


// 33b) set the tab names
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Set the tab bar item's title
        self.tabBarItem.title = @"The Left Button";
        
        // you can also put images in
        // self.tabBarItem.image
    }
    return self;
}


// 34a) do the same thing in ReminderVC


@end
