//
//  VideoCell.m
//  GetFit
//
//  Created by jin on 1/8/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import "VideoCell.h"
#import "Global.h"

@implementation VideoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        float imageSize = 50;
        float height = 60;
        float width = 320;
        int font = 16;
        
        self.mvImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (height-imageSize)/2, imageSize, imageSize)];
        [self.mvImageView setBackgroundColor:[UIColor clearColor]];
        [self.mvImageView setContentMode:UIViewContentModeScaleToFill];
        [self.contentView addSubview:self.mvImageView];
        
        self.videoLabel = [[UILabel alloc] initWithFrame:CGRectMake(40+imageSize, (height-imageSize)/2, width - imageSize - 40, imageSize)];
        [self.videoLabel setFont:[UIFont systemFontOfSize:font]];
        [self.videoLabel setTextColor:UIColorFromRGB(COLOR_BAR)];
        [self.contentView addSubview:self.videoLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
