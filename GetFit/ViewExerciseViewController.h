//
//  ViewExerciseViewController.h
//  GetFit
//
//  Created by jin on 1/7/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

#import "Player.h"

@interface ViewExerciseViewController : UIViewController
{
    NSMutableArray *allNameArray;
}

@property (strong, nonatomic) NSMutableArray    *diceColorFaces;

@property (strong, nonatomic) IBOutlet UIView *videoView;

@property (strong, nonatomic) MPMoviePlayerController   *movieController;
@property (strong, nonatomic) Player                    *currentPlayer;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *failButton;
@property (strong, nonatomic) IBOutlet UIButton *goodButton;
@property (strong, nonatomic) IBOutlet UIView *failView;

- (IBAction)backButtonTUI:(id)sender;
- (IBAction)failButtonTUI:(id)sender;
- (IBAction)goodButtonTUI:(id)sender;
- (IBAction)historyButtonTUI:(id)sender;
@end
