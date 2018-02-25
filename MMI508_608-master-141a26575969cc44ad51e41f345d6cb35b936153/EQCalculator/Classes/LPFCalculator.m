//
//  LPFCalculator.m
//  EQCalculator
//
//  Created by Christopher Bennett on 1/7/16.
//
//

#import "LPFCalculator.h"


@implementation LPFCalculator

-(void) registerDelegate:(id<FilterPlayerProtocol>)d
{
    self.theDelegate = d;
}


-(void) updateCoeffs:(float)Q :(float)Fc
{
    // calc coeffs
    
    // store in NSDictionary
    NSDictionary *newCoeffs = [[NSDictionary alloc] init];
    
    // fill in a value for every key
    
    // notify delegate
    [self.theDelegate didUpdateCoeffs:newCoeffs];
    
}

// do you need a custom init function? if so, do you override init, or create a new designated initializer? think about it...


@end

