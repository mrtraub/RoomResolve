//
//  theRounder.h
//  classExample
//
//  Created by THE ONE AND ONLY DR. BENNETT on 1/1/18.
//  Copyright © 2018 UM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface theRounder : NSObject

{
    float _myNumber;
}


// we need a method for receiving a float and returning a rounded float


@property (nonatomic) float myNumber;


-(float) roundFloat:(float)fVal;
+(float) roundFloat:(float)fVal;


@end
