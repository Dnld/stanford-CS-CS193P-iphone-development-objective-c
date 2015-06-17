//
//  SetCardViewController.m
//  Matchismo
//
//  Created by Donald Steinert on 6/17/15.
//  Copyright (c) 2015 Donald Steinert. All rights reserved.
//

#import "SetCardViewController.h"
#import "SetCardDeck.h"

@interface SetCardViewController ()

@end

@implementation SetCardViewController

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

@end
