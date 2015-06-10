//
//  ViewController.m
//  Matchismo
//
//  Created by Donald Steinert on 5/20/15.
//  Copyright (c) 2015 Donald Steinert. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UISwitch *threeCardMatchMode;
@property (strong, nonatomic) IBOutlet UILabel *displayResult;
@property (strong, nonatomic) NSMutableArray *resultsLog;
@property (strong, nonatomic) IBOutlet UISlider *rewindSlider;


@end

@implementation ViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        self.threeCardMatchMode.on = NO;
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
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex withThreeCardMatchMode:self.threeCardMatchMode.isOn];
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
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
    self.threeCardMatchMode.on = YES;
    self.rewindSlider.value = 0;
    self.displayResult.text = @"";
}

@end












