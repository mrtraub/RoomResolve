//
//  GasStationAttendant.m
//  DelegateDemo_Simple
//
//  Created by Dave Viggiano on 2/3/16.
//  Copyright © 2016 UM FORE Center. All rights reserved.
//

#import "GasStationAttendant.h"

//This is the private interface for the GasStationAttendant
@interface GasStationAttendant()

@property (nonatomic) Car *mCarToFill;
@property (nonatomic) id<WindowDown> mDelegate;

@end



@implementation GasStationAttendant

+(GasStationAttendant *) create
{
    //Just a convenience method so users don't have to alloc/init on their own
    return [[GasStationAttendant alloc] init];
}

-(void) fillTheTank:(Car *)car andNotify:(id<WindowDown>)delegate
{
    NSLog(@"Attendant:     Customer is asking me to fill the tank");
    
    if(car.tankLevel >= MaxTankLevel)
    {
        NSLog(@"Attendant:     Uh, but the tank is already full");
        
        [delegate doneFillingUp:@"The tank is already full!"];
    }
    else
    {
        NSLog(@"Attendant:     This will take a while, so I'll let the customer do something else until I'm done");
        
        //Store references to the car and delegate so we can access them from the new thread
        self.mCarToFill = car;
        self.mDelegate = delegate;
        
        
        // in this case, the thread locks up until the attendant is done
        //[self doFillTank];
        
        [NSThread detachNewThreadSelector:@selector(doFillTank) toTarget:self withObject:nil];
        
    }
}

-(void) doFillTank
{
    ///////////////////////////////////////////////////////
    //This code does the work of actually filling the tank
    //It is intended to run on its own thread
    
    NSLog(@"Attendant:     Filling the tank");
    
    int gallonsAdded = 0;
    
    //Pour gas in the tank until it reaches the max level
    while(self.mCarToFill.tankLevel < MaxTankLevel)
    {
        NSLog(@"Attendant:     Pouring gas...");
        sleep(1);
        
        self.mCarToFill.tankLevel++;
        gallonsAdded++;
    }
    
    NSLog(@"Attendant:     Done filling tank");
    
    //Now inform the delegate that I'm done
    [self.mDelegate doneFillingUp:[NSString stringWithFormat:@"Added %d gallons!", gallonsAdded]];
    ///////////////////////////////////////////////////////
    

}

@end
