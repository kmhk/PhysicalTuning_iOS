//
//  SpinningViewController.h
//  GetFit
//
//  Created by jin on 1/6/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SMRotaryProtocol.h"
#import "Global.h"
#import "Player.h"

@class SMRotaryWheel;

@interface SpinningViewController : UIViewController<SMRotaryProtocol, UIAlertViewDelegate>
{
    BOOL    isStarted;
}
@property (nonatomic, strong) UILabel *sectorLabel;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) SMRotaryWheel *wheel;
@property (strong, nonatomic) Player    *currentPlayer;
@property int videoID;

- (IBAction)backButtonTUI:(id)sender;
- (IBAction)startButtonTUI:(id)sender;
- (IBAction)historyButtonTUI:(id)sender;
@end