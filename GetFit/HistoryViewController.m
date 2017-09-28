//
//  HistoryViewController.m
//  GetFit
//
//  Created by jin on 1/6/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import "HistoryViewController.h"
#import "SpinningViewController.h"
#import "RatingViewController.h"
#import "AppDelegate.h"
#import "Exercise.h"
#import "PlayerCell.h"
#import <QuartzCore/QuartzCore.h>

@interface HistoryViewController () <UIAlertViewDelegate>

@end

@implementation HistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil show:(BOOL)isShow
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isShowHistory = isShow;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSMutableArray *imageArray = [NSMutableArray arrayWithObjects:
                                  @"red_box.png",
                                  @"yellow_box.png",
                                  @"blue_box.png",
                                  @"green_box.png",
                                  @"orange_box.png",
                                  nil];
    NSMutableArray *nameArray = [NSMutableArray arrayWithObjects:
                                  @"Fat Burner",
                                  @"Upper Body",
                                  @"Belly",
                                  @"Legs",
                                  @"Core",
                                  nil];
    
    self.pList = [DELEGATE playerStatus];
    if(currentPlayerIndex >= self.pList.count) {
        currentPlayerIndex = 0;
    }
    
    for(int i = 0; i<5; i++) {
        RoundView * rImageView = [[RoundView alloc] initWithFrame:CGRectMake(i*52+56, 60, 52, 70)];
        [self.view addSubview:rImageView];
    
        NSString *imageFile = (NSString *)[imageArray objectAtIndex:i];
        [rImageView.exImage setImage:[UIImage imageNamed:imageFile]];

        [rImageView.exName setText:[nameArray objectAtIndex:i]];
        
    }
    
    if(isShowHistory) {
        [self.titleLabel setText:@"Exercise History"];
        [self.continuButton setTitle:@"Previous" forState:UIControlStateNormal];
    } else {
        [self.titleLabel setText:@"PHYSICAL TUNING"];
        [self.continuButton setTitle:@"Continue" forState:UIControlStateNormal];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView
- (int)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *setCellIdentfier = @"setCellIdentifier";
    
    PlayerCell *cell = (PlayerCell *)[tableView dequeueReusableCellWithIdentifier:setCellIdentfier];// [[UITableViewCell alloc] init];
    if(nil==cell) {
        cell = [[PlayerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:setCellIdentfier];
    }
    
    Player *p = [self.pList objectAtIndex:indexPath.row];
    [cell.playerView.exName setText:p.playerName];
    
    for(int i = 0; i < p.exStatus.count; i++) {
        Exercise *e = [p.exStatus objectAtIndex:i];
        UIImageView *iView = (UIImageView *)[cell.imageArray objectAtIndex:i];
        switch (e.exStatus) {
            case NON_EXERCISE:
                [iView setImage:[UIImage imageNamed:@"cellGeneral2.png"]];
                break;
            case EITHER_EXERCISE:
                [iView setImage:[UIImage imageNamed:@"CircleHalf.png"]];
                break;
            case BOTH_EXERCISE:
                [iView setImage:[UIImage imageNamed:@"CircleFull.png"]];
                break;
            default:
                [iView setImage:[UIImage imageNamed:@"cellGeneral2.png"]];
                break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    TableCell *cell = (TableCell *)[tableView cellForRowAtIndexPath:indexPath];
    
}

- (IBAction)backButtonTUI:(id)sender {
    if(isTuning){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"About to End Game!" message:@"All current game progress will be lost\nAre you sure you want to end this workout? Please don't.\nYou can do it!" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        alertView.tag = 1;
        [alertView show];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag == 1) {
        if(buttonIndex == 1) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } else if(alertView.tag == 2) {
        if(buttonIndex == 1) {
            RatingViewController *rankingView = [[RatingViewController alloc] initWithNibName:(rect.size.height < 568) ? @"RatingViewController_4s" : @"RatingViewController" bundle:nil];
            [self.navigationController pushViewController:rankingView animated:YES];
        } else {
            SpinningViewController *spinView = [[SpinningViewController alloc] initWithNibName:(rect.size.height < 568) ? @"SpinningViewController_4s" : @"SpinningViewController" bundle:nil];
            [self.navigationController pushViewController:spinView animated:YES];
        }
    }
}

- (IBAction)humanButtonTUI:(id)sender {
}

- (IBAction)continueButtonTUI:(id)sender {
    if(isShowHistory) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        isExercised = NO;
        if([self isOneCircle]){
            if([self isAllFinished]) {
                RatingViewController *rankingView = [[RatingViewController alloc] initWithNibName:(rect.size.height < 568) ? @"RatingViewController_4s" : @"RatingViewController" bundle:nil];
                [self.navigationController pushViewController:rankingView animated:YES];
            } else {
                NSString *names = [self finishPlayersName];
                if(![names isEqualToString:@""]) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@ was finished already all exercisese. Do you want continue for other players?", names] delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
                    alertView.tag = 2;
                    [alertView show];
                } else {
                    SpinningViewController *spinView = [[SpinningViewController alloc] initWithNibName:(rect.size.height < 568) ? @"SpinningViewController_4s" :@"SpinningViewController"  bundle:nil];
                    [self.navigationController pushViewController:spinView animated:YES];
                }
            }
        } else {
            SpinningViewController *spinView = [[SpinningViewController alloc] initWithNibName:(rect.size.height < 568) ? @"SpinningViewController_4s" : @"SpinningViewController" bundle:nil];
            [self.navigationController pushViewController:spinView animated:YES];
        }
    }
}

- (BOOL)isAllFinished {
    for (Player *p in self.pList) {
        if(!p.isFinished) {
            return NO;
        }
    }
    
    return  YES;
}

- (NSString *)finishPlayersName {
    NSString *nameList = @"";
    for (Player *p in self.pList) {
        if(p.isFinished) {
            nameList = [NSString stringWithFormat:@"%@\"%@\" ", nameList, p.playerName];
        }
    }
    
    return  nameList;
}

- (BOOL)isOneCircle {
    if(currentPlayerIndex == 0) return YES;
    
    return NO;
}

@end
