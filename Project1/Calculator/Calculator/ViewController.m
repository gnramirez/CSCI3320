//
//  ViewController.m
//  Calculator
//
//  Created by Gabriella Nicole Ramirez on 2/1/15.
//  Copyright (c) 2015 edu.ucdenver.cs3320.GabriellaRamirez. All rights reserved.
//


//Unless specified, assume code is from Homework1, which compiles successfully
#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation ViewController

@synthesize display;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

//Number Pressed
- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [sender currentTitle];
    
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        self.display.text = [self.display.text stringByAppendingString:digit];
    }
    else
    {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

//Enter Pressed
- (IBAction)enterPressed
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    
    //Add to Command Label
    [self appendToCommand:self.display.text];
    
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

//Operation Pressed
- (IBAction)operationPressed:(id)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        [self enterPressed];
    }
    
    NSString *operation = [sender currentTitle];
    
    //Add to Command Label and add =
    [self appendToCommand:[operation stringByAppendingString:@" ="]];
    
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

//Code added for Project1
//Floating point number input
- (IBAction)decimalPressed:(id)sender
{
    //Find the end of the NSString and put a decimal
    NSRange end = [self.display.text rangeOfString:@"."];
    
    //If nothing is in the NSString, append a decimal to the empty NSString
    if (end.location == NSNotFound)
    {
        self.display.text = [self.display.text stringByAppendingString:@"."];
    }
    
    //Allow user to continue entering the decimal number until Enter is pressed
    self.userIsInTheMiddleOfEnteringANumber = YES;
}

//Command Label
- (void)appendToCommand:(NSString*) text
{
    //Remove any "=" before appending to Command Label
    self.commands.text = [self.commands.text stringByReplacingOccurrencesOfString:@"= " withString:@""];
    
    //Append to Command Label
    self.commands.text = [self.commands.text stringByAppendingString:[NSString stringWithFormat:@"%@ ", text]];
}

//Clear Pressed
- (IBAction)clearPressed:(id)sender
{
    //Clear
    [self.brain clear];
    
    //Display Zero
    self.display.text = @"0";
   
    //Clear Command Label
    self.commands.text = @"";
    
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

//Backspace Pressed
- (IBAction)backspacePressed:(id)sender
{
    //Backspace
    self.display.text = [self.display.text substringToIndex:[self.display.text length] - 1];
    
    //Check if entire number was deleted
    if ([self.display.text isEqualToString:@""] || [self.display.text isEqualToString:@"-"])
    {
        //Display Zero
        self.display.text = @"0";
        
        self.userIsInTheMiddleOfEnteringANumber = NO;
    }
}

//Sign Pressed
- (IBAction)signPressed:(id)sender
{
    //Check if user was entering a number
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        //Change display
        if ([[self.display.text substringToIndex:1] isEqualToString:@"-"])
        {
            self.display.text = [self.display.text substringFromIndex:1];
        }
        else
        {
            self.display.text = [@"-" stringByAppendingString:self.display.text];
        }
    }
    else
    {
        [self operationPressed:sender];
    }
}

@end
