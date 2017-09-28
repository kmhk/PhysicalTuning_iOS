//
//  HumanmusicViewController.h
//  GetFit
//
//  Created by jin on 1/8/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"

#import "Player.h"

@interface HumanmusicViewController : UIViewController
{
    NSInteger   exID;
    NSInteger   videoId;
    BOOL        forTutorial;
    exerciseType eType;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil tutorial:(BOOL)isTutorial;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) Player    *currentPlayer;
@property (strong, nonatomic) IBOutlet UIButton *workoutButton;
@property (strong, nonatomic) IBOutlet UIButton *historyButton;

- (IBAction)redButtonTUI:(id)sender;
- (IBAction)greenButtonTUI:(id)sender;
- (IBAction)blueButtonTUI:(id)sender;
- (IBAction)orangButtonTUI:(id)sender;
- (IBAction)yellowButtonTUI:(id)sender;
- (IBAction)historyButtonTUI:(id)sender;
- (IBAction)workoutButtonTUI:(id)sender;
- (IBAction)backButtonTUI:(id)sender;

@end
