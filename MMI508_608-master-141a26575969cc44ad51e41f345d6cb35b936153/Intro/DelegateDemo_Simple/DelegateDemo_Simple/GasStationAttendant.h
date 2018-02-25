//
//  GasStationAttendant.h
//  DelegateDemo_Simple
//
//  Created by Dave Viggiano on 2/3/16.
//  Copyright © 2016 UM FORE Center. All rights reserved.
//


//IMPORTANT NOTE!
//The GasStationAttendant does not reference the Customer (i.e. no need to import Customer.h)
//This avoids a "circular reference" where Customer and GasStationAttendant would both reference each other
//Avoiding circular references is a good thing in programming.

#import <Foundation/Foundation.h>
#import "ProtocolDefinitions.h"
#import "Car.h"


//This is the public interface for the GasStationAttendant
@interface GasStationAttendant : NSObject

//Constructor method to create a GasStationAttendant
+(GasStationAttendant *) create;

//The main command that an attendant takes
-(void) fillTheTank:(Car *)car andNotify:(id<WindowDown>)delegate;

@end
