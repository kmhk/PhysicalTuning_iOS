//
//  SMRotaryProtocol.h
//  GetFit
//
//  Created by jin on 1/6/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMRotaryProtocol <NSObject>

- (void) wheelDidChangeValue:(NSString *)newValue;
- (void) setVideoID:(NSInteger)exId :(NSInteger)extype;
- (void) showConfirmMessage;
- (void) showChoiceMessage;

@end
