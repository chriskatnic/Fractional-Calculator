//
//  shunting_yard.h
//  Fractional Calculator
//
//  Created by Christopher Katnic on 4/23/15.
//  Copyright (c) 2015 Christopher Katnic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "stack.h"

@interface shunting_yard : NSObject

@property stack * input;
@property stack * holding;
@property stack * resultant;

-(shunting_yard *) init;
-(void) insert_item_into_input: (id) item;
-(void) process_inputs;
-(NSString *) evaluate_ouput;

@end
