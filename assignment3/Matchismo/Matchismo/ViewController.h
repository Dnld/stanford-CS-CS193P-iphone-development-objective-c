//
//  ViewController.h
//  Matchismo
//
//  Created by Donald Steinert on 5/20/15.
//  Copyright (c) 2015 Donald Steinert. All rights reserved.
//
//  Abstract superclass. Subclasses must implement methods as described below
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface ViewController : UIViewController

//  must be implemented in sublasses
- (Deck *)createDeck;  // abstract

@end

