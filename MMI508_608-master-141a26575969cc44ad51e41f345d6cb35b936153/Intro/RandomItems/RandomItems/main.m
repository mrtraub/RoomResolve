//
//  main.m
//  RandomItems
//
//  Created by Christopher Bennett on 1/7/16.
//  Copyright © 2016 FORECenter. All rights reserved.
//

#import <Foundation/Foundation.h>
// 8) include our new class
#import "BNRItem.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        

        // 1) Create instance of NSMutableArray
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
        
        
        // 2) Send message to addObject: to items
        // @ always precedes "" in char strings for Objective-C
        [items addObject:@"one"];
        [items addObject:@"two"];
        [items addObject:@"three"];
        
        
        
        // 3) You can also insertObject: atIndex:
        [items insertObject:@"zero" atIndex:0];
        
        
       
        // 4) Fast enumeration
        // each element in items is an NSString (since we used the @"" construction)
        int cnt=0;
        for (NSString *item in items) {
            NSLog(@"Item: %d has value: %@", cnt, item);
            cnt=cnt+1;
        }
        
        
        
        // 5a) Next create a new 'BNRItem' Class that subclasses NSObject (goto BNRItem.h)
        
       
        // 9) Create an instance of the BNRItem
        BNRItem *item = [[BNRItem alloc] init];
        
        // 10) Add some values to it
      //  item.itemName = @"ferrari";
        [item setItemName:@"ferrari"];
        item.serialNumber=@"1234ABC";
        item.valueInDollars=200000;
        
        
        NSLog(@"%@ %@ %@ %d", item.itemName, item.dateCreated, item.serialNumber, item.valueInDollars);
        
        
        // 11) Now access the description of the class
        NSLog(@"%@", item);
        
        
       
        // 12) override the description method in the implementation file to provide a better description in BNRItem.m
       
        
        // 14a) Goto BNRItem.h and create a new initializer
        
        
        // 17) finally, let's create a new object using our fancy new init'er
        BNRItem *guitar = [[BNRItem alloc] initWithItemName:@"Stratocaster" valueInDollars:1000 serialNumber:@"A1234567"];
        NSLog(@"%@",guitar);
        
        
        
        
    }
    return 0;
}
