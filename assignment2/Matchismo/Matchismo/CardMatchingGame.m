//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Donald Steinert on 5/27/15.
//  Copyright (c) 2015 Donald Steinert. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSMutableArray *choicesAndResult;
@property (nonatomic, strong) NSMutableArray *cards; // of Card

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 1;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
            withThreeCardMatchMode:(BOOL)mode;
{
    Card *card = [self cardAtIndex:index];

    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            self.choicesAndResult = @[@[card], [NSNumber numberWithInt:0]];
        } else {
            // match card against other chosen card
            if (!mode) {
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            otherCard.matched = YES;
                            card.matched = YES;
                            self.choicesAndResult = @[@[card, otherCard], [NSNumber numberWithInt:matchScore * MATCH_BONUS]];
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                            self.choicesAndResult = @[@[card, otherCard], [NSNumber numberWithInt:-MISMATCH_PENALTY]];
                        }
                        break;
                    }
                }
            } else {
                NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        [chosenCards addObject:otherCard];
                    }
                }
                if ([chosenCards count] == 2) {
                    int firstMatchScore = [card match:@[chosenCards[0]]];
                    int secondMatchScore = [card match:@[chosenCards[1]]];
                    int matchScore = firstMatchScore >= secondMatchScore ? firstMatchScore : secondMatchScore;
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS / 2;
                        for (Card *otherCard in chosenCards) {
                            otherCard.matched = YES;
                        }
                        card.matched = YES;
                        self.choicesAndResult = @[@[card, firstMatchScore >= secondMatchScore ? chosenCards[0] : chosenCards[1]], [NSNumber numberWithInt:matchScore * MATCH_BONUS]];
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        self.choicesAndResult = @[@[card, chosenCards[0], chosenCards[1]], [NSNumber numberWithInt:-MISMATCH_PENALTY - COST_TO_CHOOOSE]];
                        for (Card *otherCard in chosenCards) {
                            otherCard.chosen = NO;
                        }
                    }
                }
            }
            self.score -= COST_TO_CHOOOSE;
            card.chosen = YES;
        }
        
    }
}

@end
