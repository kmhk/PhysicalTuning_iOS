//
//  VideoCell.h
//  GetFit
//
//  Created by jin on 1/8/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCell : UITableViewCell

@property (nonatomic, strong) UIImageView       *mvImageView;
@property (nonatomic, strong) UILabel           *videoLabel;
@property (nonatomic, strong) NSString          *videoName;
@property (nonatomic, strong) NSString          *videoPath;

@end
