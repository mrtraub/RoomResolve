//
//  LineChart1ViewController
//  ChartsDemo
//
//  Created by ALICIA JACKSON on 3/13/16.
//  Copyright © 2016. All rights reserved.
//

#import "LineChart1ViewController.h"


@implementation LineChart1ViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // setup plot manager and attach the chart to it
    _plotter = [[RLPlotManager alloc] initWithChartView:_chartView];

    
    // set to default styling
    [_plotter styleChartForDefault];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (IBAction)setAMPData:(id)sender {
    
///////// This section is just to make up fake data
    NSMutableArray *localXData = [[NSMutableArray alloc] init];
    NSMutableArray *localYDataArray = [[NSMutableArray alloc] init];
    NSMutableArray *localGroupNames = [[NSMutableArray alloc] init];
    
    // 7 visits every 30 days
    for (int i = 0; i < 7; i++)
    {
        [localXData addObject:[@(i*30) stringValue]];
    }
    
    
    // 5 different comparisons
    for (int j=0; j<5; j++)
    {
        NSMutableArray *yVals = [[NSMutableArray alloc] init];
        
        //make up a number with some trend ... just fake data
        for (int i = 0; i < localXData.count; i++)
        {
            [yVals addObject:@((i+1)*arc4random_uniform(10)+10)];
        }
        
        NSString *groupName = [NSString stringWithFormat:@"Group %d", j+1];
        [localGroupNames addObject:groupName];
        [localYDataArray addObject:yVals];

    }
///////////////////////// after this, we have arrays of xdata (dates, here 7), ydata (here, 5 comparisons), and group names
    
    // this is what gets passed down to the plotter
    [_plotter drawChartFor:kChartAMP xData:localXData yDataArray:localYDataArray groupNames:localGroupNames];
}



- (IBAction)showPlots:(id)sender {
    _plotter.shouldHideData=!_showDataSwitch.isOn;
    [_plotter updateChartData]; // maybe override setShouldHideData to include updateChartData
}





@end
