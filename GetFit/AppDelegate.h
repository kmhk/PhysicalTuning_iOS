//
//  AppDelegate.h
//  GetFit
//
//  Created by jin on 1/5/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "Player.h"

#define DELEGATE (AppDelegate *)[[UIApplication sharedApplication]delegate]

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navController;
@property (nonatomic, strong) RootViewController     *rootController;
@property (nonatomic, strong) NSMutableArray         *playerStatus;
@property (nonatomic, strong) NSMutableArray         *videoArray;

- (void)initPlayerList;

- (void)addPlayerStatusObject:(Player *)object;
- (void)removePlayerStatusObject:(Player *)object;

- (void) buyInAppPurchase;

@end
