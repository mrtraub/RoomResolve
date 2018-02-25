//
//  LPFCalculator.h
//  EQCalculator
//
//  Created by Christopher Bennett on 1/7/16.
//
//

#import <Foundation/Foundation.h>
#import "FilterPlayerProtocol.h"

@interface LPFCalculator : NSObject


// Properties to hold the filter parameters (e.g., Q, Fc, etc.) and the filter coefficients (a0, a1, etc.)
@property id<FilterPlayerProtocol> theDelegate;


// Methods to set the filter parameters. You only need to override the setter if you create these as properties.

-(void) updateCoeffs:(float)Q :(float)Fc;

-(void) registerDelegate:(id<FilterPlayerProtocol>)d;

@end
