//
//  main.m
//  ProtocolDemo_Simple
//
//  Created by Dave Viggiano on 2/3/16.
//  Copyright © 2016 UM FORE Center. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MasterClass.h"

int main(int argc, const char * argv[])
{

        //Here we just create the MasterClass and run the demo
        
        MasterClass *master = [[MasterClass alloc] init];
        
        [master runDemo];
    return 0;
}
