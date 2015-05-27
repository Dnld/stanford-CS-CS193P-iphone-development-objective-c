//
//  PlayingCard.m
//  Matchismo
//
//  Created by Donald Steinert on 5/20/15.
//  Copyright (c) 2015 Donald Steinert. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

// needed because we use custom getter and setter methods
@synthesize suit = _suit;

// valid ranks
+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8",
      @"9", @"10", @"J", @"Q", @"K"];
}

// maximum ranking
+ (NSUInteger)maxRank
{
    return [[self rankStrings] count] - 1;
}

// valid suits
+ (NSArray *)validSuits
{
    return @[@"♠️", @"♣️", @"♥️", @"♦️"];
}

// custom getter for inhereted contents property to display rank and suit
- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

// custom getter for suit to return "?" if card has suit nil
- (NSString *)suit
{
    return _suit ? _suit : @"?";
}
            
// custom setter for rank to ensure rank is a proper value
- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        }
    }
    
    return score;
}

@end
