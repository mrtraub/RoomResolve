//
//  TheAllPowerfulDelegate.h
//  DemoDelegates
//
//  Created by Dave Viggiano on 2/3/16.
//  Copyright © 2016 UM FORE Center. All rights reserved.
//

#ifndef TheAllPowerfulDelegate_h
#define TheAllPowerfulDelegate_h


@protocol CallbackDelegate
@required
-(void) doneDoingWork:(NSString *)message;
@end

@protocol GenericWorker
@required
-(void) doWorkAndReportBackTo:(id<CallbackDelegate>)delegate;
@end


#endif /* TheAllPowerfulDelegate_h */
