//
//  HumanmusicViewController.m
//  GetFit
//
//  Created by jin on 1/8/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import "HumanmusicViewController.h"
#import "HistoryViewController.h"
#import "ViewExerciseViewController.h"
#import "VideoListViewController.h"
#import "AppDelegate.h"

@interface HumanmusicViewController () <UIAlertViewDelegate>

@end

@implementation HumanmusicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil tutorial:(BOOL)isTutorial
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        forTutorial = isTutorial;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    eType = 0;
    if(forTutorial) {
        [self.titleLabel setText:@"VIDEO TUTORIALS"];
        [self.historyButton setAlpha:0];
        [self.workoutButton setTitle:@"See All Videos" forState:UIControlStateNormal];
    } else {
        [self.titleLabel setText:@"CHOOSE"];
        [self.historyButton setAlpha:1];
        [self.workoutButton setTitle:@"Exercise History" forState:UIControlStateNormal];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    exID = 0;
    if([DELEGATE playerStatus].count != 0) {
        self.currentPlayer = [[DELEGATE playerStatus] objectAtIndex:currentPlayerIndex];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setVideoID:(NSInteger)exId :(NSString *)color{
    self.currentPlayer.exerciseId = exId;
    self.currentPlayer.currentVideoId = exId * 5 + self.currentPlayer.exerciseType - 1;
    videoId = self.currentPlayer.currentVideoId;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Physical Tuning" message:[NSString stringWithFormat:@"\"%@\" have selected %@ Muscle Group.\nDo you want to continue?", self.currentPlayer.playerName, color] delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    alertView.tag = 1;
    [alertView show];
}

- (void) viewTutorial:(NSInteger)exId :(NSString *)color{
    eType = exId;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Physical Tuning" message:[NSString stringWithFormat:@"You have selected %@ Muscle Group.\nDo you want to continue?", color] delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    alertView.tag = 2;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag == 1) {
        if(buttonIndex == 1) {
            ViewExerciseViewController *viewExController = [[ViewExerciseViewController alloc] initWithNibName:(rect.size.height < 568) ? @"ViewExerciseViewController_4s" : @"ViewExerciseViewController" bundle:nil];
            [self.navigationController pushViewController:viewExController animated:YES];
        }
    } else if(alertView.tag == 2) {
        if(buttonIndex == 1) {
            VideoListViewController *videoListView = [[VideoListViewController alloc] initWithNibName:(rect.size.height < 568) ? @"VideoListViewController_4s" : @"VideoListViewController" bundle:nil color:eType];
            [self.navigationController pushViewController:videoListView animated:YES];
        }
    }
}

- (IBAction)redButtonTUI:(id)sender {
    if(forTutorial) {
        [self viewTutorial:0:@"RED"];
    } else {
        [self setVideoID:0:@"RED"];
    }
}

- (IBAction)greenButtonTUI:(id)sender {
    if(forTutorial) {
        [self viewTutorial:3:@"GREEN"];
    } else {
        [self setVideoID:3:@"GREEN"];
    }
}

- (IBAction)blueButtonTUI:(id)sender {
    if(forTutorial) {
        [self viewTutorial:2:@"BLUE"];
    } else {
        [self setVideoID:2:@"BLUE"];
    }
}

- (IBAction)orangButtonTUI:(id)sender {
    if(forTutorial) {
        [self viewTutorial:4:@"ORANGE"];
    } else {
        [self setVideoID:4:@"ORANGE"];
    }
}

- (IBAction)yellowButtonTUI:(id)sender {
    if(forTutorial) {
        [self viewTutorial:1:@"YELLOW"];
    } else {
        [self setVideoID:1:@"YELLOW"];
    }
}

- (IBAction)historyButtonTUI:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"It is %@'s turn.", self.currentPlayer.playerName] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)workoutButtonTUI:(id)sender {
    if(forTutorial) {
        VideoListViewController *videoListView = [[VideoListViewController alloc] initWithNibName:(rect.size.height < 568) ? @"VideoListViewController_4s" : @"VideoListViewController" bundle:nil color:ALL];
        [self.navigationController pushViewController:videoListView animated:YES];
    } else {
        HistoryViewController *history = [[HistoryViewController alloc] initWithNibName:(rect.size.height < 568) ? @"HistoryViewController_4s" : @"HistoryViewController" bundle:nil show:YES];
        [self.navigationController pushViewController:history animated:YES];
    }
}

- (IBAction)backButtonTUI:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
