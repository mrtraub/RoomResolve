//
//  BNRItem.m
//  RandomItems
//
//  Created by Christopher Bennett on 1/7/16.
//  Copyright © 2016 FORECenter. All rights reserved.
//

#import "BNRItem.h"



@implementation BNRItem



// 13) override the description method (from NSObject) to return something more meaningful
- (NSString *) description
{
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@" %@ (%@): Worth $%d, recorded on %@",
     self.itemName,
     self.serialNumber,
     self.valueInDollars,
     self.dateCreated];
    
    return descriptionString;
                                   
}


// 15b)
- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber
{
    // first call superclass's init, which returns an instance
    self = [super init];
    
    // if this succeeds, lets fill out some properties
    if (self) {
        self.itemName = name;
        self.serialNumber = sNumber;
        self.valueInDollars = value;
        self.dateCreated = [[NSDate alloc] init];
    }
    
    // return an instance of self, which is a BNRItem
    return self;
}


// 16) be sure to modify the init to call our designated initializer
- (instancetype)init{
    return [self initWithItemName:@"" valueInDollars:0 serialNumber:@""];
}

 
 
 


@end
