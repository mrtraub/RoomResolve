//
//  Customer.m
//  DelegateDemo_Simple
//
//  Created by Dave Viggiano on 2/3/16.
//  Copyright © 2016 UM FORE Center. All rights reserved.
//

#import "Customer.h"

//This is the private interface for the Customer
//(as opposed to the public interface defined in the header file)
@interface Customer()

@property (nonatomic) Car *mCar;
@property (nonatomic) bool mReadyToLeave;

@end



@implementation Customer

+(Customer *) createWithTankLevel:(int)level
{
    Customer *customer = [[Customer alloc] init];
    
    //Create the car with the starting tank level
    customer.mCar = [Car createWithTankLevel:level];
    
    customer.mReadyToLeave=false;
    
    return customer;
}

-(void) goGetGasFromAttendant:(GasStationAttendant *)attendant
{
    NSLog(@"Customer: Telling the attendant to fill the tank");
    
    //Tell the attendant to fill up the car and notify me when done
    [attendant fillTheTank:self.mCar andNotify:self];
    
    NSLog (@"Customer: The attendant acknowledged my request");
    
    //Now unless we've already decided it's time to leave,
    //let's read until the attendant finishes
    while(!self.mReadyToLeave)
    {
        NSLog(@"Customer: Checking my phone...");
        sleep(1);
    }
    
    NSLog(@"Customer: Time to go home!");
}

//CustomerDelegate method
-(void) doneFillingUp:(NSString *)message
{
    NSLog(@"Customer: The attendant is done and says '%@'", message);
    
    self.mReadyToLeave = true;
}

@end
