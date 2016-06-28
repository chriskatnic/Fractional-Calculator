//
//  operator_symbol.m
//  Fractional Calculator
//
//  Created by Christopher Katnic on 4/23/15.
//  Copyright (c) 2015 Christopher Katnic. All rights reserved.
//

#import "operator_symbol.h"

@implementation operator_symbol

-(operator_symbol*) initWithSymbol:(NSString *)s
{
    self = [super init];
    if (self) {
        _symbol = [[NSString alloc] initWithString:s];
        
        if ([s  isEqual: @"+"]) {
            _weight = 1;
        }
        else if ([s  isEqual: @"-"]) {
            _weight = 1;
        }
        else if ([s  isEqual: @"*"]) {
            _weight = 3;
        }
        else if ([s  isEqual: @"/"]) {
            _weight = 3;
        }
        else if ([s  isEqual: @"^"]) {
            _weight = 5;
        }
        else
            NSLog(@"invalid input passed into operator init method");
        
    }
    
    return self;
}
@end
