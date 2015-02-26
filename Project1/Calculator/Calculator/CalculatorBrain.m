//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Gabriella Nicole Ramirez on 2/2/15.
//  Copyright (c) 2015 edu.ucdenver.cs3320.GabriellaRamirez. All rights reserved.
//


//Unless specified, assume code is from Homework1, which compiles successfully
#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;


//Operand Stack
- (NSMutableArray *)operandStack
{
    if (!_operandStack)
    {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

//Push object onto the stack
- (void)pushOperand:(double)operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

//Pop object off of the stack
- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}


//Perform Operations
- (double)performOperation:(NSString *)operation
{
    double result = 0;
    
    //Add
    if ([operation isEqualToString:@"+"])
    {
        result = [self popOperand] + [self popOperand];
    }
    //Multiply
    else if ([@"*" isEqualToString:operation])
    {
        result = [self popOperand] * [self popOperand];
    }
    //Subtract
    else if ([operation isEqualToString:@"-"])
    {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    }
    //Divide
    else if ([operation isEqualToString:@"/"])
    {
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    }
    //Code aded for Project1
    //Sine
    else if ([operation isEqualToString:@"sin"])
    {
        result = sin([self popOperand]);
    }
    //Cosine
    else if ([operation isEqualToString:@"cos"])
    {
        result = cos([self popOperand]);
    }
    //Square Root
    else if ([operation isEqualToString:@"sqrt"])
    {
        result = sqrt([self popOperand]);
    }
    //Pi, M_PI taken from Math.c
    else if ([operation isEqualToString:@"π"])
    {
        result = M_PI;
    }
    //Sign Changed
    else if ([operation isEqualToString:@"+/-"])
    {
        result = [self popOperand] * -1;
    }
    //Code added for extra credit, used Math.c as a reference
    //Power
    else if ([operation isEqualToString:@"pow"])
    {
        //Save second number, the power
        double power = [self popOperand];
        
        //Set first number to the power of the second number
        result = pow([self popOperand], power);
    }
    //e, M_E taken from Math.c
    else if ([operation isEqualToString:@"e"])
    {
        result = M_E;
    }
    //Log base 10
    else if ([operation isEqualToString:@"log"])
    {
        result = log10([self popOperand]);
    }
    //Convert Decimal number to Octal
    else if ([operation isEqualToString:@"Oct"])
    {
        //Save number to be converted
        double decToOct = [self popOperand];
        
        //Convert to Octal
        NSString *oct = [NSString stringWithFormat:@"%llo", (long long)decToOct];
        
        result = [oct doubleValue];
    }
    /* Doesn't work with decimal values which would result in a letter being printed, e.g. 11 -> 0, when it should be B
     Does work with other values, e.g. 5395 -> 1513
    //Convert Decimal number to Hexadecimal
    else if ([operation isEqualToString:@"Hex"])
    {
        //Save number to be converted
        double decToHex = [self popOperand];
        
        //Convert to Hexadecimal
        NSString *hex = [NSString stringWithFormat:@"%llx", (long long) decToHex];
        
        result = [hex doubleValue];
    }*/
    
    [self pushOperand:result];
    
    return result;
}

//Clear Button
- (void) clear
{
    //Set Stack to nil
    self.operandStack = nil;
}

@end