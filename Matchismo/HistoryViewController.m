//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Wilson on 2014-07-30.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *HistoryTextView;

@end

@implementation HistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self updateUI];
    //[self.tempLabel setAttributedText:self.tempHVNSAS];
    //[self.HistoryTextView setAttributedText:self.historyAttributedResultText];
    //self.HistoryTextView.attributedText = self.historyAttributedResultText;
    if (self.historyAttributedResultText)
        self.HistoryTextView.attributedText = self.historyAttributedResultText;
    else if (self.historyResultText)
        self.HistoryTextView.text = self.historyResultText;
    //[self.HistoryTextView.attributedText ]
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
