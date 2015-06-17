//
//  SetCard.h
//  Matchismo
//
//  Created by Donald Steinert on 6/15/15.
//  Copyright (c) 2015 Donald Steinert. All rights reserved.
//

#import "Card.h"
#import "UIKit/UIKit.h"

@interface SetCard : Card

@property (nonatomic, strong) NSString *symbol;
@property (nonatomic) NSUInteger number;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSString *shading;

+ (NSArray *)validSymbols;
+ (NSUInteger)maxNumber;
+ (NSArray *)validColors;
+ (NSArray *)validShadings;

@end
