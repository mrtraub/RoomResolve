//
//  BNRItem.h
//  RandomItems
//
//  Created by Christopher Bennett on 1/7/16.
//  Copyright © 2016 FORECenter. All rights reserved.
//

#import <Foundation/Foundation.h>



// 5b) The interface goes in the header, and it prototypes all of the Class members (properties, methods, variables, etc.)
@interface BNRItem : NSObject
//                 ^ the class after the : is the super class name



// 6) Class variables could go here in between these curly brackets, but really any variables could (and should) be properties
{
    
}

// 7) add a few properties (compiler automatically create getter and setter functions)
@property NSString *itemName;
@property NSString *serialNumber;
@property int valueInDollars;
@property NSDate *dateCreated;

 // 8a) goto main.m and incldue this header file


// 14b) Create a new initializer that takes in arguments
- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber;
//     ^
//     |----- an init always returns an instancetype, and it returns the Class type (here returns a BNRItem)

// We pick one of the initializers to be the "designated initializer"

// 15a) Now define initWithItemName: valueInDollars: serialNumber: in BNRItem.m

 


@end
