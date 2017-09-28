//
//  RoundView.m
//  GetFit
//
//  Created by jin on 1/6/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import "RoundView.h"
#import <QuartzCore/QuartzCore.h>

@implementation RoundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.exImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 52, 70)];
        self.exImage.layer.cornerRadius = 10;
        self.exImage.clipsToBounds = YES;
        [self addSubview:self.exImage];
        
        self.exName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 52, 70)];
        [self.exName setTextAlignment:NSTextAlignmentCenter];
        [self.exName setTextColor:[UIColor blackColor]];
        [self.exName setFont:[UIFont systemFontOfSize:12]];
        [self.exName setLineBreakMode:NSLineBreakByWordWrapping];
        self.exName.numberOfLines = 5;
        [self addSubview:self.exName];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
