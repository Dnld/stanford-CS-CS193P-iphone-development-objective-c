//
//  Deck.m
//  Matchismo
//
//  Created by Donald Steinert on 5/20/15.
//  Copyright (c) 2015 Donald Steinert. All rights reserved.
//

#import "Deck.h"

@interface Deck ()

// mutable array of cards
@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation Deck

- (NSMutableArray *)cards
{
    // getter to instantiate cards if it does not already exist when called
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

// adds card to top of deck
- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

- (void)addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}


// gets random card from cards array
- (Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
        
    return randomCard;
}

@end
