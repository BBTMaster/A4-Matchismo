//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Wilson on 2014-03-14.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableString *)resultText{
    if (!_resultText) _resultText = [[NSMutableString alloc] initWithString:@""];
    return _resultText;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck{
    self = [super init];
    
    if (self){
        for (int i = 0; i < count; i++){
            Card *card = [deck drawRandomcard];
            if (card){
                [self.cards addObject:card];
            } else{
                self = nil;
                break;
            }
        }
        
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSInteger)index{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    
    if(!card.isMatched){
        if (card.isChosen){
            card.chosen = NO;
            self.resultText = [NSMutableString stringWithString:@""];
        } else{
            if ([self.resultText isEqualToString:@""])
                self.resultText = [NSMutableString stringWithFormat:@"%@", card.contents];
            for (Card *otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched){
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore){
                        self.score += matchScore;
                        otherCard.matched = YES;
                        card.matched = YES;
                        self.resultText = [NSMutableString stringWithFormat:@"Matched %@ %@ for %d points.", card.contents, otherCard.contents, matchScore];
                        
                    }else{
                        self.resultText = [NSMutableString stringWithFormat:@"%@ %@ don’t match! %d points penalty!", card.contents, otherCard.contents, MISMATCH_PENALTY];
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (void)threeCardchooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    if(!card.isMatched){
        if (card.chosen){
            card.chosen = NO;
            NSMutableArray *cardsArray = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched)
                    [cardsArray addObject:otherCard];
            }
            if ([cardsArray count] == 0)
                self.resultText = [NSMutableString stringWithString:@""];
            else
                self.resultText = [NSMutableString stringWithFormat:@"%@", [[cardsArray firstObject] contents]];
            //self.resultText = [NSMutableString ];
        } else{
            //if ([self.resultText isEqualToString:@""])
                //self.resultText = [NSMutableString stringWithFormat:@"%@", card.contents];

            NSMutableArray *cardsArray = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched)
                    [cardsArray addObject:otherCard];
            }
            
            if ([cardsArray count] == 0)
                self.resultText = [NSMutableString stringWithFormat:@"%@", card.contents];
            else if ([cardsArray count] == 1)
                self.resultText = [NSMutableString stringWithFormat:@"%@ %@", [[cardsArray firstObject] contents],
                                   card.contents];
            
            if ([cardsArray count] == 2){
                //NSLog(@"3rd card is pressed!");
                int matchScore = [card match:cardsArray];
                if (matchScore){
                    self.score += matchScore;
                    for (Card *otherCards in cardsArray){
                        otherCards.matched = YES;
                    }
                     card.matched = YES;
                    self.resultText = [NSMutableString stringWithFormat:@"Matched %@ %@ %@ for %d points",
                                       [[cardsArray firstObject] contents],[[cardsArray objectAtIndex:1] contents], card.contents, matchScore];
                }else{
                    self.score -= MISMATCH_PENALTY;
                    for (Card *otherCards in cardsArray){
                        otherCards.chosen = NO;
                    }
                    self.resultText = [NSMutableString stringWithFormat:@"%@ %@ %@ don't match! %d points penalty!",
                                       [[cardsArray firstObject] contents],[[cardsArray objectAtIndex:1] contents], card.contents, MISMATCH_PENALTY];
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
        
    }
    
}


@end
