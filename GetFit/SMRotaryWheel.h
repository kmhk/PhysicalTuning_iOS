//
//  SMRotaryWheel.h
//  GetFit
//
//  Created by jin on 1/6/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SMSector.h"
#import "SMRotaryProtocol.h"

@interface SMRotaryWheel : UIControl

@property (nonatomic, assign) id <SMRotaryProtocol> delegate;
@property (nonatomic, strong) UIView *container;
@property int numberOfSections;

@property CGAffineTransform startTransform;

@property (nonatomic, strong) NSMutableArray *sectors;
@property int currentSector;
@property (nonatomic, strong) NSTimer        *timer;
@property float radianVal;
@property (nonatomic, assign) BOOL           *isStarted;
@property (nonatomic, strong) UILabel        *exTypeLabel;

- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber;
- (void)rotate;
- (void)startTimer;
- (void)stopTimer;

@end
