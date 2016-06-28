//
//  operator_symbol.h
//  Fractional Calculator
//
//  Created by Christopher Katnic on 4/23/15.
//  Copyright (c) 2015 Christopher Katnic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface operator_symbol : NSObject
@property NSString * symbol;
@property unsigned int weight;

-(operator_symbol *) initWithSymbol: (NSString*) s;
@end
