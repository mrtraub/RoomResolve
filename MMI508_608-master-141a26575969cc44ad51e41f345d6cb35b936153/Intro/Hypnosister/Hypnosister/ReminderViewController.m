//
//  ReminderViewController.m
//  Hypnosister
//
//  Created by ALICIA JACKSON on 2/1/16.
//  Copyright © 2016 UM. All rights reserved.
//

#import "ReminderViewController.h"

@interface ReminderViewController ()

//27b) add an IBOutlet for the datePicker
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation ReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


//28) add an IBAction for the datePicker
- (IBAction)addReminder:(id)sender {
    
    //29) grab the date and print it to log
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@", date);
}

// 30a) add a reminder VC to the app delegate


// 31b)
/*
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        // Give the tab bar item a label
        self.tabBarItem.title = @"Reminder";

    }
    return self;
}
*/



// 32) each time the Reminder View will appear, set the minimum selectable date to a minute in the future
/*
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}
*/


// PLEASE READ CHAPTER 6, Sections:
// "Interacting with View Controllers and Their Views" pg. 138
// and
// "For the More Curious: Key-Value Coding" pgs. 138-139


@end
