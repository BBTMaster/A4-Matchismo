//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Wilson on 2014-02-26.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"


@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentedControl;
@property (weak, nonatomic) IBOutlet UIButton *redealButton;
@property (weak, nonatomic) IBOutlet UILabel *resultTextLabel;
//@property (nonatomic) NSMutableAttributedString *historyAttributedString;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSMutableAttributedString *title =
    [[NSMutableAttributedString alloc] initWithString:self.redealButton.currentTitle];
    [title addAttributes:@{NSStrokeWidthAttributeName:@3,
                           NSStrokeColorAttributeName:[UIColor blackColor]}
                   range:NSMakeRange(0,[title length])];
    [self.redealButton setAttributedTitle:title forState:UIControlStateNormal];
}


//Abstract method
- (Deck *)createDeck{
    return nil;
}

/*
- (NSMutableAttributedString *)historyAttributedString{
    if (!_historyAttributedString)
        _historyAttributedString = [[NSMutableAttributedString alloc] init];
    return _historyAttributedString;
}*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"PlayingCardGameSegue"]){
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]){
            HistoryViewController *hvc = (HistoryViewController *)segue.destinationViewController;
            hvc.historyResultText = self.game.historyResultText;
        }
    }
}


- (IBAction)touchCardButton:(UIButton *)sender {
    
    if (!self.game.gameStarted){
        self.game.gameStarted = 1;
        if (!self.gameModeSegmentedControl.selectedSegmentIndex)
            self.game.gameMode = @"2-Card-Mode";
        else
            self.game.gameMode = @"3-Card-Mode";
        [self disableSegmentedControl];
    }
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    //NSLog(@"%@", self.game.gameMode);
    if ([self.game.gameMode isEqualToString: @"2-Card-Mode"])
         [self.game chooseCardAtIndex:chosenButtonIndex];
    else if([self.game.gameMode isEqualToString:@"3-Card-Mode"])
        [self.game threeCardchooseCardAtIndex:chosenButtonIndex];
    
    [self updateUI];
}

- (void)updateUI{
    for (UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.resultTextLabel.text = [NSString stringWithFormat: @"%@",self.game.resultText];
}

- (IBAction)redealAction {
    for (UIButton *cardButton in self.cardButtons){
        [cardButton setTitle:@"" forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        cardButton.enabled = true;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", 0];
    self.game = nil;
    self.game.resultText = nil;
    self.resultTextLabel.text = @"";
    [self enableSegmentedControl];
    self.game.gameStarted = 0;
    self.game.gameMode = @"";
    self.gameModeSegmentedControl.selectedSegmentIndex = 0;
}

- (void)disableSegmentedControl{
    [self.gameModeSegmentedControl setEnabled:FALSE forSegmentAtIndex:0];
    [self.gameModeSegmentedControl setEnabled:FALSE forSegmentAtIndex:1];
}

- (void)enableSegmentedControl{
    [self.gameModeSegmentedControl setEnabled:TRUE forSegmentAtIndex:0];
    [self.gameModeSegmentedControl setEnabled:TRUE forSegmentAtIndex:1];
}

- (NSString *)titleForCard:(Card *)card{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
