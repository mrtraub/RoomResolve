//
//  ClassThatCallsDelegate.h
//  DemoDelegates
//
//  Created by Dave Viggiano on 2/3/16.
//  Copyright © 2016 UM FORE Center. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Delegate1SingleThreaded.h"
#import "Delegate2MultiThreaded.h"
#import "TheAllPowerfulDelegates.h"

@interface ClassThatCallsDelegate : NSObject <CallbackDelegate>

-(void) runTheTest;

@end
