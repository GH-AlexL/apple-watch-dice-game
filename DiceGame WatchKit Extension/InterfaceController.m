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
    
    NSInteger _moveIndex;
}

@property (weak, nonatomic) IBOutlet WKInterfaceGroup *opponentGroup;

@property (weak, nonatomic) IBOutlet WKInterfaceButton *buttonBlueNumber;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *buttonBlueDice;

@property (weak, nonatomic) IBOutlet WKInterfaceButton *blueDice1;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *blueDice2;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *blueDice3;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *blueDice4;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *blueDice5;

@property (weak, nonatomic) IBOutlet WKInterfaceImage *redNumber;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *redDice;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
    
    [self setOpponentGroupEnabled:false];
    
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
    
    [self setOpponentGroupEnabled:false];
}

- (void)setBlueDice:(NSUInteger)number
{
    _blueDice = number;
    
    NSString *imageName = [NSString stringWithFormat:@"blue-dice-%ld", (number + 1)];
    [_buttonBlueDice setBackgroundImageNamed:imageName];
    
    [self setOpponentGroupEnabled:false];
}

- (void)setRedNumberIndex:(NSUInteger)index
{
    NSString *imageName = [NSString stringWithFormat:@"numbers_red_%ld", (index + 1)];
    [_redNumber setImageNamed:imageName];
}

- (void)setRedDiceIndex:(NSUInteger)index
{
    NSString *imageName = [NSString stringWithFormat:@"red-dice-%ld", (index + 1)];
    [_redDice setImageNamed:imageName];
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
#pragma mark Red Group

- (void)setOpponentGroupEnabled:(BOOL)flag
{
    NSString *imageName = flag ? @"button-red-higlight" : @"button_black_";
    [_opponentGroup setBackgroundImageNamed:imageName];
}

#pragma mark -
#pragma mark Actions

- (IBAction)doLiarAction
{
    [self pushControllerWithName:@"trialEnded" context:nil];
}

- (IBAction)doSpotOnAction
{
    [self pushControllerWithName:@"trialEnded" context:nil];
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

- (IBAction)onBidClick:(id)sender
{
    if (_moveIndex == 0)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setOpponentGroupEnabled:true];
            
            [self setRedNumberIndex:2];
            [self setRedDiceIndex:1];
            
            _moveIndex++;
        });

    }
    else if (_moveIndex == 1)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setOpponentGroupEnabled:true];
            
            [self setRedNumberIndex:4];
            [self setRedDiceIndex:5];
            
            _moveIndex++;
        });
    }
}

@end



