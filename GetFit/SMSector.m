//
//  SMSector.m
//  GetFit
//
//  Created by jin on 1/6/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import "SMSector.h"

@implementation SMSector

@synthesize minValue, maxValue, midValue, sector;

- (NSString *) description {
    return [NSString stringWithFormat:@"%i | %f, %f, %f", self.sector, self.minValue, self.midValue, self.maxValue];
}

@end
