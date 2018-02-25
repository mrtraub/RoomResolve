//
//  LineChart1ViewController
//  ChartsDemo
//
//  Created by ALICIA JACKSON on 3/13/16.
//  Copyright © 2016. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RLPlotManager.h"
#import <Charts/Charts.h>


@interface LineChart1ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UISwitch *showDataSwitch;
@property (nonatomic, strong) IBOutlet LineChartView *chartView;
@property (nonatomic, strong) RLPlotManager* plotter;

- (IBAction)setAMPData:(id)sender;
- (IBAction)showPlots:(id)sender;


@end
