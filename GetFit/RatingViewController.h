//
//  RatingViewController.h
//  GetFit
//
//  Created by jin on 1/8/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface RatingViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    int ranking;
    NSMutableArray *iconArray;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) SLComposeViewController    *mySLComposerSheet;
@property (nonatomic,strong) NSMutableArray             *rankingArray;

- (IBAction)facebookButtonTUI:(id)sender;
- (IBAction)twitterButtonTUI:(id)sender;
- (IBAction)completeButtonTUI:(id)sender;

@end
