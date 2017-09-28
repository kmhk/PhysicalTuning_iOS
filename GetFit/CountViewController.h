//
//  CountViewController.h
//  GetFit
//
//  Created by jin on 1/7/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Player.h"

@interface CountViewController : UIViewController
{
    int seconds;
    int miliseconds;
    
    NSTimer             *timer;
    
    SystemSoundID beepStart,beepEnd,tick,beepGo,beep00;
    Player *currentPlayer;
}

@property (strong, nonatomic) IBOutlet UIView *timerView;
@property (strong, nonatomic) IBOutlet UIButton *workoutButton;
@property (strong, nonatomic) IBOutlet UILabel *prepareDown;
@property (strong, nonatomic) IBOutlet UILabel *secondLabel;
@property (strong, nonatomic) IBOutlet UILabel *milisecLabel;
@property (strong, nonatomic) IBOutlet UILabel *timerEndLabel;

- (IBAction)backButtonTUI:(id)sender;
- (IBAction)historyButtonTUI:(id)sender;
- (IBAction)workoutButtonTUI:(id)sender;
@end
