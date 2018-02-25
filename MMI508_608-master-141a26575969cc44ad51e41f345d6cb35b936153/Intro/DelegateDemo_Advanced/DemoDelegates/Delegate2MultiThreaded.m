//
//  MultithreadedClassWithDelegate.m
//  DemoDelegates
//
//  Created by Dave Viggiano on 2/3/16.
//  Copyright © 2016 UM FORE Center. All rights reserved.
//

#import "Delegate2MultiThreaded.h"

@implementation Delegate2MultiThreaded

-(id) init
{
    self = [super init];
    
    NSLog(@"Worker: I'm inited, ready to go");
    
    return self;
}

-(void) doWorkAndReportBackTo:(id<CallbackDelegate>)delegate
{
    NSLog(@"Worker: I don't want the master to wait for me, so I'll just push the workload off to another thread");
    
    [NSThread detachNewThreadSelector:@selector(internalWorkMethod:) toTarget:self withObject:delegate];
}

-(void) internalWorkMethod:(id<CallbackDelegate>)delegate
{
    NSLog(@"Worker: Let's do some work!");
    
    sleep(3);
    
    NSLog(@"Worker: Okay, the work is done, letting the delegate know");
    
    [delegate doneDoingWork:@"Yippee!"];
}

@end
