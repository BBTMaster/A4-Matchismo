//
//  SetCardGameViewController.h
//  Matchismo
//
//  Created by Wilson on 2014-06-21.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCardDeck.h"

@interface SetCardGameViewController : UIViewController
- (SetCardDeck *)createDeck;
@end
