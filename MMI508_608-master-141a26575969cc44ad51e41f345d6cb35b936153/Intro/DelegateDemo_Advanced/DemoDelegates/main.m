//
//  main.m
//  DemoDelegates
//
//  Created by Dave Viggiano on 2/3/16.
//  Copyright © 2016 UM FORE Center. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClassThatCallsDelegate.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        ClassThatCallsDelegate *master = [[ClassThatCallsDelegate alloc] init];
        
        [master runTheTest];
        
        sleep(5);
    }
    
    return 0;
}
