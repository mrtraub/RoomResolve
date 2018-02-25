//
//  Customer.h
//  DelegateDemo_Simple
//
//  Created by Dave Viggiano on 2/3/16.
//  Copyright © 2016 UM FORE Center. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocolDefinitions.h"
#import "Car.h"
#import "GasStationAttendant.h"

//This is the public interface for the Customer
@interface Customer : NSObject <WindowDown>

//Constructor method to create a Customer and assign them a starting fuel level
+(Customer *) createWithTankLevel:(int)level;

//The command that makes a Customer do what customers do
-(void) goGetGasFromAttendant:(GasStationAttendant *)attendant;

@end
