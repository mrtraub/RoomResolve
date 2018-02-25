//
//  myModel.m
//  quiz
//
//  Created by ALICIA JACKSON on 1/6/16.
//  Copyright © 2016 oygo. All rights reserved.
//

#import "myModel.h"

@implementation myModel


-(id)init
{
    self = [super init];
    
    if (self)
    {
        self.myNumber = 0;
    }
    
    return self;
}

-(float) roundFloat:(float)fVal
{
    self.myNumber = round(fVal);
    return self.myNumber;
}


@end
