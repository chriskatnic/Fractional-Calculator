//
//  FractionalNumber.h
//  Fractional Calculator
//
//  Created by Christopher Katnic on 4/16/15.
//  Copyright (c) 2015 Christopher Katnic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FractionalNumber : NSObject
@property float numerator;
@property float denominator;

-(FractionalNumber*) initWithNumerator: (float)n Denominator: (float)d;
-(FractionalNumber*) initWithNumeratorOnly: (float)n;
-(FractionalNumber*) add: (FractionalNumber*)rhs;
-(FractionalNumber*) sub: (FractionalNumber*)rhs;
-(FractionalNumber*) mult: (FractionalNumber*)rhs;
-(FractionalNumber*) div: (FractionalNumber*)rhs;
-(FractionalNumber*) pow: (FractionalNumber*)rhs;
@end
