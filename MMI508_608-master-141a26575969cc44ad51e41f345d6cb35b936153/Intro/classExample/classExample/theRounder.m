//
//  theRounder.m
//  classExample
//
//  Created by THE ONE AND ONLY DR. BENNETT on 1/1/18.
//  Copyright © 2018 UM. All rights reserved.
//

#import "theRounder.h"

@implementation theRounder


-(instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.myNumber = 0;
    }
    
    return self;
}


-(float) myNumber
{
    return roundf(_myNumber);
}

-(void) setMyNumber:(float)whatever
{
    NSLog(@"hey gius i am setting a number");
    _myNumber=whatever;
}



-(float) roundFloat:(float)fVal
{
    self.myNumber = roundf(fVal);
    NSLog(@"myNumber is %f", self.myNumber);
    return self.myNumber;
}


+(float) roundFloat:(float)fVal
{
    
    return roundf(fVal);
    
}



@end
