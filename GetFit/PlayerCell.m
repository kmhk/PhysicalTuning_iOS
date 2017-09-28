//
//  PlayerCell.m
//  GetFit
//
//  Created by jin on 1/6/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import "PlayerCell.h"

@implementation PlayerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        float margin = 4;
        float width = 52;
        float height = 70;
        float cupSize = 52;
        float cupY = margin+(height-cupSize)/2;
        float cupXmargin = (width-cupSize)/2;
        
        self.playerView = [[RoundView alloc] initWithFrame:CGRectMake(0, margin, width, height)];
        [self.playerView.exImage setImage:[UIImage imageNamed:@"nameBox.png"]];
        [self.contentView addSubview:self.playerView];
        
        self.imageArray = [NSMutableArray array];
        
        self.redImage = [[UIImageView alloc] initWithFrame:CGRectMake(width+cupXmargin, cupY, cupSize, cupSize)];
        [self.contentView addSubview:self.redImage];
        [self.imageArray addObject:self.redImage];
        
        self.yellowImage = [[UIImageView alloc] initWithFrame:CGRectMake(width*2+cupXmargin, cupY, cupSize, cupSize)];
        [self.contentView addSubview:self.yellowImage];
        [self.imageArray addObject:self.yellowImage];
        
        self.blueImage = [[UIImageView alloc] initWithFrame:CGRectMake(width*3+cupXmargin, cupY, cupSize, cupSize)];
        [self.contentView addSubview:self.blueImage];
        [self.imageArray addObject:self.blueImage];
        
        self.greenImage = [[UIImageView alloc] initWithFrame:CGRectMake(width*4+cupXmargin, cupY, cupSize, cupSize)];
        [self.contentView addSubview:self.greenImage];
        [self.imageArray addObject:self.greenImage];
        
        self.orangeImage = [[UIImageView alloc] initWithFrame:CGRectMake(width*5+cupXmargin, cupY, cupSize, cupSize)];
        [self.contentView addSubview:self.orangeImage];
        [self.imageArray addObject:self.orangeImage];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
