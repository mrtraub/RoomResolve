//
//  MasterClass.m
//  DelegateDemo_Simple
//
//  Created by Dave Viggiano on 2/3/16.
//  Copyright © 2016 UM FORE Center. All rights reserved.
//

#import "MasterClass.h"

@implementation MasterClass

-(void) runTheDemo
{
    //This specifies how much gas we start with in the car
    //If a number less than 10, the attendant will put gas in the car while the customer reads a book
    //If the number is 10, the attendant will tell the customer the tank is already full
    int startingGasLevel = 0;
    
    //Create a GasStationAttendant
    GasStationAttendant *attendant = [GasStationAttendant create];
    
    //Now create a Customer and tell him/her to go get gas from the attendant
    Customer *customer = [Customer createWithTankLevel:startingGasLevel];
    [customer goGetGasFromAttendant:attendant];
}

@end
