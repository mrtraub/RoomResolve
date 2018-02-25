//
//  Apple.h
//  ProtocolDemo_Simple
//
//  Created by Dave Viggiano on 2/3/16.
//  Copyright © 2016 UM FORE Center. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocolDefinitions.h"

//I, Apple, do hereby solemnly swear that I am edible

@interface Apple : NSObject <EdibleProtocol>

@end
