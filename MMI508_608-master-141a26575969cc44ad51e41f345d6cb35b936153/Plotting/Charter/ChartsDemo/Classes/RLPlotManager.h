//
//  RLPlotManager.h
//  ChartsDemo
//
//  Created by ALICIA JACKSON on 3/14/16.
//  Copyright © 2016. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Charts/Charts-Swift.h"
#import <Charts/Charts.h>

@interface RLPlotManager : NSObject<ChartViewDelegate>


typedef enum {
    kChartAMP,
    kChartTUG,
    kChart6MWT
} ChartStyle;



@property (nonatomic, assign) BOOL shouldHideData;

- (id) initWithChartView:(LineChartView*)chartview;
- (void)updateChartData;
- (void)styleChartForDefault;
- (void) drawChartFor:(ChartStyle)chartstyle
                xData:(NSMutableArray*)xdata
           yDataArray:(NSMutableArray*)ydata
           groupNames:(NSMutableArray*)groupnames;


@end
