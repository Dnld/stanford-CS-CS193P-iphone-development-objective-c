//
//  PlayingCard.h
//  Matchismo
//
//  Created by Donald Steinert on 5/20/15.
//  Copyright (c) 2015 Donald Steinert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)rankStrings;
+ (NSUInteger)maxRank;
+ (NSArray *)validSuits;

@end
