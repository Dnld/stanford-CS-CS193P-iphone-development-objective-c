//
//  ViewController.m
//  Matchismo
//
//  Created by Donald Steinert on 5/20/15.
//  Copyright (c) 2015 Donald Steinert. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *displayResult;
@property (strong, nonatomic) NSMutableArray *resultsLog;
@property (strong, nonatomic) IBOutlet UISlider *rewindSlider;


@end

@implementation ViewController

- (Deck *)createDeck  // abstract
{
    return nil;
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}

 - (NSMutableArray *)resultsLog
{
    if (!_resultsLog) {
        _resultsLog = [[NSMutableArray alloc] init];
    }
    return _resultsLog;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chosenButtonIndex = (int)[self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    NSLog(@"%@", [[self.game cardAtIndex:chosenButtonIndex] description]);
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = (int)[self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
    if (self.game.choicesAndResult) {
        
        if ([[self.game.choicesAndResult lastObject] intValue] < 0) {
            if ([[self.game.choicesAndResult firstObject] count] == 3) {
                self.displayResult.text = [NSString stringWithFormat:@"None match, %@ point penalty", [self.game.choicesAndResult lastObject]];
            } else {
                Card *firstCard = [[self.game.choicesAndResult firstObject] firstObject];
                Card *secondCard = [[self.game.choicesAndResult firstObject] lastObject];
                self.displayResult.text = [NSString stringWithFormat:@"%@ and %@ don't match, %@ point penalty", firstCard.contents, secondCard.contents, [self.game.choicesAndResult lastObject]];
            }
        } else if ([[self.game.choicesAndResult lastObject] intValue] > 0) {
            Card *firstCard = [[self.game.choicesAndResult firstObject] firstObject];
            Card *secondCard = [[self.game.choicesAndResult firstObject] lastObject];
            self.displayResult.text = [NSString stringWithFormat:@"%@ and %@ match, %@ points", firstCard.contents, secondCard.contents, [self.game.choicesAndResult lastObject]];
        } else {
            Card *onlyCard = [[self.game.choicesAndResult firstObject] firstObject];
            self.displayResult.text = [NSString stringWithFormat:@"You chose %@, 0 points", onlyCard.contents];
        }
        self.displayResult.backgroundColor = nil;
        [self.resultsLog addObject:self.displayResult.text];
        self.game.choicesAndResult = nil;
        self.rewindSlider.maximumValue = [self.resultsLog count];
        self.rewindSlider.value = self.rewindSlider.maximumValue;
    }
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)touchRewindSlider:(id)sender
{
    int resultsLogIndex = self.rewindSlider.value;
    if (resultsLogIndex >= [self.resultsLog count]) {
        resultsLogIndex = (int)[self.resultsLog count] -1;
    }
    self.displayResult.text = [NSString stringWithFormat:@"%@", [self.resultsLog objectAtIndex:resultsLogIndex]];
    self.displayResult.backgroundColor = [UIColor lightGrayColor];
}

- (IBAction)touchReDealButton:(UIButton *)sender
{
    self.scoreLabel.text = @"Score: 0";
    for (UIButton *cardButton in self.cardButtons) {
        [cardButton setTitle:@"" forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        cardButton.enabled = YES;
    }
    self.game = nil;
    self.resultsLog = nil;
    self.rewindSlider.value = 0;
    self.displayResult.text = @"";
}

@end












