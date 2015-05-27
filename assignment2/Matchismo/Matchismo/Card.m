//
//  Card.m
//  Matchismo
//
//  Created by Donald Steinert on 5/20/15.
//  Copyright (c) 2015 Donald Steinert. All rights reserved.
//

#import "Card.h"

@interface Card()

// for private declarations

@end

@implementation Card


// instance method to provide a score for quality of a match
// will retrun 1 if cards match
- (int)matched:(NSArray*)otherCards
{
    int score = 0;
    
    for (Card *c in otherCards) {
        if ([c.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
