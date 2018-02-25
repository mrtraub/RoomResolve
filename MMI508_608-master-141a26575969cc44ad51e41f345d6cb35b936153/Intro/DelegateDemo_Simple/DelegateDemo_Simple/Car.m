//
//  Car.m
//  DelegateDemo_Simple
//
//  Created by Dave Viggiano on 2/3/16.
//  Copyright © 2016 UM FORE Center. All rights reserved.
//

#import "Car.h"

@implementation Car

+(Car *) createWithTankLevel:(int)level
{
    Car *car = [[Car alloc] init];
    
    //Initialize the tank level
    car.tankLevel = level;
    
    return car;
}

@end
