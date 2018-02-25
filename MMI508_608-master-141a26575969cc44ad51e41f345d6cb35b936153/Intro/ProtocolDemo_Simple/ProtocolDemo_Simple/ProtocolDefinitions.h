//
//  ProtocolDefinitions.h
//  ProtocolDemo_Simple
//
//  Created by Dave Viggiano on 2/3/16.
//  Copyright © 2016 UM FORE Center. All rights reserved.
//

#ifndef ProtocolDefinitions_h
#define ProtocolDefinitions_h

//This protocol specifies that if an object wants to call itself edible (i.e. conform to EdibleProtocol)
//it better have a getFlavor method and a getCalories method!

@protocol EdibleProtocol

@required
-(NSString *) getFlavor;
-(int) getCalories;

@end

#endif /* ProtocolDefinitions_h */
