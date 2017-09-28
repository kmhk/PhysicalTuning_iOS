//
//  RankingCell.m
//  GetFit
//
//  Created by jin on 1/8/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import "RankingCell.h"
#import "Global.h"

@implementation RankingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        float imageSize = 50;
        float height = 60;
        float width = 320;
        int font = 16;
        
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (height-imageSize)/2, imageSize, imageSize)];
        [self.iconView setBackgroundColor:[UIColor clearColor]];
        [self.iconView setContentMode:UIViewContentModeScaleToFill];
        [self.contentView addSubview:self.iconView];
        
        self.rankingLabel = [[UILabel alloc] initWithFrame:self.iconView.frame];
        [self.rankingLabel setBackgroundColor:[UIColor clearColor]];
        [self.rankingLabel setTextColor:[UIColor blackColor]];
        [self.rankingLabel setTextAlignment:NSTextAlignmentCenter];
        [self.rankingLabel setFont:[UIFont systemFontOfSize:font]];
        [self.contentView addSubview:self.rankingLabel];
        
        self.playerLabel = [[UILabel alloc] initWithFrame:CGRectMake(40+imageSize, (height-imageSize)/2, width - imageSize - 40, imageSize)];
        [self.playerLabel setFont:[UIFont systemFontOfSize:font]];
        [self.playerLabel setTextColor:UIColorFromRGB(COLOR_BAR)];
        [self.contentView addSubview:self.playerLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
