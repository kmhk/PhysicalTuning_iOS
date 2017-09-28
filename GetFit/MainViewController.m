//
//  MainViewController.m
//  GetFit
//
//  Created by jin on 1/5/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import "MainViewController.h"
#import "PlayerViewController.h"
#import "HumanmusicViewController.h"
#import "RatingViewController.h"
#import "Appirater.h"
#import "Global.h"
#import "AppDelegate.h"
#import "MKStoreManager.h"

#import <RevMobAds/RevMobAds.h>

@interface MainViewController () <UIAlertViewDelegate, AppiraterDelegate, MainViewContrllerDelegate>

@end

@implementation MainViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)workoutButtonTUI:(id)sender {
//    RatingViewController *rankingView = [[RatingViewController alloc] initWithNibName:@"RatingViewController" bundle:nil];
//    [self.navigationController pushViewController:rankingView animated:YES];
    
    PlayerViewController *selectPlayerViewController = [[PlayerViewController alloc] initWithNibName:(rect.size.height < 568) ? @"PlayerViewController_4s" : @"PlayerViewController" bundle:nil];
    [self.navigationController pushViewController:selectPlayerViewController animated:YES];
}

- (IBAction)videoButtonTUI:(id)sender {
    HumanmusicViewController *humanView = [[HumanmusicViewController alloc] initWithNibName:(rect.size.height < 568) ? @"HumanmusicViewController_4s" : @"HumanmusicViewController" bundle:nil tutorial:YES];
    [self.navigationController pushViewController:humanView animated:YES];
}

- (void) showInAppPurchase {
    UIAlertView *alertPurchase;
    alertPurchase = [[UIAlertView alloc]
                      initWithTitle:                      @"Unlimited video access"
                      message:[NSString stringWithFormat: @"Get access to all video material used in this app. Make your own workout!\nor To unlock all features, you can download our PRO version in the AppStore."]
                      delegate:self cancelButtonTitle:    @"Cancel"
                      otherButtonTitles:                  @"Get it all for just $0.99", @"Restore", @"Get PRO version",  nil];
    
    [alertPurchase show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:     //Cancel
            break;
        case 1:     //Purchase
            [MKStoreManager sharedManager].delegate = self;
            [[MKStoreManager sharedManager] buyFeature0];
            break;
        case 2:     //Restore
            [MKStoreManager sharedManager].delegate = self;
            [[MKStoreManager sharedManager] buyFeature0];
            break;
        case 3: // get Pro version
            
            break;
        default:
            break;
    }
}

- (void)releaseIAP {
    isPurchase = YES;
    [DELEGATE buyInAppPurchase];
}
@end
