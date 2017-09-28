//
//  SpinningViewController.m
//  GetFit
//
//  Created by jin on 1/6/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import "SpinningViewController.h"
#import "ViewExerciseViewController.h"
#import "HumanmusicViewController.h"
#import "SMRotaryWheel.h"
#import "AppDelegate.h"


@implementation SpinningViewController

@synthesize sectorLabel;
@synthesize wheel;

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
    self.videoID = 0;
    // 2 - Create sector label
//	sectorLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 350, 120, 30)];
//	sectorLabel.textAlignment = UITextAlignmentCenter;
//	[self.view addSubview:sectorLabel];
    // 3 - Set up rotary wheel
    wheel = [[SMRotaryWheel alloc] initWithFrame:CGRectMake(0, 0, 220, 220)
                                                    andDelegate:self
                                                   withSections:6];
    wheel.center = CGPointMake(160, 240);
    
    // 4 - Add wheel to view
    [self.view addSubview:wheel];
    
    isStarted = NO;
    [self.startButton setTitle:@"Start Spinning" forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.currentPlayer = [[DELEGATE playerStatus] objectAtIndex:currentPlayerIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) wheelDidChangeValue:(NSString *)newValue {
    self.sectorLabel.text = newValue;
}

- (void) setVideoID:(NSInteger)exId :(NSInteger)extype {
    self.currentPlayer.exerciseId = exId - 1;
    self.currentPlayer.exerciseType = extype;
    if (exId != 0) {
        self.currentPlayer.currentVideoId = (exId - 1) * 5 + extype - 1;
    } else {
        self.currentPlayer.currentVideoId = 0;
    }
    self.videoID = self.currentPlayer.currentVideoId;
}

- (IBAction)backButtonTUI:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)startButtonTUI:(id)sender {
    if(isStarted) {
        isStarted = NO;
        
        [self.startButton setTitle:@"Start Spinning" forState:UIControlStateNormal];
        [wheel stopTimer];
    } else {
        isStarted = YES;
        
        [self.startButton setTitle:@"Stop Spinning" forState:UIControlStateNormal];
        [wheel startTimer];
    }
}

- (IBAction)historyButtonTUI:(id)sender {
}

- (void) showChoiceMessage {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"\"%@\" got a combination of number %d and color WHITE", self.currentPlayer.playerName, self.currentPlayer.exerciseType] delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:@"View Exercise", nil];
    alert.tag = 2;
    [alert show];
}

- (void) showConfirmMessage {
    NSMutableArray *colorArray = [NSMutableArray arrayWithObjects:@"RED", @"YELLOW", @"BLUE", @"GREEN", @"ORANGE", nil];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"\"%@\" got a combination of number %d and color %@", self.currentPlayer.playerName, self.currentPlayer.exerciseType, (NSString *)[colorArray objectAtIndex:self.currentPlayer.exerciseId]] delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:@"View Exercise", nil];
    alert.tag = 1;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"ButtonIndex = %d", buttonIndex);
    if(alertView.tag == 1) {
        if(buttonIndex == 1) {
            ViewExerciseViewController *viewExController = [[ViewExerciseViewController alloc] initWithNibName:(rect.size.height < 568) ? @"ViewExerciseViewController_4s" : @"ViewExerciseViewController" bundle:nil];
            [self.navigationController pushViewController:viewExController animated:YES];
        }
    } else if(alertView.tag == 2) {
        if(buttonIndex == 1) {
            HumanmusicViewController *humanView = [[HumanmusicViewController alloc] initWithNibName:(rect.size.height < 568) ? @"HumanmusicViewController_4s" : @"HumanmusicViewController" bundle:nil tutorial:NO];
            [self.navigationController popToViewController:self animated:NO];
            [self.navigationController pushViewController:humanView animated:YES];
        }
    }
}

@end
