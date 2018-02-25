//
//  ProtocolDefinitions.h
//  DelegateDemo_Simple
//
//  Created by Dave Viggiano on 2/3/16.
//  Copyright © 2016 UM FORE Center. All rights reserved.
//

#ifndef ProtocolDefinitions_h
#define ProtocolDefinitions_h


//This defines the "contract" for an attendant to respond
//to whoever asked him to fill up their tank

//He doesn't know anything about the object that made the request,
//other than what's in this contract

@protocol WindowDown <NSObject>

@required
-(void) doneFillingUp:(NSString *)message;

@end


#endif /* ProtocolDefinitions_h */
