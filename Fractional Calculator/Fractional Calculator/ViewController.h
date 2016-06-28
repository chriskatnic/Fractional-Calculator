//
//  ViewController.h
//  Fractional Calculator
//
//  Created by Christopher Katnic on 4/16/15.
//  Copyright (c) 2015 Christopher Katnic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *two;
@property (weak, nonatomic) IBOutlet UIButton *one;
@property (weak, nonatomic) IBOutlet UIButton *three;
@property (weak, nonatomic) IBOutlet UIButton *four;
@property (weak, nonatomic) IBOutlet UIButton *five;
@property (weak, nonatomic) IBOutlet UIButton *six;
@property (weak, nonatomic) IBOutlet UIButton *seven;
@property (weak, nonatomic) IBOutlet UIButton *eight;
@property (weak, nonatomic) IBOutlet UIButton *nine;
@property (weak, nonatomic) IBOutlet UIButton *zero;
@property (weak, nonatomic) IBOutlet UIButton *equals;
@property (weak, nonatomic) IBOutlet UILabel *entry_field;
@property (weak, nonatomic) IBOutlet UIButton *clear_everything;
@property (weak, nonatomic) IBOutlet UILabel *result_label;
@property (weak, nonatomic) IBOutlet UIButton *minus;
@property (weak, nonatomic) IBOutlet UIButton *multiply;
@property (weak, nonatomic) IBOutlet UIButton *addition;
@property (weak, nonatomic) IBOutlet UIButton *division;
@property (weak, nonatomic) IBOutlet UILabel *tokenholder_result;
@property (weak, nonatomic) IBOutlet UIButton *fraction_bar;
@property (weak, nonatomic) IBOutlet UIButton *fraction_complete;
@property (weak, nonatomic) IBOutlet UIButton *sqrt;
@property (weak, nonatomic) IBOutlet UIButton *sqrt_complete;
@property (weak, nonatomic) IBOutlet UIButton *power;
@property (weak, nonatomic) IBOutlet UIButton *negate;


@end

