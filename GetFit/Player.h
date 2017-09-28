//
//  Player.h
//  GetFit
//
//  Created by jin on 1/6/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface Player : NSObject

@property (nonatomic, assign) NSInteger         playerId;
@property (nonatomic, assign) NSInteger         exerciseNumber;
@property (nonatomic, assign) NSInteger         successNumber;
@property (nonatomic, assign) BOOL              isFinished;
@property (nonatomic, assign) NSInteger         currentVideoId;
@property (nonatomic, assign) NSInteger         exerciseId;
@property (nonatomic, assign) NSInteger         exerciseType;
@property (nonatomic, strong) NSString          *playerName;
@property (nonatomic, strong) NSMutableArray    *exStatus;
@property (nonatomic, assign) NSInteger         playerRannking;

+ (id)createPlayer:(NSString *)name :(NSInteger)index;
- (Player *)initWithName:(NSString *)name :(NSInteger)index;

@end
