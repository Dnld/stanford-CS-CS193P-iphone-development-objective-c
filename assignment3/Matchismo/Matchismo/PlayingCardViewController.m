//
//  PlayingCardViewController.m
//  Matchismo
//
//  Created by Donald Steinert on 6/15/15.
//  Copyright (c) 2015 Donald Steinert. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardViewController ()

@end

@implementation PlayingCardViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end
