//
//  main.m
//  DelegateDemo_Simple
//
//  Created by Dave Viggiano on 2/3/16.
//  Copyright © 2016 UM FORE Center. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MasterClass.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        //Create the master class and run the demo
        
        MasterClass *master = [[MasterClass alloc] init];
        
        [master runTheDemo];
        
        //Sleep for a while to make sure any other running threads get to finish
        //(otherwise this code would finish before the other threads, and the program would end too early)
        sleep(10);
    }
    
    return 0;
}
