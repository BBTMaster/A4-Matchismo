//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Wilson on 2014-02-26.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

//protected
- (Deck *)createDeck;

@end
