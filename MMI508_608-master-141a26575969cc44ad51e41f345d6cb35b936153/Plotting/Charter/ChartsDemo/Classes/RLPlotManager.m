//
//  RLPlotManager.m
//  ChartsDemo
//
//  Created by ALICIA JACKSON on 3/14/16.
//  Copyright © 2016. All rights reserved.
//

#import "RLPlotManager.h"


@interface RLPlotManager () 

@property (nonatomic, strong) NSMutableArray *colorList;
@property (nonatomic, strong) NSMutableArray *xData;
@property (nonatomic, strong) NSMutableArray *yDataArray;
@property (nonatomic, strong) LineChartView *chartView;

@end



@implementation RLPlotManager


- (id)initWithChartView:(LineChartView*)chartview
{
    self = [super init];
    if (self)
    {
        _yDataArray = [[NSMutableArray alloc] init];
        _xData = [[NSMutableArray alloc] init];
        _chartView = chartview;
        _chartView.delegate = self;
    }
    return self;
}



- (void)styleChartForDefault
{
    // no-data text description
    _chartView.noDataTextDescription = @"You need to provide data for the chart.";
    
    // sizing and scaling settings
    _chartView.dragEnabled = YES;
    [_chartView setScaleEnabled:YES];
    _chartView.pinchZoomEnabled = YES;
    _chartView.drawGridBackgroundEnabled = YES;
    
    // set the axis properties
    // maybe we turn this on if we do multiple outcomes or comparisons
    _chartView.rightAxis.enabled = NO;
    
    _chartView.leftAxis.customAxisMax = 10;
    _chartView.leftAxis.customAxisMin = 0;
    _chartView.leftAxis.gridLineDashLengths = @[@5.f, @5.f];
    _chartView.leftAxis.drawZeroLineEnabled = YES;
    _chartView.leftAxis.drawLimitLinesBehindDataEnabled = YES;
    

    // set the legend
    _chartView.legend.form = ChartLegendFormLine;
    
    // setup the list of colors to plot with (right now only 10 ... what to do for more?)
    _colorList= [[NSMutableArray alloc] init];
    [_colorList addObject:UIColor.redColor];
    [_colorList addObject:UIColor.blueColor];
    [_colorList addObject:[UIColor orangeColor]];
    [_colorList addObject:[UIColor greenColor]];
    [_colorList addObject:[UIColor purpleColor]];
    [_colorList addObject:[UIColor yellowColor]];
    [_colorList addObject:[UIColor brownColor]];
    [_colorList addObject:[UIColor cyanColor]];
    [_colorList addObject:[UIColor grayColor]];
    [_colorList addObject:[UIColor magentaColor]];
    
    
    [self updateChartData];
    
}

- (void) drawChartFor:(ChartStyle)chartstyle xData:xdata yDataArray:ydataarray groupNames:groupnames
{
    // set the background chart area and line properties
    [self styleChartFor:chartstyle];
    
    // clear out all current arrays
    [_yDataArray removeAllObjects];
    [_xData removeAllObjects];
    
    // assign new values
    _xData = xdata;
    
    for (int j=0; j<[ydataarray count]; j++)
    {
        NSMutableArray *yVals = [[NSMutableArray alloc] init];
        for (int i=0; i<[xdata count]; i++)
        {
            [yVals addObject:[[ChartDataEntry alloc] initWithValue:[[ydataarray[j] objectAtIndex:i] floatValue] xIndex:i]];
        }
        LineChartDataSet *set = [[LineChartDataSet alloc] initWithYVals:yVals label:groupnames[j]];
        [_yDataArray addObject:set];
    }
    
    
    [self updateChartData];
}


- (void)styleChartFor:(ChartStyle)newStyle
{
    // first reset to default
    [self styleChartForDefault];
    
    // define some properties we may want to set
    NSString *title=@"";
    NSDictionary *horizontalBars = [[NSDictionary alloc] init];
    int minVal, maxVal;
    
    // based on the style, apply some specific properties
    switch (newStyle) {
            
        case kChartAMP:
            // set AMP specific styling here
            title = @"AMP Score";
            horizontalBars = @{ @"K1" :  @10,
                                @"K2" :  @25,
                                @"K3" :  @40,
                                @"K4" :  @55};
            minVal = 0;
            maxVal = 100;
            break;
            
        case kChartTUG:
            // set TUG specific styling here
            title = @"TUG Time";
            horizontalBars = @{ @"Fast" :  @9,
                                @"Slow" :  @18};
            minVal = 0;
            maxVal = 25;
            break;
            
        case kChart6MWT:
            // set 6MWT specific styling here
            title = @"6MWT Distance";
            horizontalBars = @{ @"K1" :  @100,
                                @"K2" :  @200,
                                @"K3" :  @300,
                                @"K4" :  @400};
            maxVal= 500;
            minVal = 0;
            break;
            
        default:
            break;
    }
    
    
    // set description text (clear it out because it seems not-needed right now, but instead of changing the title of the page, this description could be set with the name of the test)
    _chartView.descriptionText = title;
    
    // apply min and max range
    _chartView.leftAxis.customAxisMax = maxVal;
    _chartView.leftAxis.customAxisMin = minVal;
    
    // draw horizontal Bars
    for (id bar in horizontalBars) {
        
        ChartLimitLine *ll = [[ChartLimitLine alloc] initWithLimit:[[horizontalBars objectForKey:bar] floatValue] label:bar];
        ll.lineWidth = 2.0;
        ll.lineDashLengths = @[@5.f, @5.f];
        ll.labelPosition = ChartLimitLabelPositionRightBottom;
        ll.valueFont = [UIFont systemFontOfSize:10.0];
        
        [_chartView.leftAxis addLimitLine:ll];
    }
    
    [self updateChartData];
}




- (void)updateChartData
{
    if (self.shouldHideData)
    {
        _chartView.data = nil;
        return;
    }
    
    // style each of the data sets to be drawn - this is different from the chart styler that sets axis, grid, and background propeties
    // these are the actual drawn lines
    int i=0;
    for (LineChartDataSet *thisSet in _yDataArray)
    {
        thisSet.lineWidth = 2;
        [thisSet setColor:_colorList[i]];   // pick a new color from a list
        [thisSet setCircleColor:_colorList[i]];
        thisSet.circleRadius = 4.0;
        thisSet.drawCircleHoleEnabled = NO;
        thisSet.valueFont = [UIFont systemFontOfSize:9.f];
        i++;
    }
    
    
    // plot!
    LineChartData *data = [[LineChartData alloc] initWithXVals:_xData dataSets:_yDataArray];
    _chartView.data = data;
    [_chartView animateWithXAxisDuration:0.5 easingOption:ChartEasingOptionLinear];
    
    [_chartView setNeedsDisplay];
}


#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * __nonnull)highlight
{
    
    NSLog(@"on day %ld a score of %f", (long)entry.xIndex, entry.value);

}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"deSelected");
}





@end
