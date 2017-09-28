//
//  RatingViewController.m
//  GetFit
//
//  Created by jin on 1/8/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import "RatingViewController.h"
#import "Player.h"
#import "RankingCell.h"
#import "AppDelegate.h"
#import "Appirater.h"
#import <Twitter/Twitter.h>

@interface RatingViewController () <AppiraterDelegate>

@end

@implementation RatingViewController

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
    ranking = 1;
    iconArray = [NSMutableArray arrayWithObjects:@"icon_GoldM.png", @"icon_SilverM.png", @"icon_BronzeM.png", @"icon_None.png", nil];
    
    NSMutableArray *finishArray = [NSMutableArray array];
    NSMutableArray *nonFinishArray = [NSMutableArray array];
    [self setRankingArray:[NSMutableArray array]];
    
    for(Player *p in [DELEGATE playerStatus]) {
        if(p.isFinished)
           [finishArray addObject:p];
        else
           [nonFinishArray addObject:p];
    }
    
    NSMutableArray *fRankingArray = [self confirmFinishRanking:finishArray];
    NSMutableArray *nRankingArray = [self confirmNonFinishRanking:nonFinishArray];
    
    for(Player *p in fRankingArray) {
        [self.rankingArray addObject:p];
    }
    
    for(Player *p in nRankingArray) {
        [self.rankingArray addObject:p];
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [Appirater setAppId:@"577723920"];//here you need to put your App id
    [Appirater setDaysUntilPrompt:1];
    [Appirater setUsesUntilPrompt:10];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:2];
    [Appirater setDebug:YES];
    
    [Appirater appEnteredForeground:YES];
}

- (NSMutableArray *)confirmFinishRanking:(NSMutableArray *)pArray {
    NSMutableArray *array = [NSMutableArray array];
    
    while (pArray.count != 0) {
        int eCounter = 10000;
        Player *temp = [pArray objectAtIndex:0];
        
        for(int i = 0; i < pArray.count; i++){
            Player *p = [pArray objectAtIndex:i];
            if(p.exerciseNumber < eCounter) {
                eCounter = p.exerciseNumber;
                temp = p;
            }
        }
        
        [array addObject:temp];
        [pArray removeObject:temp];
    }
    
    for(int i = 0; i < array.count; i++) {
        Player *p = (Player *)[array objectAtIndex:i];
        
        if(i > 0) {
            Player *prev = (Player *)[array objectAtIndex:(i-1)];
            if(p.exerciseNumber == prev.exerciseNumber) {
                p.playerRannking = prev.playerRannking;
            } else
                p.playerRannking = prev.playerRannking + 1;
        } else {
            p.playerRannking = 1;
        }
        
        ranking = p.playerRannking;
    }
    
    return array;
}

- (NSMutableArray *)confirmNonFinishRanking:(NSMutableArray *)pArray {
    
    NSMutableArray *array = [NSMutableArray array];
    while (pArray.count != 0) {
        int eCounter = 0;
        Player *temp = [pArray objectAtIndex:0];
        
        for(int i = 0; i < pArray.count; i++){
            Player *p = [pArray objectAtIndex:i];
            if(p.successNumber > eCounter) {
                eCounter = p.successNumber;
                temp = p;
            }
        }
        
        [array addObject:temp];
        [pArray removeObject:temp];
    }
    
    for(int i = 0; i < array.count; i++) {
        Player *p = (Player *)[array objectAtIndex:i];
        
        if(i > 0) {
            Player *prev = (Player *)[array objectAtIndex:(i-1)];
            if(p.successNumber == prev.successNumber) {
                if(p.exerciseNumber > prev.exerciseNumber) {
                    p.playerRannking = prev.playerRannking + 1;
                } else if(p.exerciseNumber < prev.exerciseNumber) {
                    p.playerRannking = prev.playerRannking;
                    prev.playerRannking = p.playerRannking + 1;
                    [array insertObject:p atIndex:(i-1)];
                    [array removeObjectAtIndex:i+1];
                } else {
                    p.playerRannking = prev.playerRannking;
                }
            } else {
                p.playerRannking = prev.playerRannking + 1;
            }
            
        } else {
            p.playerRannking = ranking + 1;
        }
    }
    
    return array;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)facebookButtonTUI:(id)sender {
    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:@"Can not post card to facebook at the moment. Please confirm facebook login in setting." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        return;
    }
    
    //NSURL * url = [[NSBundle mainBundle] URLForResource:self.index withExtension:@"gif"];
    UIImage * shareImage = [UIImage imageNamed:@"imageToShare.jpg"];
    
    SLComposeViewController * facebookComposeSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [facebookComposeSheet addImage:shareImage];
    
    NSString* iTunesLink = @"https://itunes.apple.com/us/app/get-fit!-fitness-workout/id577723920?ls=1&mt=8";
    NSString *emailBody = [NSString stringWithFormat:@"I completed a fullbody workout using Physical Tuning! What about you? %@", iTunesLink];
    
    [facebookComposeSheet setInitialText:emailBody];
    
    [facebookComposeSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSString * title = @"Facebook";
        NSString * msg = nil;
        if (result == SLComposeViewControllerResultCancelled) {
            msg = @"Post cancelled!";
        }
        else if (result == SLComposeViewControllerResultDone) {
            msg = @"Posted successfully!";
        }
        else {
            msg = @"";
        }
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self presentViewController:facebookComposeSheet animated:YES completion:nil];
}

- (IBAction)twitterButtonTUI:(id)sender {
    if( NSClassFromString(@"SLComposeViewController") != nil){
        //        [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) //check if Facebook Account is linked
        {
            self.mySLComposerSheet = [[SLComposeViewController alloc] init]; //initiate the Social Controller
            self.mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter]; //Tell him with what social plattform to use it, e.g. facebook or twitter
            [self.mySLComposerSheet setInitialText:@"I completed a fullbody workout using Physical Tuning! What about you? \n https://itunes.apple.com/us/app/get-fit!-fitness-workout/id577723920?ls=1&mt=8"]; //the message you want to post
            [self.mySLComposerSheet addImage:[UIImage imageNamed:@"imageToShare.jpg"]];
            
            [self.mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
                NSString *output;
                
                switch (result) {
                    case TWTweetComposeViewControllerResultCancelled:
                        // The cancel button was tapped.
                        output = @"Tweet cancelled.";
                        break;
                    case TWTweetComposeViewControllerResultDone:
                        // The tweet was sent.
                        output = @"Tweet done.";
                        break;
                    default:
                        break;
                }
                // Dismiss the tweet composition view controller.
                //                [self dismissModalViewControllerAnimated:YES];
                //                [self performSelectorOnMainThread:@selector(continueTwitterAction) withObject:nil waitUntilDone:NO];
            }];
            [self performSelectorOnMainThread:@selector(accessTwitter) withObject:nil waitUntilDone:NO];
        }
        
        
        return;
    }
    
    NSString *URL = [NSString stringWithFormat:@"http://twitter.com/intent/tweet?text=I completed a fullbody workout using Physical Tuning! What about you? \n https://itunes.apple.com/us/app/get-fit!-fitness-workout/id577723920?ls=1&mt=8"];
    
    NSString *fixedURL = [URL stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:fixedURL]];
}

- (void)accessTwitter {
    [self presentViewController:self.mySLComposerSheet animated:YES completion:nil];
}

- (IBAction)completeButtonTUI:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UITableView
- (int)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rankingArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *setCellIdentfier = @"setCellIdentifier";
    
    RankingCell *cell = (RankingCell *)[tableView dequeueReusableCellWithIdentifier:setCellIdentfier];// [[UITableViewCell alloc] init];
    if(nil==cell) {
        cell = [[RankingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:setCellIdentfier];
    }
    
    Player *p = (Player *)[self.rankingArray objectAtIndex:indexPath.row];
    
    [cell.iconView setImage:[UIImage imageNamed:(NSString *)[iconArray objectAtIndex:(p.playerRannking-1)]]];
    [cell.rankingLabel setText:[NSString stringWithFormat:@"%d", p.playerRannking]];
    [cell.playerLabel setText:p.playerName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    VideoCell *cell = (VideoCell *)[tableView cellForRowAtIndexPath:indexPath];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end
