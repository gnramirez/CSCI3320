//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Gabriella Nicole Ramirez on 2/1/15.
//  Copyright (c) 2015 edu.ucdenver.cs3320.GabriellaRamirez. All rights reserved.
//


//Unless specified, assume code is from Homework1, which compiles successfully
#import <Foundation/Foundation.h>

#ifndef Calculator_CalculatorBrain_h
#define Calculator_CalculatorBrain_h

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
//Added for Clear Button
- (void) clear;

@end


#endif
