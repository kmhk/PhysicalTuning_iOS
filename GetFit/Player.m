//
//  Player.m
//  GetFit
//
//  Created by jin on 1/6/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import "Player.h"
#import "Exercise.h"

@implementation Player

+ (id)createPlayer:(NSString *)name :(NSInteger)index {
    return [[Player alloc] initWithName:name : index];
}

- (Player *)initWithName:(NSString *)name :(NSInteger)index {
    self = [super init];
    self.playerName = name;
    self.playerId = index;
    self.currentVideoId = 0;
    self.exStatus = [NSMutableArray array];
    self.isFinished = NO;
    self.exerciseNumber = 0;
    self.playerRannking = 0;
    self.successNumber = 0;
    
    for (int i = 0; i < 5; i++) {
        [self.exStatus addObject:[[Exercise alloc] init]];
    }
    return self;
}

@end
