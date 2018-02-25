//
//  MasterClass.m
//  ProtocolDemo_Simple
//
//  Created by Dave Viggiano on 2/3/16.
//  Copyright © 2016 UM FORE Center. All rights reserved.
//

#import "MasterClass.h"

@implementation MasterClass

/*
 
 The real power of protocols is the ability to treat similar items generically
 In this example we define an Apple and a Banana, but they share a common set of methods as defined by EdibleProtocol
 
 So later, we can write code that knows how to handle edible food,
    and doesn't care (or know!) whether it's an Apple or a Banana
 
 This is a powerful concept that allows us to treat different object types similarly!
 
 */

-(void) runDemo
{
    //First, we create an Apple and a Banana, both of which are edible (conform to EdibleProtocol)
    //Note that we can hold a pointer to edible food in two ways:
    //  1) With a specific pointer, i.e. Banana *
    //  2) With a generic pointer, i.e. id<EdibleProtocol>
    //      The generic pointer specifies that we're pointing to an object that conforms to EdibleProtocol
    //      but doesn't specify what type of food we're pointing to
    
    Banana *banana = [[Banana alloc] init];
    id<EdibleProtocol> food = [[Apple alloc] init];
    
    //Now we can pass both the Apple and Banana to our "tell me about it" method
    [self tellMeAboutFood:banana];
    [self tellMeAboutFood:food];
    
    //See how easily we can point food to the banana instead
    //That's still valid since the banana "is a" piece of edible food (aka conforms to EdibleProtocol)
    food = banana;
    [self tellMeAboutFood:food];
}

-(void) tellMeAboutFood:(id<EdibleProtocol>)food
{
    //I don't know what kind of food this is
    //But I know it conforms to EdibleProtocol, so it has the methods getFlavor and getCalories
    
    NSLog(@"This piece of edible food is %@ tasting and contains %d calories", [food getFlavor], [food getCalories]);
}

@end
