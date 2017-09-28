//
//  PlayerViewController.m
//  GetFit
//
//  Created by jin on 1/5/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import "PlayerViewController.h"
#import "HistoryViewController.h"
#import "Global.h"
#import "AppDelegate.h"

@interface PlayerViewController ()

@end

@implementation PlayerViewController

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
    [self.maskView setAlpha:0];
    [self.nameInputView setFrame:CGRectMake(10, 0-self.nameInputView.frame.size.height, self.nameInputView.frame.size.width, self.nameInputView.frame.size.height)];
    [self player1ButtonTUI:nil];
    [self sec15ButtonTUI:nil];
    playerList = [NSMutableArray array];
    playerIndex = 1;
    
    [DELEGATE initPlayerList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [self.durationSegment setFrame:CGRectMake(10, 312, 300, 48)];
    [self.durationSegment setNeedsDisplay];
}

- (IBAction)playerNameTextField:(id)sender {
}

- (IBAction)player1ButtonTUI:(id)sender {
    players = 1;
    [self.player1Button setImage:[UIImage imageNamed:@"player_1_N.png"] forState:UIControlStateNormal];
    [self.player2Button setImage:[UIImage imageNamed:@"player_2_H.png"] forState:UIControlStateNormal];
    [self.player3Button setImage:[UIImage imageNamed:@"player_3_H.png"] forState:UIControlStateNormal];
    [self.player4Button setImage:[UIImage imageNamed:@"player_4_H.png"] forState:UIControlStateNormal];
}

- (IBAction)player2ButtonTUI:(id)sender {
    players = 2;
    [self.player1Button setImage:[UIImage imageNamed:@"player_1_H.png"] forState:UIControlStateNormal];
    [self.player2Button setImage:[UIImage imageNamed:@"player_2_N.png"] forState:UIControlStateNormal];
    [self.player3Button setImage:[UIImage imageNamed:@"player_3_H.png"] forState:UIControlStateNormal];
    [self.player4Button setImage:[UIImage imageNamed:@"player_4_H.png"] forState:UIControlStateNormal];
}

- (IBAction)player3ButtonTUI:(id)sender {
    players = 3;
    [self.player1Button setImage:[UIImage imageNamed:@"player_1_H.png"] forState:UIControlStateNormal];
    [self.player2Button setImage:[UIImage imageNamed:@"player_2_H.png"] forState:UIControlStateNormal];
    [self.player3Button setImage:[UIImage imageNamed:@"player_3_N.png"] forState:UIControlStateNormal];
    [self.player4Button setImage:[UIImage imageNamed:@"player_4_H.png"] forState:UIControlStateNormal];
}

- (IBAction)player4ButtonTUI:(id)sender {
    players = 4;
    [self.player1Button setImage:[UIImage imageNamed:@"player_1_H.png"] forState:UIControlStateNormal];
    [self.player2Button setImage:[UIImage imageNamed:@"player_2_H.png"] forState:UIControlStateNormal];
    [self.player3Button setImage:[UIImage imageNamed:@"player_3_H.png"] forState:UIControlStateNormal];
    [self.player4Button setImage:[UIImage imageNamed:@"player_4_N.png"] forState:UIControlStateNormal];
}

- (IBAction)sec15ButtonTUI:(id)sender {
    duration = 15;
    [self.sec15Button setImage:[UIImage imageNamed:@"15_sec_N.png"] forState:UIControlStateNormal];
    [self.sec30Button setImage:[UIImage imageNamed:@"30_sec_H.png"] forState:UIControlStateNormal];
    [self.sec45Button setImage:[UIImage imageNamed:@"45_sec_H.png"] forState:UIControlStateNormal];
    [self.sec60Button setImage:[UIImage imageNamed:@"60_sec_H.png"] forState:UIControlStateNormal];
}

- (IBAction)sec30ButtonTUI:(id)sender {
    duration = 30;
    [self.sec15Button setImage:[UIImage imageNamed:@"15_sec_H.png"] forState:UIControlStateNormal];
    [self.sec30Button setImage:[UIImage imageNamed:@"30_sec_N.png"] forState:UIControlStateNormal];
    [self.sec45Button setImage:[UIImage imageNamed:@"45_sec_H.png"] forState:UIControlStateNormal];
    [self.sec60Button setImage:[UIImage imageNamed:@"60_sec_H.png"] forState:UIControlStateNormal];
}

- (IBAction)sec45ButtonTUI:(id)sender {
    duration = 45;
    [self.sec15Button setImage:[UIImage imageNamed:@"15_sec_H.png"] forState:UIControlStateNormal];
    [self.sec30Button setImage:[UIImage imageNamed:@"30_sec_H.png"] forState:UIControlStateNormal];
    [self.sec45Button setImage:[UIImage imageNamed:@"45_sec_N.png"] forState:UIControlStateNormal];
    [self.sec60Button setImage:[UIImage imageNamed:@"60_sec_H.png"] forState:UIControlStateNormal];
}

- (IBAction)sec60ButtonTUI:(id)sender {
    duration = 60;
    [self.sec15Button setImage:[UIImage imageNamed:@"15_sec_H.png"] forState:UIControlStateNormal];
    [self.sec30Button setImage:[UIImage imageNamed:@"30_sec_H.png"] forState:UIControlStateNormal];
    [self.sec45Button setImage:[UIImage imageNamed:@"45_sec_H.png"] forState:UIControlStateNormal];
    [self.sec60Button setImage:[UIImage imageNamed:@"60_sec_N.png"] forState:UIControlStateNormal];
}

- (IBAction)continueButtonTUI:(id)sender {
    if([self.playerNameTextField.text isEqualToString:@""]) {
        [self showErrorMessage:@"Sorry" :@"Invalid Player name, Please input the name!"];
        return;
    }
    
    [playerList addObject:self.playerNameTextField.text];
    [self stopPlayerSetting];
    if(playerIndex < players) {
        playerIndex++;
        [self startPlayerSetting];
    } else if(playerIndex == players) {
        //Next Page
        [self addPlayer];
        currentPlayerIndex = 0;
        durationSec = duration;
        HistoryViewController *history = [[HistoryViewController alloc] initWithNibName:(rect.size.height < 568) ? @"HistoryViewController_4s" : @"HistoryViewController" bundle:nil show:NO];
        [self.navigationController pushViewController:history animated:YES];
    }
}

- (void)addPlayer {
    [DELEGATE initPlayerList];
    for(int i = 0; i < playerList.count; i++) {
        NSString *name = (NSString *)[playerList objectAtIndex:i];
        [DELEGATE addPlayerStatusObject:[Player createPlayer:name :i]];
    }
}

- (IBAction)cancelButtonTUI:(id)sender {
    playerIndex = 1;
    [playerList removeAllObjects];
    playerList = [NSMutableArray array];
    
    [self stopPlayerSetting];
}

- (IBAction)workoutButtonTUI:(id)sender {
    playerIndex = 1;
    [playerList removeAllObjects];
    playerList = [NSMutableArray array];
    [self startPlayerSetting];
}

- (IBAction)historyButtonTui:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"There are no saved games to show.\n\nAny game played successfully till end will automatically get saved and appear here." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)prevButtonTUI:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self continueButtonTUI:nil];
    return YES;
}

- (void)startPlayerSetting {
    [self.maskView setAlpha:0.4];
    [self.playerLabel setText:[NSString stringWithFormat:@"Player %d", playerIndex]];
    [self.playerNameTextField setText:@""];
    [self.playerNameTextField setPlaceholder:[NSString stringWithFormat:@"Player %d", playerIndex]];
    [UIView animateWithDuration:0.4 animations:^{
        [self.nameInputView setFrame:CGRectMake(10, self.nameInputView.frame.size.height, self.nameInputView.frame.size.width, self.nameInputView.frame.size.height)];
    } completion:^(BOOL finished) {
        [self.playerNameTextField becomeFirstResponder];
    }];
}

- (void)stopPlayerSetting {
    [self.playerNameTextField resignFirstResponder];
    [UIView animateWithDuration:0.4 animations:^{
        [self.nameInputView setFrame:CGRectMake(10, 0-self.nameInputView.frame.size.height, self.nameInputView.frame.size.width, self.nameInputView.frame.size.height)];
    } completion:^(BOOL finished) {
        [self.maskView setAlpha:0];
    }];
}

- (void)showErrorMessage:(NSString *)titile :(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:titile message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
}
@end
