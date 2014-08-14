//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Wilson on 2014-06-22.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetPlayingCard.h"

@implementation SetCardDeck

- (instancetype)init{
    self = [super init];
    int count = 0;
    if (self) {
        for (NSString *symbol in [SetPlayingCard validSymbol]) {
            for (NSUInteger num = 1; num <= [SetPlayingCard maxNumberOfSymbol]; num++){
                for (NSString *shading in [SetPlayingCard validShading]){
                    for (NSString *color in [SetPlayingCard validColor]){
                        SetPlayingCard *card = [[SetPlayingCard alloc] init];
                        card.color = color;
                        card.shading = shading;
                        card.symbol = symbol;
                        card.numberOfSymbol = num;
                        //card.chosen = YES;
                        [self addCard:card];
                        count ++;
                       // NSLog(@"color:%@, shading:%@, symbol:%@, number:%d count:%d", card.color, card.shading, card.symbol, card.numberOfSymbol, count);
                    }
                }
            }
        }
    }
    return self;
}

@end
