//
//  stack.m
//  Fractional Calculator
//
//  Created by Christopher Katnic on 4/23/15.
//  Copyright (c) 2015 Christopher Katnic. All rights reserved.
//

#import "stack.h"
#import "FractionalNumber.h"
#import "operator_symbol.h"
@implementation stack


-(stack*) init
{
    self = [super init];
    if (self) {
        _data_stack = nil;
        _size = 0;
        NSLog(@"initialized stack");
    }
    
    return self;
}

-(id) pop_from_back
{
    if (_size > 0)
    {
        id thing = [_data_stack firstObject];
        [_data_stack removeObject:thing];
         NSLog(@"popping from bottom of stack %@", [thing class]);
        _size -= 1;
        return thing;
    }
    else return nil;
}

-(id) pop
{
    if(_size > 0)
    {
        //get last thing inserted
        id thing = [_data_stack lastObject];
        [_data_stack removeLastObject];
        _size -= 1;
        NSLog(@"popping from top of stack %@", [thing class]);
        return thing;
    }
    
    else return nil;
}

-(void) push:(id)item
{
    if (_size == 0 || self == nil)
    {
        _data_stack = [[NSMutableArray alloc] initWithObjects:item, nil];
        NSLog(@"pushing into empty stack successful");
    }
    
    else
    {
        [_data_stack insertObject:item atIndex:_size];
        NSLog(@"pushing into non-empty stack successful");
    }
    
    
    _size += 1;

}

-(void) print_stack
{
    for (int i = 0; i < self.size; i++) {
        if ([[_data_stack objectAtIndex:i] isKindOfClass:[FractionalNumber class]])
        {
            NSLog(@"(%f/%f)", [[_data_stack objectAtIndex:i] numerator], [[_data_stack objectAtIndex:i] denominator]);
        }
        else
        {
            NSLog(@" %@ ", [[_data_stack objectAtIndex:i] symbol]);
        }
    }
}

@end
