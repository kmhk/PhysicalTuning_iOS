//
//  AppDelegate.m
//  GetFit
//
//  Created by jin on 1/5/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "Global.h"
#import "Flurry.h"
#import "MKStoreManager.h"

#import <RevMobAds/RevMobAds.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self setRootController:[[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil]];
    [self.window setRootViewController:self.rootController];
    
    [self.window makeKeyAndVisible];
    
    rect = [[UIScreen mainScreen] bounds];
    
    MainViewController *mainViewController = [[MainViewController alloc] initWithNibName:(rect.size.height < 568) ? @"MainViewController_4s" : @"MainViewController" bundle:nil];
    self.navController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    [self.navController setNavigationBarHidden:YES];
    [self.rootController presentViewController:self.navController animated:YES completion:nil];
    
    [MKStoreManager sharedManager];
    [RevMobAds startSessionWithAppID:@"52c5cad72ea34344610000ee"];
    
    [Flurry setCrashReportingEnabled:YES];
    [Flurry setEventLoggingEnabled:YES];
    [Flurry logPageView];
    
    //note: iOS only allows one crash reporting tool per app; if using another, set to: NO
    [Flurry startSession:@"YGZG22WG8Z6NTNCZCC5C"];
    [Flurry  setSessionReportsOnPauseEnabled:YES];
    
    isExercised = NO;
    isTuning = NO;
    self.videoArray = [NSMutableArray arrayWithObjects: @"Red_Burpees",
     @"Red_Mountain_climbers",
     @"Red_Combined_burpees",
     @"Red_Sprinting",
     @"Red_Starjumps",
     @"Yellow_PushUps_Regular",
     @"Yellow_PushUps_Staggered",
     @"Yellow_PushUps_Hindu",
     @"Yellow_PushUps_Small",
     @"Yellow_PushUps_Spiderman",
     @"Blue_ReverseCrunch",
     @"Blue_V_Snaps",
     @"Blue_Cycling",
     @"Blue_SitUps_Regular",
     @"Blue_Penguin",
     @"Green_Lunges",
     @"Green_Lunges_jumps",
     @"Green_Squat_jumps",
     @"Green_Skating",
     @"Green_Prison_squats",
     @"Orange_Hip_raises",
     @"Orange_Planking_regular",
     @"Orange_Planking_superman",
     @"Orange_Para_regular",
     @"Orange_Planking_expert", nil];
    
//    [self testFunc];
    
    return YES;
}

- (void) buyInAppPurchase {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kPurchaseEffect];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)testFunc {
    [self initPlayerList];
    Player *p1 = [Player createPlayer:@"Player1" :0];
    p1.isFinished = NO;
    p1.exerciseNumber = 10;
    p1.successNumber = 6;
    [self.playerStatus addObject:p1];
    
    Player *p2 = [Player createPlayer:@"Player2" :0];
    p2.isFinished = YES;
    p2.exerciseNumber = 9;
    p2.successNumber = 6;
    [self.playerStatus addObject:p2];
    
    Player *p3 = [Player createPlayer:@"Player3" :0];
    p3.isFinished = YES;
    p3.exerciseNumber = 10;
    p3.successNumber = 6;
    [self.playerStatus addObject:p3];
    
    Player *p4 = [Player createPlayer:@"Player4" :0];
    p4.isFinished = YES;
    p4.exerciseNumber = 4;
    p4.successNumber = 6;
    [self.playerStatus addObject:p4];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)initPlayerList {
    self.playerStatus = [NSMutableArray array];
}

- (void)addPlayerStatusObject:(Player *)object {
    [self.playerStatus addObject:object];
}

@end
