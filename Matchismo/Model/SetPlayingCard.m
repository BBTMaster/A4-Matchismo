//
//  SetPlayingCard.m
//  Matchismo
//
//  Created by Wilson on 2014-06-22.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "SetPlayingCard.h"


@implementation SetPlayingCard

+ (NSArray *)validColor{
    return @[@"cyanColor",@"lightGrayColor",@"purpleColor"];
}

+ (NSArray *)validSymbol{
    return @[@"▲",@"●",@"■"];
}

+ (NSArray *)validShading{
    return @[@"open", @"shaded", @"solid"];
}

+ (NSInteger)maxNumberOfSymbol{
    return 3;
}

- (NSString *)contents{
    //NSArray *rankStrings = [PlayingCard rankStrings];
    //return [rankStrings[self.rank] stringByAppendingString:self.suit];
    return [@"" stringByPaddingToLength:self.numberOfSymbol withString:self.symbol startingAtIndex:0];
   }

- (int)match:(NSArray *)otherCards{
    int score = 0;
    

    SetPlayingCard *firstOhterCard = [otherCards firstObject];
    SetPlayingCard *secondOhterCard = [otherCards objectAtIndex:1];
    if ((((self.numberOfSymbol != firstOhterCard.numberOfSymbol) && (self.numberOfSymbol != secondOhterCard.numberOfSymbol) && (firstOhterCard.numberOfSymbol != secondOhterCard.numberOfSymbol)) || ((self.numberOfSymbol == firstOhterCard.numberOfSymbol) && (self.numberOfSymbol == secondOhterCard.numberOfSymbol))) && (([self.symbol isEqualToString:firstOhterCard.symbol] && [self.symbol isEqualToString:secondOhterCard.symbol]) || (![self.symbol isEqualToString:firstOhterCard.symbol] && ![self.symbol isEqualToString:secondOhterCard.symbol] && ![firstOhterCard.symbol isEqualToString:secondOhterCard.symbol])) && (([self.shading isEqualToString:firstOhterCard.shading] && [self.shading isEqualToString:secondOhterCard.shading]) || (![self.shading isEqualToString:firstOhterCard.shading] && ![self.shading isEqualToString:secondOhterCard.shading] && ![firstOhterCard.shading isEqualToString:secondOhterCard.shading])) && (([self.color isEqualToString:firstOhterCard.color] && [self.color isEqualToString:secondOhterCard.color]) || (![self.color isEqualToString:firstOhterCard.color] && ![self.color isEqualToString:secondOhterCard.color] && ![firstOhterCard.color isEqualToString:secondOhterCard.color]))){
        score = 4;
    }
    
    
    return score;
}

@end
