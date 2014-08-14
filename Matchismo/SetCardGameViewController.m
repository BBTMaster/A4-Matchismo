//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Wilson on 2014-06-21.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "CardMatchingGame.h"
#import "SetCardDeck.h"
#import "SetPlayingCard.h"
#import "HistoryViewController.h"

@interface SetCardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *resultTextLabel;
@property (nonatomic) NSMutableAttributedString *historyAttributedString;
@end

@implementation SetCardGameViewController

- (CardMatchingGame *)game{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

- (SetCardDeck *)createDeck{
    return [[SetCardDeck alloc] init];
}

- (NSMutableAttributedString *)historyAttributedString{
    if (!_historyAttributedString)
        _historyAttributedString = [[NSMutableAttributedString alloc] init];
    return _historyAttributedString;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"SetCardGameSegue"]){
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]){
            HistoryViewController *hvc = (HistoryViewController *)segue.destinationViewController;
            hvc.historyAttributedResultText = self.historyAttributedString;
            //tsvc.TextToAnalyze = self.textView.textStorage;
        }
    }
}


- (IBAction)touchCardButton:(UIButton *)sender {
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game setCardMatchAtIndex:chosenButtonIndex];
    
    for (UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    SetPlayingCard *firstCard = [self.game.resultArray firstObject];
    
    NSMutableAttributedString *mutableAttStringResult = [[NSMutableAttributedString alloc] init];
    NSAttributedString *firstCardString = [[NSAttributedString alloc] initWithString:@""];
    int count = [self.game.resultArray count];
    if (firstCard){
            firstCardString = [self setAttributes:firstCard];
            [mutableAttStringResult appendAttributedString:firstCardString];
    }
    if (count == 2){
        SetPlayingCard *secondCard = [self.game.resultArray objectAtIndex:1];
        NSAttributedString *secondCardString = [self setAttributes:secondCard];
        [mutableAttStringResult appendAttributedString:secondCardString];
    }
    if (count == 3){
        SetPlayingCard *secondCard = [self.game.resultArray objectAtIndex:1];
        NSAttributedString *secondCardString = [self setAttributes:secondCard];
        [mutableAttStringResult appendAttributedString:secondCardString];

        SetPlayingCard *thirdCard = [self.game.resultArray objectAtIndex:2];
        NSAttributedString *thirdCardString = [self setAttributes:thirdCard];
        [mutableAttStringResult appendAttributedString:thirdCardString];
        NSAttributedString *fourPoints = [[NSAttributedString alloc] initWithString:@"Match (+4)"];
        NSAttributedString *downTwoPoints = [[NSAttributedString alloc] initWithString:@"Don't match (-2)"];
        NSAttributedString *linebreak = [[NSAttributedString alloc] initWithString:@"\n"];
        //NSLog(@"matchsore is %d", self.game.matchScore);
        if (self.game.matchScore >0)
            [mutableAttStringResult appendAttributedString:fourPoints];
        else
            [mutableAttStringResult appendAttributedString:downTwoPoints];
        [mutableAttStringResult appendAttributedString:linebreak];
        [self.historyAttributedString appendAttributedString:mutableAttStringResult];
        //self.historyAttributedString = mutableAttStringResult;
        //[self.historyAttributedString appendAttributedString:mutableAttStringResult];
        //[self.historyAttributedString appendAttributedString:linebreak];
    }
    [self.resultTextLabel setAttributedText:mutableAttStringResult];
    self.score.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    //NSMutableAttributedString *tempAttributedTitile = [self setAttributes:setPlayingCard.contents withSetPlayingCard:setPlayingCard];
    //self.resultTextLabel.text = tempAttributedTitile;
    
}

- (NSMutableAttributedString *)setAttributes:(SetPlayingCard *)setPlayingCard{
    NSDictionary *shadingDictionary = @{@"open": @0.0f,
                                        @"shaded": @0.3f,
                                        @"solid": @1.0f};
    
    Float32 shadingValue = [shadingDictionary[setPlayingCard.shading] floatValue];
    
    
    NSDictionary *colorDictionary =@{@"cyanColor": [UIColor cyanColor],
                                     @"lightGrayColor": [UIColor lightGrayColor],
                                     @"purpleColor": [UIColor purpleColor]};
    
    
    NSDictionary *shadingColorDictionary =@{@"cyanColor": [[UIColor cyanColor] colorWithAlphaComponent:shadingValue],
                                            @"lightGrayColor": [[UIColor lightGrayColor] colorWithAlphaComponent:shadingValue],
                                            @"purpleColor": [[UIColor purpleColor] colorWithAlphaComponent:shadingValue]};
    
    
    
    NSMutableAttributedString *mutableCardContent = [[NSMutableAttributedString alloc] initWithString:setPlayingCard.contents];
    
    if ([setPlayingCard.shading isEqualToString:@"open"]){
        [mutableCardContent addAttributes:@{NSFontAttributeName :
                                                [UIFont systemFontOfSize:25],
                                            NSStrokeWidthAttributeName:@3,
                                            NSStrokeColorAttributeName:colorDictionary[setPlayingCard.color]}
                                    range:NSMakeRange(0,[mutableCardContent length])];
    } else if([setPlayingCard.shading isEqualToString:@"shaded"]){
        [mutableCardContent addAttributes:@{NSFontAttributeName :
                                                [UIFont systemFontOfSize:25],
                                            NSForegroundColorAttributeName:shadingColorDictionary[setPlayingCard.color]}
                                    range:NSMakeRange(0,[mutableCardContent length])];
    } else if([setPlayingCard.shading isEqualToString:@"solid"]){
        [mutableCardContent addAttributes:@{NSFontAttributeName :
                                                [UIFont systemFontOfSize:25],
                                            NSForegroundColorAttributeName:colorDictionary[setPlayingCard.color]}
                                    range:NSMakeRange(0,[mutableCardContent length])];
    }

    return mutableCardContent;
}


- (void)displaySetCards{
    for (UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        SetPlayingCard *setPlayingCard = (SetPlayingCard *)card;
        
        //NSMutableAttributedString *tempAttributedTitile = [self setAttributes:card.contents withSetPlayingCard:setPlayingCard];
        NSMutableAttributedString *tempAttributedTitile = [self setAttributes:setPlayingCard];
        [cardButton setAttributedTitle:tempAttributedTitile forState:UIControlStateNormal];
    }
    //self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    //self.resultTextLabel.text = [NSString stringWithFormat: @"%@",self.game.resultText];
}


- (IBAction)redealAction {
    self.game = nil;
    for (UIButton *cardButton in self.cardButtons){
        //[cardButton setTitle:@"" forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
        cardButton.enabled = true;
    }
    self.game.resultText = nil;
    self.resultTextLabel.text = @"";
    self.score.text = [NSString stringWithFormat:@"Score: %d", 0];
    [self displaySetCards];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"light-blue" : @"cardfront"];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self displaySetCards];
    // Do any additional setup after loading the view.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
