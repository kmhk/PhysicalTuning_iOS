//
//  VideoTutorialViewController.h
//  GetFit
//
//  Created by jin on 1/8/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface VideoTutorialViewController : UIViewController
{
    NSString        *titleName;
    NSString        *videoPath;
}

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIView *videoView;
@property (strong, nonatomic) MPMoviePlayerController   *movieController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil label:(NSString *)title path:(NSString *)vPath;
- (IBAction)backButtonTUI:(id)sender;
@end
