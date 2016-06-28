//
//  FractionalNumber.m
//  Fractional Calculator
//
//  Created by Christopher Katnic on 4/16/15.
//  Copyright (c) 2015 Christopher Katnic. All rights reserved.
//

#import "FractionalNumber.h"

@implementation FractionalNumber



//*****************************************************************************
// Methods to combine fractions
//
float LCM (float a, float b)
{
    return((a*b) / GCD(a, b));
}

//Euclidean GCD algorithm
float GCD(float a, float b)
{
    if(b ==0)
        return a;
    else
        return(GCD(b , (int)a%(int)b));
}
//
//
//*****************************************************************************


-(FractionalNumber*) initWithNumerator: (float)n Denominator:(float)d
{
    self = [super init];
    if (self) {
        //if the user entered a fraction that had a negative n and d
        //simplify it before assigning
        if(d < 0 && n < 0)
        {
            d *= -1; n *= -1;
        }
        self.denominator = d;
        self.numerator = n;
    }
    return self;

}

-(FractionalNumber*) initWithNumeratorOnly:(float)n
{
    self = [super init];
    if (self) {
        self.denominator = 1;
        self.numerator = n;
    }
    return self;
}

-(FractionalNumber*) add:(FractionalNumber *)rhs
{

    //find denominator to be used
    float denominator1 = LCM(self.denominator, rhs.denominator);
    
    //find the new numerators of both fractions with the new denominator
    // 1/2 + 3/5   now equals   5/10 + 6/10
    float numerator1 = self.numerator * (denominator1 / self.denominator);
    float numerator2 = rhs.numerator * (denominator1 / rhs.denominator);
    
    //find numerator of new fraction. This can be done with less variables, done for clarity
    float numerator3 = numerator1 + numerator2;
    
    //return new fraction
    return [[FractionalNumber alloc] initWithNumerator:numerator3 Denominator:denominator1];
}

-(FractionalNumber*) sub:(FractionalNumber *)rhs
{
    
    //find denominator to be used
    float denominator1 = LCM(self.denominator, rhs.denominator);
    
    //find the new numerators of both fractions with the new denominator
    // 1/2 - 3/5   now equals   5/10 - 6/10
    float numerator1 = self.numerator * (denominator1 / self.denominator);
    float numerator2 = rhs.numerator * (denominator1 / rhs.denominator);
    
    //find numerator of new fraction. This can be done with less variables, done for clarity
    float numerator3 = numerator1 - numerator2;
    
    //return new fraction
    return [[FractionalNumber alloc] initWithNumerator:numerator3 Denominator:denominator1];
}

-(FractionalNumber*) mult:(FractionalNumber *)rhs
{
    
    //find denominator to be used
    float denominator1 = self.denominator * rhs.denominator;
    
    //find numerator to be used
    float numerator = self.numerator * rhs.numerator;
    
    //reduce numerator and denominator by their GCD
    // 10 / 12 = 5 / 6
    float GCD1 = GCD(numerator, denominator1);
    NSLog(@"GCD of %f and %f is %f", numerator, denominator1, GCD1);
    
    numerator = numerator / GCD1;
    denominator1 = denominator1 / GCD1;
    
    NSLog(@"The numerator is %f, denominator is %f", numerator, denominator1);
    
    //return new fraction
    return [[FractionalNumber alloc] initWithNumerator:numerator Denominator:denominator1];
}

//divide function is the same as the function above, with switched around RHS
-(FractionalNumber*) div:(FractionalNumber *)rhs
{
    //same fuction, just flip rhs upside down
    float temp = rhs.numerator;
    rhs.numerator = rhs.denominator;
    rhs.denominator = temp;
    
    
    //find denominator to be used
    float denominator1 = self.denominator * rhs.denominator;
    
    //find numerator to be used
    float numerator = self.numerator * rhs.numerator;
    
    //reduce numerator and denominator by their GCD
    // 10 / 12 = 5 / 6
    float GCD1 = GCD(numerator, denominator1);
    NSLog(@"GCD of %f and %f is %f", numerator, denominator1, GCD1);
    
    numerator = numerator / GCD1;
    denominator1 = denominator1 / GCD1;
    
    NSLog(@"The numerator is %f, denominator is %f", numerator, denominator1);
    
    //return new fraction
    return [[FractionalNumber alloc] initWithNumerator:numerator Denominator:denominator1];
}


-(FractionalNumber*) pow: (FractionalNumber *)rhs
{
    float numerator = self.numerator;
    float denominator = self.denominator;
    
    //get new numerator and new denominator by powering up
    for (float i = 1; i < rhs.numerator; i++) {
        numerator *= self.numerator;
        denominator *= self.denominator;
    }
    
    if (rhs.denominator == 2) {
        
        //find the closest possible overestimation of sqrt of numerator with float
        //so if the numerator is 26, the closest possible overestimation would be
        // x = 6 which is > than 26, because x = 5, which is < 26, we must use x = 6
        float i = 1;
        while(i * i < numerator)
            i++;
        
        
        //loop to find numerator close square root
        for (float j = 0; j < 10; j++) {
            i = (i + numerator/i)/2;
        }
        
        //the value i now holds the numerator after finding the square root of the numerator that's been powered up
        
        //find the closest possible overestimation of sqrt of numerator with float
        //so if the numerator is 26, the closest possible overestimation would be
        // x = 6 which is > than 26, because x = 5, which is < 26, we must use x = 6
        float j = 1;
        while(j * j < denominator)
            j++;
        
        //loop to find numerator close square root
        for (float k = 0; k < 10; k++) {
            j = ((j + denominator / j) / 2);
        }
        
        //the value j now holds the denominator after finding the square root of the denominator that's been powered up
        
        NSLog(@"The actual unreduced fraction after pow should be %f / %f", i, j);
        
        return [[FractionalNumber alloc] initWithNumerator:i Denominator:j];
    }
    
    //float new_gcd = GCD(numerator, denominator);
    //numerator = numerator / new_gcd;
    //denominator = denominator / new_gcd;
    
    
    return [[FractionalNumber alloc] initWithNumerator:numerator Denominator:denominator];
}


@end
