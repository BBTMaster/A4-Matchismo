//
//  SetPlayingCard.h
//  Matchismo
//
//  Created by Wilson on 2014-06-22.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "Card.h"

@interface SetPlayingCard : Card
@property NSString* color;
@property NSString* shading;
@property NSString* symbol;
@property NSInteger numberOfSymbol;

+(NSArray *)validShading;
+(NSArray *)validColor;
+(NSArray *)validSymbol;
+(NSInteger)maxNumberOfSymbol;


@end
