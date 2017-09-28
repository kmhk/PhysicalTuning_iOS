//
//  ViewExerciseViewController.m
//  GetFit
//
//  Created by jin on 1/7/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import "ViewExerciseViewController.h"
#import "CountViewController.h"
#import "HistoryViewController.h"
#import "Exercise.h"
#import "Global.h"
#import "AppDelegate.h"

@interface ViewExerciseViewController () <UIAlertViewDelegate>

@end

@implementation ViewExerciseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.failView setAlpha:0];
    self.diceColorFaces = [DELEGATE videoArray];
    
    allNameArray = [NSMutableArray arrayWithObjects: @"Burpees",
                                    @"Mountain Climbers",
                                    @"Combined Burpees",
                                    @"Sprinting",
                                    @"Starjumps",
                                    @"Push-Ups Regular",
                                    @"Push-Ups Staggered",
                                    @"Push-Ups Hindu",
                                    @"Push-Ups Small",
                                    @"Push-Ups Spiderman",
                                    @"Reverse Crunch",
                                    @"V-Snaps",
                                    @"Cycling",
                                    @"Sit-Ups Regular",
                                    @"Penguin",
                                    @"Lunges",
                                    @"Lunges Jumps",
                                    @"Squat Jumps",
                                    @"Skating",
                                    @"Prison Squats",
                                    @"Hip Raises",
                                    @"Planking Regular",
                                    @"Planking Superman",
                                    @"Para Regular",
                                    @"Planking Expert", nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.currentPlayer = [[DELEGATE playerStatus] objectAtIndex:currentPlayerIndex];
    NSLog(@"Video ID = %d", self.currentPlayer.currentVideoId);
    NSString *videoNanme = (NSString *)[self.diceColorFaces objectAtIndex:self.currentPlayer.currentVideoId];
    NSString *title = [allNameArray objectAtIndex:self.currentPlayer.currentVideoId];
    [self.titleLabel setText:title];
    
    self.movieController = [[MPMoviePlayerController alloc] init];
    self.movieController.view.frame = self.videoView.bounds;
    self.movieController.view.clipsToBounds = YES;
    [self.movieController setBackgroundColor:[UIColor whiteColor]];
    [self.videoView addSubview:self.movieController.view];
    [self.movieController.view setAlpha:1];
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:videoNanme ofType:@"mp4"];
    [self.movieController setContentURL:[NSURL fileURLWithPath:videoPath]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.movieController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(moviePlayLoadDidFinish:)
												 name:MPMoviePlayerLoadStateDidChangeNotification
											   object:self.movieController];
    
    
    [self.movieController prepareToPlay];
    
    if(isExercised) {
        [self.failView setAlpha:1];
    } else {
        [self.failView setAlpha:0];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moviePlayBackDidFinish:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [self.movieController pause];
}

- (void)moviePlayLoadDidFinish:(NSNotification *)notification
{
    [self.movieController pause];
	if ([self.movieController loadState] == MPMovieLoadStatePlayable) {
        
		NSLog( @"Video preparing start" );
    } else {
		NSLog( @"Video preparing finished" );
    }
}

- (IBAction)backButtonTUI:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"About to End Game!" message:@"All current game progress will be lost\nAre you sure you want to end this workout? Please don't.\nYou can do it!" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    alertView.tag = 1;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (IBAction)failButtonTUI:(id)sender {
    [self continuGame];
}

- (void)continuGame {
    currentPlayerIndex++;
    isTuning = YES;
    if(!self.currentPlayer.isFinished)    self.currentPlayer.exerciseNumber++;
    HistoryViewController *historyView = [[HistoryViewController alloc] initWithNibName:(rect.size.height < 568) ? @"HistoryViewController_4s" : @"HistoryViewController" bundle:nil show:NO];
    [self.navigationController pushViewController:historyView animated:YES];
}

- (IBAction)goodButtonTUI:(id)sender {
    if(!self.currentPlayer.isFinished) {
       
        Exercise *thisEx = (Exercise *)[self.currentPlayer.exStatus objectAtIndex:self.currentPlayer.exerciseId];
        if(thisEx.exStatus < BOTH_EXERCISE) {
            thisEx.exStatus++;
            self.currentPlayer.successNumber++;
        }
        
        int counter = 0;
        for(Exercise *e in self.currentPlayer.exStatus) {
            if(e.exStatus == BOTH_EXERCISE) {
                counter++;
            }
        }
        
        if(counter == 5) self.currentPlayer.isFinished = YES;
    }
    
    [self continuGame];
}

- (IBAction)historyButtonTUI:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"It is %@'s turn.", self.currentPlayer.playerName] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)workoutButtonTUI:(id)sender {
    isExercised = NO;
    CountViewController *counterView = [[CountViewController alloc] initWithNibName:(rect.size.height < 568) ? @"CountViewController_4s" : @"CountViewController" bundle:nil];
    [self.navigationController pushViewController:counterView animated:YES];
}
@end
