//
//  VideoTutorialViewController.m
//  GetFit
//
//  Created by jin on 1/8/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import "VideoTutorialViewController.h"

@interface VideoTutorialViewController ()

@end

@implementation VideoTutorialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil label:(NSString *)title path:(NSString *)vPath
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        titleName = title;
        videoPath = vPath;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.titleLabel setText:titleName];
    
    self.movieController = [[MPMoviePlayerController alloc] init];
    self.movieController.view.frame = self.videoView.bounds;
    self.movieController.view.clipsToBounds = YES;
    [self.movieController setBackgroundColor:[UIColor whiteColor]];
    [self.videoView addSubview:self.movieController.view];
    [self.movieController.view setAlpha:1];
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
    [self.navigationController popViewControllerAnimated:YES];
}
@end
