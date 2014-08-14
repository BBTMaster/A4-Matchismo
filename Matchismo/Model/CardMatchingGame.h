//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Wilson on 2014-03-14.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger) count
                         usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSInteger)index;
- (void)threeCardchooseCardAtIndex:(NSUInteger)index;
- (void)setCardMatchAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger matchScore;
@property (nonatomic) NSInteger gameStarted;
@property (nonatomic, weak) NSString *gameMode;
@property (nonatomic, strong) NSMutableString *resultText;
@property (nonatomic) NSMutableArray *resultArray;
@property (nonatomic, strong) NSMutableString *historyResultText;
@end
