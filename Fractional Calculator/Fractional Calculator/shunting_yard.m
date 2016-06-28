//
//  shunting_yard.m
//  Fractional Calculator
//
//  Created by Christopher Katnic on 4/23/15.
//  Copyright (c) 2015 Christopher Katnic. All rights reserved.
//

#import "shunting_yard.h"
#import "stack.h"
#import "operator_symbol.h"
#import "FractionalNumber.h"

@implementation shunting_yard

-(shunting_yard *) init
{
    self = [super init];
    
    //all stacks will be uninitialized
    if (self) {
        _input = nil;
        _holding = nil;
        _resultant = nil;
    }
    
    
    return self;
}

-(void) insert_item_into_input:(id)item
{
    if(_input == nil)
        _input = [[stack alloc] init];
    
    [_input push:item];
    
}

-(void) process_inputs
{
    id token = nil;
    operator_symbol * temp_operator = nil;
    
    if(_holding == nil)
        _holding = [[stack alloc] init];
    if(_resultant == nil)
        _resultant = [[stack alloc] init];
    while (_input.size != 0)
    {

    
        //grab token from back of stack
        token = [_input pop_from_back];
        //check if we can check class appropriately
            if ([token isKindOfClass:[operator_symbol class]])
            {
                NSLog(@"is operator %@", [token symbol]);

                //if there's nothing in holding, or if it has not even been used yet
                if (_holding.size == 0 || _holding == nil)
                {
                    NSLog(@"pushed into holding %@", [token symbol]);
                    [_holding push:token];
                }
                
                //else, check the first one
                else
                {
                    BOOL done = NO;
                    while (!done)
                    {
                        //will be nil if holding is empty
                        temp_operator = [_holding pop];
                        
                        if ([temp_operator weight] >= [token weight])
                        {
                            [_resultant push:temp_operator];
                            //not done checking. need to check the next one
                        }
                        else if(temp_operator == nil)
                        {
                            //if shit was empty, push new token, and move on
                            [_holding push:token];
                            done = YES;
                        }
                        else
                        {
                            //push object back, push new one on top
                            //done evaluating
                            [_holding push:temp_operator];
                            [_holding push:token];
                            done = YES;
                        }
                    }
                }
                
            }
            
            else
            {
                NSLog(@"isn't operator\npushed into resultant %f / %f", [token numerator], [token denominator]);
                [_resultant push:token];
                
            }
        
    }
    while(_holding.size != 0)
    {
        id temp = [_holding pop];
        [_resultant push:temp];
    }
    NSLog(@"tokens processed...");
    NSLog(@"All inputs are properly formatted in output stack");
    
    
    NSLog(@"Current stack:\n");
    [_resultant print_stack];
    
}



//FIGURE THIS OUT FIRST

-(NSString *) evaluate_ouput
{
    NSString * result = [[NSString alloc] init];
    
    
    //if the user was cheeky and entered in a single number and then hit '='
    if (_resultant.size == 1)
    {
        FractionalNumber * temp = [_resultant pop];
        if (temp.denominator == 1)
            result = [NSString stringWithFormat:@"%.0f", temp.numerator];
        else
        result = [NSString stringWithFormat:@"%.0f / %.0f", temp.numerator, temp.denominator ];
    }
    
    
    //evaluate postifx expression
    else
    {
        //two stacks to hold numbers and operators
        stack * numbers = [[stack alloc] init];
       
        //two fractional numbers for calculations
        FractionalNumber * lhs = [[FractionalNumber alloc] init];
        FractionalNumber * rhs = [[FractionalNumber alloc] init];
        
        operator_symbol * op = [[operator_symbol alloc] init];
        
        while (_resultant.size != 0)
        {
            
            //if the bottom of the stack is a number
            if ([_resultant.data_stack.firstObject isKindOfClass:[FractionalNumber class]])
            {
                //store into number stack
                lhs = [_resultant pop_from_back];
                [numbers push:lhs];
            }
            
            //if the bottom of the stack is an operator
            else
            {
                //store operator into temp variable
                op = [_resultant pop_from_back];
                
                //pop the top two numbers off of the stack, store into fractional number variables
                rhs = [numbers pop];
                lhs = [numbers pop];
                
                //perform calculations, store result into lhs variable
                if ([op.symbol  isEqual: @"+"]) {
                    lhs = [lhs add:rhs];
                }
                else if ([op.symbol  isEqual: @"-"]) {
                    lhs = [lhs sub:rhs];
                }
                else if ([op.symbol  isEqual: @"*"]) {
                    lhs = [lhs mult:rhs];
                }
                else if ([op.symbol  isEqual: @"/"]) {
                    lhs = [lhs div:rhs];
                }
                
                //push result back into numbers stack
                [numbers push:lhs];
            }
        }
        
        
        //there should only be one number left in numbers stack, the result
        lhs = [numbers pop];
        
        
        
        //Formatting string result
        if(lhs.numerator - (int)lhs.numerator > 0)
        {
            if (lhs.denominator == 1) {
                result = [NSString stringWithFormat:@"%.03f", lhs.numerator];
            }
            else
            result = [NSString stringWithFormat:@"%.03f / %.03f", lhs.numerator, lhs.denominator];
        }
        else
        {
            if (lhs.denominator == 1) {
                result = [NSString stringWithFormat:@"%.0f", lhs.numerator];
            }
            else
                result = [NSString stringWithFormat:@"%.0f / %.0f", lhs.numerator, lhs.denominator];
        }
        //end foratting string result

    }
    
    
    
    NSLog(@"The result after calculation is: %@", result);
    return result;
    
    
}

@end
