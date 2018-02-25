//
//  FilterPlayerProtocol.h
//  EQCalculator
//
//  Created by Christopher Bennett on 2/20/18.
//

@protocol FilterPlayerProtocol <NSObject>

@required
-(void)didUpdateCoeffs:(NSDictionary*)coeffs;


@end
