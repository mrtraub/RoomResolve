//
//  ClassThatCallsDelegate.m
//  DemoDelegates
//
//  Created by Dave Viggiano on 2/3/16.
//  Copyright © 2016 UM FORE Center. All rights reserved.
//

#import "ClassThatCallsDelegate.h"

@implementation ClassThatCallsDelegate

-(void) runTheTest
{
    bool multiThreaded = false;
    
    NSLog(@"Master: Creating the worker");
    
    id<GenericWorker> worker = nil;
    
    if(multiThreaded)
    {
        worker = [[Delegate2MultiThreaded alloc] init];
    }
    else
    {
        worker = [[Delegate1SingleThreaded alloc] init];
    }
    
    NSLog(@"Master: Telling worker to get to work");
    [worker doWorkAndReportBackTo:self];
    
    NSLog(@"Master: Done telling the worker to work, but did it actually do the work yet?");
}

-(void) doneDoingWork:(NSString *)message
{
    NSLog(@"Master: Worker finished, here's the message: %@", message);
}

@end
