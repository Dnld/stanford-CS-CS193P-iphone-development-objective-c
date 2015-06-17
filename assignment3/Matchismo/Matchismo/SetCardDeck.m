//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Donald Steinert on 6/17/15.
//  Copyright (c) 2015 Donald Steinert. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        for (NSString *symbol in [SetCard validSymbols]){
            for (UIColor *color in [SetCard validColors]) {
                for (NSString *shading in [SetCard validShadings]) {
                    for (int i = 1; i <= [SetCard maxNumber]; i++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.symbol = symbol;
                        card.color = color;
                        card.shading = shading;
                        card.number = i;
                        [self addCard:card];
                    }
                }
            }
        }
        
    }
    
    return self;
}

@end
