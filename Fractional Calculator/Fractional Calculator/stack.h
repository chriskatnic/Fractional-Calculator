//
//  stack.h
//  Fractional Calculator
//
//  Created by Christopher Katnic on 4/23/15.
//  Copyright (c) 2015 Christopher Katnic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface stack : NSObject
@property unsigned int size;
@property NSMutableArray* data_stack;

-(id) pop;
-(id) pop_from_back;
-(void) push: (id)item;
-(void) print_stack;
-(stack*) init;

@end
