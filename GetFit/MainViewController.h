//
//  MainViewController.h
//  GetFit
//
//  Created by jin on 1/5/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainViewContrllerDelegate <NSObject>

- (void) releaseIAP;

@end

@interface MainViewController : UIViewController
{
    BOOL isPurchase;
}
@property (nonatomic, strong) UINavigationController *navController;

- (IBAction)workoutButtonTUI:(id)sender;
- (IBAction)videoButtonTUI:(id)sender;

@end
