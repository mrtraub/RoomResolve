//
//  Apple.m
//  ProtocolDemo_Simple
//
//  Created by Dave Viggiano on 2/3/16.
//  Copyright © 2016 UM FORE Center. All rights reserved.
//

#import "Apple.h"
#import "ProtocolDefinitions.h"

@implementation Apple

//This is the specifics for an Apple

-(NSString *) getFlavor
{
    return @"Granny-Smithy";
}

-(int) getCalories
{
    return 300;
}

@end
