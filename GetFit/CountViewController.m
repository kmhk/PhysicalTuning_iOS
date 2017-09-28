//
//  CountViewController.m
//  GetFit
//
//  Created by jin on 1/7/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import "CountViewController.h"
#import "Global.h"
#import "AppDelegate.h"

@interface CountViewController () <UIAlertViewDelegate>

@end

@implementation CountViewController

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
    [self.workoutButton setUserInteractionEnabled:NO];
    currentPlayer = (Player *)[[DELEGATE playerStatus] objectAtIndex:currentPlayerIndex];

    seconds = durationSec + 4;
//    seconds = 0;
    miliseconds = 60 * seconds+30;
    
    [self.prepareDown setText:@"3"];
    [self.timerView setAlpha:0];
    [self.timerEndLabel setAlpha:0];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tick" ofType:@"mp3"]], &tick);
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"beepStart" ofType:@"mp3"]], &beepStart);
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"beepEnd" ofType:@"mp3"]], &beepEnd);
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"beepGo" ofType:@"mp3"]], &beepGo);
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"beep00" ofType:@"mp3"]], &beep00);
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.0166
                                             target:self
                                           selector:@selector(countTimer)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [timer invalidate];
    timer = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)countTimer {
    miliseconds--;
    int min = miliseconds / 60;
    int sec = miliseconds % 60;
    if( (min - durationSec) > 0 ){
        [self.timerView setAlpha:0];
        [self.prepareDown setAlpha:1];
        
        [self.prepareDown setText:[NSString stringWithFormat:@"%d", (min-durationSec)]];
        if(sec == 59) AudioServicesPlaySystemSound(beepStart);
    } else if((min-durationSec) == 0) {
        [self.timerView setAlpha:0];
        [self.prepareDown setAlpha:1];
        
        [self.prepareDown setText:@"GO"];
        if(sec == 59) AudioServicesPlaySystemSound(beepGo);
    } else {
        [self.timerView setAlpha:1];
        [self.prepareDown setAlpha:0];
        
        if(min < 10)
           [self.secondLabel setText:[NSString stringWithFormat:@"0%d", min]];
        else
           [self.secondLabel setText:[NSString stringWithFormat:@"%d", min]];
        
        if(sec < 10)
            [self.milisecLabel setText:[NSString stringWithFormat:@"0%d", sec]];
        else
            [self.milisecLabel setText:[NSString stringWithFormat:@"%d", sec]];
        if(sec == 59) {
            if(min < 5)
                AudioServicesPlaySystemSound(tick);
            else
                AudioServicesPlaySystemSound(tick);
        }
    }
    
    if(miliseconds == 0) {
        [timer invalidate];
        timer = nil;
        AudioServicesPlaySystemSound(beep00);
        [self.timerEndLabel setAlpha:1];
        isExercised = YES;
        [self.workoutButton setUserInteractionEnabled:YES];
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

- (IBAction)historyButtonTUI:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"It is %@'s turn.", currentPlayer.playerName] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)workoutButtonTUI:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
