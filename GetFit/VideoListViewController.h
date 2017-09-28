//
//  VideoListViewController.h
//  GetFit
//
//  Created by jin on 1/8/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"

@interface VideoListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    exerciseType    eType;
    NSMutableArray  *videoArray;
    NSMutableArray  *videoNameArray;
}
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil color:(exerciseType)type;
- (IBAction)backButtonTUI:(id)sender;
@end
