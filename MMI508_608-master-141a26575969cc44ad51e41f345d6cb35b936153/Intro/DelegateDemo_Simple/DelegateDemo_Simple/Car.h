//
//  Car.h
//  DelegateDemo_Simple
//
//  Created by Dave Viggiano on 2/3/16.
//  Copyright © 2016 UM FORE Center. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int MaxTankLevel = 10;

@interface Car : NSObject

//Constructor method to create a Car
+(Car *) createWithTankLevel:(int)level;

//The only important thing about a car in this demo: how much gas is in the tank
@property (nonatomic) int tankLevel;

@end
