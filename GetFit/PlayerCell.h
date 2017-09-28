//
//  PlayerCell.h
//  GetFit
//
//  Created by jin on 1/6/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import "RoundView.h"
#import <UIKit/UIKit.h>

@interface PlayerCell : UITableViewCell

@property (nonatomic, strong) RoundView         *playerView;
@property (nonatomic, strong) UIImageView       *redImage;
@property (nonatomic, strong) UIImageView       *yellowImage;
@property (nonatomic, strong) UIImageView       *greenImage;
@property (nonatomic, strong) UIImageView       *blueImage;
@property (nonatomic, strong) UIImageView       *orangeImage;

@property (nonatomic, strong) NSMutableArray    *imageArray;

@end
