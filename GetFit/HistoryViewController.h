//
//  HistoryViewController.h
//  GetFit
//
//  Created by jin on 1/6/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundView.h"

@interface HistoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    BOOL    isShowHistory;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *pList;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *historyButton;
@property (strong, nonatomic) IBOutlet UIButton *continuButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil show:(BOOL)isShow;
- (IBAction)backButtonTUI:(id)sender;
- (IBAction)humanButtonTUI:(id)sender;
- (IBAction)continueButtonTUI:(id)sender;

@end
