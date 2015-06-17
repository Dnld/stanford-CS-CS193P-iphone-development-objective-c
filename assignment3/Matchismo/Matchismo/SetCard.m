//
//  SetCard.m
//  Matchismo
//
//  Created by Donald Steinert on 6/15/15.
//  Copyright (c) 2015 Donald Steinert. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSArray *)validSymbols
{
    return @[@"▴", @"•", @"■"];
}

+ (NSUInteger)maxNumber
{
    return [[self validSymbols] count];
}

+ (NSArray *)validColors
{
    return @[@[[UIColor redColor]], @[[UIColor greenColor]], @[[UIColor purpleColor]]];
}

+ (NSArray *)validShadings
{
    return @[@"solid", @"striped", @"open"];
}

// custom getter for contents
- (NSString *)contents
{
    NSString *setCardContents = [[NSString alloc] init];
    for (int i = 0; i <= self.number; i++) {
        
    }
    
    
    
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (void)setNumber:(NSUInteger)number
{
    if (number <= [SetCard maxNumber] && number != 0) {
        _number = number;
    }
}

- (void)setColor:(UIColor *)color
{
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

@end











