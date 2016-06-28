//
//  ViewController.m
//  Fractional Calculator
//
//  Created by Christopher Katnic on 4/16/15.
//  Copyright (c) 2015 Christopher Katnic. All rights reserved.
//


/*
 *
 *  TODO:
 *      
 *      Shunting yard algorithm
 *
 *      Pressing equals should only insert a fractional number into the function and then begin the algo
 */





#import "ViewController.h"
#import "stack.h"
#import "FractionalNumber.h"
#import "operator_symbol.h"
#import "shunting_yard.h"

@interface ViewController ()
@property NSMutableString * token_holder;
@property NSMutableString * denominator_holder;
@property BOOL in_fraction;
@property BOOL denominator_input;
@property BOOL in_sqrt;
@property shunting_yard * yard;

@property FractionalNumber * temp_frac;
@property operator_symbol * temp_symbol;

@end

@implementation ViewController

//function to enable all operator buttons
void enable_all_operation_buttons(ViewController *object) {
    
    
    if(object.in_fraction == NO && object.in_sqrt == NO){
        object.fraction_bar.enabled = YES;
        object.minus.enabled = YES;
        object.addition.enabled = YES;
        object.division.enabled = YES;
        object.multiply.enabled = YES;
        object.equals.enabled = YES;
        
        object.power.enabled = YES;
        
    }
    else if (object.in_fraction == YES)
        object.fraction_complete.enabled = YES;
    else
        object.sqrt_complete.enabled = YES;

    object.negate.enabled = NO;
    object.sqrt.enabled = NO;
}

//function to disable all operator buttons, makes sure that equation
//makes sense

void test()
{
     FractionalNumber * n = [[FractionalNumber alloc] initWithNumerator:-14 Denominator:-250];
    shunting_yard * test_yard = [[shunting_yard alloc] init];
    [test_yard insert_item_into_input:n];
    
    [test_yard process_inputs];
    [test_yard evaluate_ouput];
    NSLog(@"%f / %f", n.numerator, n.denominator);
    
}


void disable_all_numeric_buttons(ViewController *object)
{
    object.one.enabled = NO;
    object.two.enabled = NO;
    object.three.enabled = NO;
    object.four.enabled = NO;
    object.five.enabled = NO;
    object.six.enabled = NO;
    object.seven.enabled = NO;
    object.eight.enabled = NO;
    object.nine.enabled = NO;
    object.zero.enabled = NO;
}
void enable_all_numeric_buttons(ViewController *object)
{
    object.one.enabled = YES;
    object.two.enabled = YES;
    object.three.enabled = YES;
    object.four.enabled = YES;
    object.five.enabled = YES;
    object.six.enabled = YES;
    object.seven.enabled = YES;
    object.eight.enabled = YES;
    object.nine.enabled = YES;
    object.zero.enabled = YES;
}
void disable_all_operation_buttons(ViewController *object) {
    object.minus.enabled = NO;
    object.addition.enabled = NO;
    object.division.enabled = NO;
    object.multiply.enabled = NO;
    object.equals.enabled = NO;
    object.fraction_bar.enabled = NO;
    object.sqrt.enabled = YES;
    object.power.enabled = NO;
    object.negate.enabled = YES;
    enable_all_numeric_buttons(object);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    //Disable all buttons on load, because equations start
    //with numbers, not operators!
    disable_all_operation_buttons(self);
    _token_holder = [[NSMutableString alloc] initWithFormat:@""];
    _denominator_holder = [[NSMutableString alloc] initWithFormat:@""];
    self.fraction_complete.hidden = YES;
    self.sqrt_complete.hidden = YES;
    self.in_fraction = NO;
    self.denominator_input = NO;
    self.yard = [[shunting_yard alloc] init];
    
    self.temp_frac = nil;
    self.temp_symbol = nil;
    
    test();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)insert_fraction_bar:(id)sender {
    disable_all_operation_buttons(self);
     self.entry_field.text = [NSString stringWithFormat:@"%@/", self.entry_field.text];
    [_token_holder appendString:@"|"];
    disable_all_operation_buttons(self);
    self.fraction_complete.enabled = NO;
    self.fraction_complete.hidden = NO;
    self.in_fraction = YES;
    
    self.denominator_input = YES;
    
    
}
- (IBAction)fraction_done:(id)sender {
    self.in_fraction = NO;
    enable_all_operation_buttons(self);
    self.fraction_bar.enabled = NO;
    self.fraction_bar.hidden = NO;
    self.fraction_complete.hidden = YES;
    self.fraction_complete.enabled = NO;
    disable_all_numeric_buttons(self);
}

- (IBAction)insert_one:(id)sender {
    self.entry_field.text = [NSString stringWithFormat:@"%@1", self.entry_field.text];
    if(_denominator_input)
        [_denominator_holder appendString:@"1"];
    else
        [_token_holder appendString:@"1"];
    enable_all_operation_buttons(self);
}
- (IBAction)insert_two:(id)sender {
    self.entry_field.text = [NSString stringWithFormat:@"%@2", self.entry_field.text];
    if(_denominator_input)
        [_denominator_holder appendString:@"2"];
    else
        [_token_holder appendString:@"2"];
    enable_all_operation_buttons(self);
}
- (IBAction)insert_three:(id)sender {
    self.entry_field.text = [NSString stringWithFormat:@"%@3", self.entry_field.text];
    if(_denominator_input)
        [_denominator_holder appendString:@"3"];
    else
        [_token_holder appendString:@"3"];
    enable_all_operation_buttons(self);
}
- (IBAction)insert_four:(id)sender {
    self.entry_field.text = [NSString stringWithFormat:@"%@4", self.entry_field.text];
    [_token_holder appendString:@"4"];
    enable_all_operation_buttons(self);
}
- (IBAction)insert_five:(id)sender {
    self.entry_field.text = [NSString stringWithFormat:@"%@5", self.entry_field.text];
    [_token_holder appendString:@"5"];
    enable_all_operation_buttons(self);
}
- (IBAction)insert_six:(id)sender {
    self.entry_field.text = [NSString stringWithFormat:@"%@6", self.entry_field.text];
    if(_denominator_input)
        [_denominator_holder appendString:@"6"];
    else
        [_token_holder appendString:@"6"];
    enable_all_operation_buttons(self);
}
- (IBAction)insert_seven:(id)sender {
    self.entry_field.text = [NSString stringWithFormat:@"%@7", self.entry_field.text];
    if(_denominator_input)
        [_denominator_holder appendString:@"7"];
    else
        [_token_holder appendString:@"7"];
    enable_all_operation_buttons(self);
}
- (IBAction)insert_eight:(id)sender {
    self.entry_field.text = [NSString stringWithFormat:@"%@8", self.entry_field.text];
    if(_denominator_input)
        [_denominator_holder appendString:@"8"];
    else
    [_token_holder appendString:@"8"];
    enable_all_operation_buttons(self);
}
- (IBAction)insert_nine:(id)sender {
    self.entry_field.text = [NSString stringWithFormat:@"%@9", self.entry_field.text];
    [_token_holder appendString:@"9"];
    enable_all_operation_buttons(self);
}
- (IBAction)insert_zero:(id)sender {
    self.entry_field.text = [NSString stringWithFormat:@"%@0", self.entry_field.text];
    //can convert from string to integer value
    NSLog(@"%li", (long)self.entry_field.text.integerValue);
    if(_denominator_input)
        [_denominator_holder appendString:@"0"];
    else
        [_token_holder appendString:@"0"];
    enable_all_operation_buttons(self);
}


- (IBAction)clear_text_field:(id)sender {
    self.entry_field.text = [NSString stringWithFormat:@""];
    disable_all_operation_buttons(self);
    [_token_holder setString:@""];
    _yard = nil;
    _yard = [[shunting_yard alloc] init];
    self.temp_symbol = nil;
    self.temp_frac = nil;
    self.denominator_input = NO;
    [self.token_holder setString:@""];
    [self.denominator_holder setString:@""];

    self.fraction_complete.hidden = YES;
    self.sqrt_complete.hidden = YES;
    self.in_fraction = NO;
    self.in_sqrt = NO;
    self.denominator_input = NO;
    self.fraction_bar.enabled = YES;
    self.fraction_bar.hidden  = NO;
    self.result_label.text = [NSString stringWithFormat:@""];

}


- (IBAction)equals_pressed:(id)sender {
    //formatting and cleanliness in display

    disable_all_operation_buttons(self);
    disable_all_numeric_buttons(self);
    self.negate.enabled = NO;
    self.sqrt.enabled = NO;
    
    //first, take the numeric input and create a fractional object
    //there will be no operator, so insert this single object into yard
    //then clear temp stuff
    //finally start the algorithm and get the answer!
    if (self.denominator_input == YES)
        self.temp_frac = [[FractionalNumber alloc] initWithNumerator:(int)self.token_holder.integerValue Denominator:(int)self.denominator_holder.integerValue];
    else
        self.temp_frac = [[FractionalNumber alloc] initWithNumeratorOnly:(int)self.token_holder.integerValue];
    
    //insert temp fraction into shunting yard. The shunting yard will decide where the input goes
    [_yard insert_item_into_input:self.temp_frac];
    
    //call shunting yard method process_inputs to generate a readable expression for the calculator engine
    [_yard process_inputs];
    

    
    //call shunting yard method evaluate_output to perform arithmetic on the postfix expression
    //method returns an nsstring, which is then output into the label
    self.result_label.text = [_yard evaluate_ouput];
    
    
    //clearing temporarily used things.
    self.temp_symbol = nil;
    self.temp_frac = nil;
    self.denominator_input = NO;
    [self.token_holder setString:@""];
    
    
}


- (IBAction)minus_pressed:(id)sender {
    self.entry_field.text = [NSString stringWithFormat:@"%@  -  ", self.entry_field.text];
    disable_all_operation_buttons(self);
    
    //first, take the numeric input, and create a fractional object
    //then, insert the fractional object, and the operator into the yard
    //finally clear everything
    
    self.temp_symbol = [[operator_symbol alloc] initWithSymbol:@"-"];
    
    if (self.denominator_input == YES) {
        self.temp_frac = [[FractionalNumber alloc] initWithNumerator:(int)self.token_holder.integerValue Denominator:(int)self.denominator_holder.integerValue];
    }
    else
        self.temp_frac = [[FractionalNumber alloc] initWithNumeratorOnly:(int)self.token_holder.integerValue];
    
    //insert the temp fraction and symbol into the yard
    [_yard insert_item_into_input:self.temp_frac];
    [_yard insert_item_into_input:self.temp_symbol];
    
    self.temp_symbol = nil;
    self.temp_frac = nil;
    self.denominator_input = NO;
    [self.token_holder setString:@""];
    
}
- (IBAction)mult_pressed:(id)sender {
    self.entry_field.text = [NSString stringWithFormat:@"%@  *  ", self.entry_field.text];
    disable_all_operation_buttons(self);
    
    //first, take the numeric input, and create a fractional object
    //then, insert the fractional object, and the operator into the yard
    //finally clear everything
    
    self.temp_symbol = [[operator_symbol alloc] initWithSymbol:@"*"];
    
    if (self.denominator_input == YES) {
        self.temp_frac = [[FractionalNumber alloc] initWithNumerator:(int)self.token_holder.integerValue Denominator:(int)self.denominator_holder.integerValue];
    }
    else
        self.temp_frac = [[FractionalNumber alloc] initWithNumeratorOnly:(int)self.token_holder.integerValue];
    
    //insert the temp fraction and symbol into the yard
    [_yard insert_item_into_input:self.temp_frac];
    [_yard insert_item_into_input:self.temp_symbol];
    
    self.temp_symbol = nil;
    self.temp_frac = nil;
    self.denominator_input = NO;
    [self.token_holder setString:@""];
}
- (IBAction)sqrt_pressed:(id)sender {
     self.entry_field.text = [NSString stringWithFormat:@"%@√(", self.entry_field.text];
    self.temp_symbol = [[operator_symbol alloc] initWithSymbol:@"^"];
    
    //the below code disables buttons so that the user cannot send bad data.
    disable_all_operation_buttons(self);
    self.fraction_bar.enabled = YES;
    enable_all_numeric_buttons(self);
    [self.token_holder setString:@""];
    self.sqrt_complete.hidden = NO;
    self.sqrt_complete.enabled = YES;
    self.in_sqrt = YES;
    self.sqrt.enabled = NO;
    self.negate.enabled = NO;

}
- (IBAction)sqrt_complete:(id)sender {
    
    self.entry_field.text = [NSString stringWithFormat:@"%@) ", self.entry_field.text];
    
    if (self.denominator_input == YES) {
        self.temp_frac = [[FractionalNumber alloc] initWithNumerator:(int)self.token_holder.integerValue Denominator:(int)self.denominator_holder.integerValue];
    }
    else
        self.temp_frac = [[FractionalNumber alloc] initWithNumeratorOnly:(int)self.token_holder.integerValue];
    
    FractionalNumber * temp = [[FractionalNumber alloc] initWithNumerator:1 Denominator:2];
    self.temp_frac = [self.temp_frac pow: temp];
    
    disable_all_numeric_buttons(self);
    self.sqrt_complete.hidden = YES;
    self.sqrt_complete.enabled = NO;
    self.in_sqrt = NO;
    enable_all_operation_buttons(self);
    
}

- (IBAction)addition_pressed:(id)sender {
    self.entry_field.text = [NSString stringWithFormat:@"%@  +  ", self.entry_field.text];
    disable_all_operation_buttons(self);
    //first, take the numeric input, and create a fractional object
    //then, insert the fractional object, and the operator into the yard
    //finally clear everything
    
    self.temp_symbol = [[operator_symbol alloc] initWithSymbol:@"+"];
    
    if(self.temp_frac == nil)
    {
        if (self.denominator_input == YES) {
            self.temp_frac = [[FractionalNumber alloc] initWithNumerator:(int)self.token_holder.integerValue Denominator:(int)self.denominator_holder.integerValue];
        }
        else
            self.temp_frac = [[FractionalNumber alloc] initWithNumeratorOnly:(int)self.token_holder.integerValue];
    }
    
    //insert the temp fraction and symbol into the yard
    [_yard insert_item_into_input:self.temp_frac];
    [_yard insert_item_into_input:self.temp_symbol];
    
    self.temp_symbol = nil;
    self.temp_frac = nil;
    self.denominator_input = NO;
    [self.token_holder setString:@""];
}
- (IBAction)division_pressed:(id)sender {
    self.entry_field.text = [NSString stringWithFormat:@"%@  /  ", self.entry_field.text];
    disable_all_operation_buttons(self);
    //first, take the numeric input, and create a fractional object
    //then, insert the fractional object, and the operator into the yard
    //finally clear everything
    
    self.temp_symbol = [[operator_symbol alloc] initWithSymbol:@"/"];
    
    if (self.denominator_input == YES) {
        self.temp_frac = [[FractionalNumber alloc] initWithNumerator:(int)self.token_holder.integerValue Denominator:(int)self.denominator_holder.integerValue];
    }
    else
        self.temp_frac = [[FractionalNumber alloc] initWithNumeratorOnly:(int)self.token_holder.integerValue];
    
    //insert the temp fraction and symbol into the yard
    [_yard insert_item_into_input:self.temp_frac];
    [_yard insert_item_into_input:self.temp_symbol];
    
    self.temp_symbol = nil;
    self.temp_frac = nil;
    self.denominator_input = NO;
    [self.token_holder setString:@""];
}
- (IBAction)negation_pressed:(id)sender {
    self.entry_field.text = [NSString stringWithFormat:@"%@-", self.entry_field.text];
    
    //negation should only ever precede a number
    //therefore, disable all operation buttons, and enable all numeric buttons.
    //then, disable self.
    
    disable_all_operation_buttons(self);
    enable_all_numeric_buttons(self);
    self.negate.enabled = NO;
    
    //now that only numbers can be pressed, negate should be disabled until the next operator button is pressed, which is the next possible instance of a number
    
    //append a negative sign to the token holder
    if(_denominator_input)
        [_denominator_holder appendString:@"-"];
    else
        [_token_holder appendString:@"-"];
    
}

@end




