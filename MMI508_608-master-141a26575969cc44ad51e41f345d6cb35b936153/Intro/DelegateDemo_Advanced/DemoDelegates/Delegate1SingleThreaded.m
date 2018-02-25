//
//  ClassWithDelegate.m
//  DemoDelegates
//
//  Created by Dave Viggiano on 2/3/16.
//  Copyright © 2016 UM FORE Center. All rights reserved.
//

#import "Delegate1SingleThreaded.h"


@implementation Delegate1SingleThreaded

-(id) init
{
    self = [super init];
    
    NSLog(@"Worker: I'm inited, ready to go");
    
    return self;
}

-(void) doWorkAndReportBackTo:(id<CallbackDelegate>)delegate
{
    NSLog(@"Worker: Let's do some work!");
    
    sleep(3);
    
    NSLog(@"Worker: Okay, the work is done, letting the delegate know");
    
    [delegate doneDoingWork:@"Yippee!"];
}

@end
