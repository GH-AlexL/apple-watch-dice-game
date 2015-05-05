//
//  InterfaceController.m
//  DiceGame WatchKit Extension
//
//  Created by Alex Lementuev on 5/5/15.
//  Copyright (c) 2015 GameHouse. All rights reserved.
//

#import "InterfaceController.h"

static const NSUInteger kDiceCount = 6;

@interface InterfaceController()
{
    NSUInteger _blueNumber;
    NSUInteger _blueDice;
}

@property (weak, nonatomic) IBOutlet WKInterfaceButton *buttonBlueNumber;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *buttonBlueDice;

@property (weak, nonatomic) IBOutlet WKInterfaceButton *blueDice1;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *blueDice2;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *blueDice3;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *blueDice4;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *blueDice5;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
    
    [self setBlueNumber:0];
    [self setBlueDice:0];
    
    [self shuffleDice];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

#pragma mark -
#pragma mark Blue Numbers

- (void)setBlueNumber:(NSUInteger)number
{
    _blueNumber = number;
    
    NSString *imageName = [NSString stringWithFormat:@"numbers_blue_%ld", (number + 1)];
    [_buttonBlueNumber setBackgroundImageNamed:imageName];
}

- (void)setBlueDice:(NSUInteger)number
{
    _blueDice = number;
    
    NSString *imageName = [NSString stringWithFormat:@"blue-dice-%ld", (number + 1)];
    [_buttonBlueDice setBackgroundImageNamed:imageName];
}

#pragma mark -
#pragma mark Shuffle Dice

- (void)shuffleDice
{
    NSArray *dice = @[
        _blueDice1,
        _blueDice2,
        _blueDice3,
        _blueDice4,
        _blueDice5,
    ];
    
    for (WKInterfaceButton *diceButton in dice)
    {
        NSUInteger index = arc4random() % kDiceCount;
        NSString *imageName = [NSString stringWithFormat:@"blue-dice-%ld", (index + 1)];
        [diceButton setBackgroundImageNamed:imageName];
    }
}

#pragma mark -
#pragma mark Actions

- (IBAction)doLiarAction
{
    NSLog(@"Liar");
}

- (IBAction)doSpotOnAction
{
    NSLog(@"Spot on");
}

- (IBAction)onBlueNumberClick
{
    NSUInteger nextNumber = (_blueNumber + 1 ) % kDiceCount;
    [self setBlueNumber:nextNumber];
}

- (IBAction)onBlueDiceClick
{
    NSUInteger nextNumber = (_blueDice + 1 ) % kDiceCount;
    [self setBlueDice:nextNumber];
}

@end



