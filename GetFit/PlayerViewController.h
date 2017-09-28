//
//  PlayerViewController.h
//  GetFit
//
//  Created by jin on 1/5/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerViewController : UIViewController <UITextFieldDelegate> {
    int players;
    int duration;
    int playerIndex;
    
    NSMutableArray *playerList;
}

@property (strong, nonatomic) IBOutlet UISegmentedControl *durationSegment;
@property (strong, nonatomic) IBOutlet UIButton *player1Button;
@property (strong, nonatomic) IBOutlet UIButton *player2Button;
@property (strong, nonatomic) IBOutlet UIButton *player3Button;
@property (strong, nonatomic) IBOutlet UIButton *player4Button;

@property (strong, nonatomic) IBOutlet UIButton *sec15Button;
@property (strong, nonatomic) IBOutlet UIButton *sec30Button;
@property (strong, nonatomic) IBOutlet UIButton *sec45Button;
@property (strong, nonatomic) IBOutlet UIButton *sec60Button;


@property (strong, nonatomic) IBOutlet UIView *nameInputView;
@property (strong, nonatomic) IBOutlet UIView *maskView;
@property (strong, nonatomic) IBOutlet UITextField *playerNameTextField;
@property (strong, nonatomic) IBOutlet UILabel *playerLabel;

- (IBAction)player1ButtonTUI:(id)sender;
- (IBAction)player2ButtonTUI:(id)sender;
- (IBAction)player3ButtonTUI:(id)sender;
- (IBAction)player4ButtonTUI:(id)sender;

- (IBAction)sec15ButtonTUI:(id)sender;
- (IBAction)sec30ButtonTUI:(id)sender;
- (IBAction)sec45ButtonTUI:(id)sender;
- (IBAction)sec60ButtonTUI:(id)sender;

- (IBAction)continueButtonTUI:(id)sender;
- (IBAction)cancelButtonTUI:(id)sender;

- (IBAction)workoutButtonTUI:(id)sender;
- (IBAction)historyButtonTui:(id)sender;
- (IBAction)prevButtonTUI:(id)sender;

@end
