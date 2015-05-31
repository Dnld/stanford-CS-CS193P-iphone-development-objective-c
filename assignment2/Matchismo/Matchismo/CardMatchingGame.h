//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Donald Steinert on 5/27/15.
//  Copyright (c) 2015 Donald Steinert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) NSInteger score;

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index
   withThreeCardMatchMode:(BOOL)mode;
- (Card *)cardAtIndex:(NSUInteger)index;

@end
