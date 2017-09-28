//
//  SMRotaryWheel.m
//  GetFit
//
//  Created by jin on 1/6/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#import "SMRotaryWheel.h"
#import <QuartzCore/QuartzCore.h>

@interface SMRotaryWheel()

- (void)drawWheel;
- (float) calculateDistanceFromCenter:(CGPoint)point;
- (void) buildSectorsEven;
- (void) buildSectorsOdd;
- (UIImageView *) getSectorByValue:(int)value;

@end

static float deltaAngle;
static float minAlphavalue = 0.6;
static float maxAlphavalue = 1.0;

@implementation SMRotaryWheel

@synthesize delegate, container, numberOfSections;
@synthesize startTransform;
@synthesize sectors;
@synthesize currentSector;

- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber {
    // 1 - Call super init
    if ((self = [super initWithFrame:frame])) {
        // 2 - Set properties
        self.numberOfSections = sectionsNumber;
        self.delegate = del;
        // 3 - Draw wheel
        [self drawWheel];
        self.currentSector = 0;
        self.radianVal = 0.5;
        self.isStarted = NO;
	}
    return self;
}

- (void) drawWheel {
    // 1
    container = [[UIView alloc] initWithFrame:self.frame];
    // 2
    CGFloat angleSize = 2*M_PI/numberOfSections;
    // 3 - Create the sectors
    NSMutableArray *colorArray = [NSMutableArray arrayWithObjects:@"segment_white.png", @"segment_red.png",@"segment_yellow.png",@"segment_blue.png",@"segment_green.png",@"segment_orange.png", nil];
	for (int i = 0; i < numberOfSections; i++) {
        // 4 - Create image view
        UIImageView *im = [[UIImageView alloc] initWithImage:[UIImage imageNamed:(NSString *)[colorArray objectAtIndex:i]]];
        im.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
        im.layer.position = CGPointMake(container.bounds.size.width/2.0-container.frame.origin.x,
                                        container.bounds.size.height/2.0-container.frame.origin.y);
        im.transform = CGAffineTransformMakeRotation(angleSize*i);
        im.alpha = minAlphavalue;
        im.tag = i;
//        if (i == 0) {
        im.alpha = maxAlphavalue;
//        }
        
//		// 5 - Set sector image
//        UIImageView *sectorImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 15, 40, 40)];
//        sectorImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon%i.png", i]];
//        [im addSubview:sectorImage];
        // 6 - Add image view to container
        [container addSubview:im];
	}
    
    // 7
    container.userInteractionEnabled = NO;
    [self addSubview:container];
    
    // 7.1 - Add background image
	UIImageView *bg = [[UIImageView alloc] initWithFrame:self.frame];
	bg.image = [UIImage imageNamed:@"bg.png"];
	[self addSubview:bg];
    
    UIImageView *mask = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 58, 58)];
    mask.image =[UIImage imageNamed:@"centerButton.png"] ;
    mask.center = self.center;
    mask.center = CGPointMake(mask.center.x, mask.center.y+3);
    [self addSubview:mask];
    
    self.exTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 58, 58)];
    [self.exTypeLabel setBackgroundColor:[UIColor clearColor]];
    self.exTypeLabel.center = self.center;
    self.exTypeLabel.center = CGPointMake(mask.center.x, mask.center.y);
    [self.exTypeLabel setText:@"1"];
    [self.exTypeLabel setFont:[UIFont systemFontOfSize:20]];
    [self.exTypeLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.exTypeLabel];
    
    // 8 - Initialize sectors
    sectors = [NSMutableArray arrayWithCapacity:numberOfSections];
    if (numberOfSections % 2 == 0) {
        [self buildSectorsEven];
    } else {
        [self buildSectorsOdd];
    }
    // 9 - Call protocol method
    [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"value is %i", self.currentSector]];
}

- (void) rotate {

    CGAffineTransform t = CGAffineTransformRotate(container.transform, -0.5);
    container.transform = t;

    [self.exTypeLabel setText:[NSString stringWithFormat:@"%i", (arc4random()%5)+1]];
}

- (void)startTimer {
    self.isStarted = YES;
    self.radianVal = 0.5;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                                  target:self
                                                selector:@selector(rotate)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)stopTimer {
    self.isStarted = NO;
    
    [self.timer invalidate];
    self.timer = nil;
     
     [UIView animateWithDuration:1.0 animations:^{
             CGAffineTransform t = CGAffineTransformRotate(container.transform, -0.5);
             container.transform = t;
     } completion:^(BOOL finished) {
         [self confirmExercise];
     }];
}

- (void)confirmExercise {
    
    // 1 - Get current container rotation in radians
    CGFloat radians = atan2f(container.transform.b, container.transform.a);
    // 2 - Initialize new value
    CGFloat newVal = 0.0;
    // 3 - Iterate through all the sectors
    for (SMSector *s in sectors) {
        if (s.minValue > 0 && s.maxValue < 0) {
            if (s.maxValue > radians || s.minValue < radians) {
                // 5 - Find the quadrant (positive or negative)
                if (radians > 0) {
                    newVal = radians - M_PI;
                } else {
                    newVal = M_PI + radians;
                }
                currentSector = s.sector;
            }
        }
        // 6 - All non-anomalous cases
        else if (radians > s.minValue && radians < s.maxValue) {
            newVal = radians - s.midValue;
            currentSector = s.sector;
        }
    }
    
    
    // 7 - Set up animation for final rotation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    CGAffineTransform t = CGAffineTransformRotate(container.transform, -newVal-M_PI/6);
    container.transform = t;
    [UIView commitAnimations];
    
    // 9 - Call protocol method
    int index = (self.currentSector < 4) ? (2+self.currentSector) : (self.currentSector-4);
    [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"value is %i %i", self.currentSector, index]];
    
    // 10 - Highlight selected sector
	UIImageView *im = [self getSectorByValue:currentSector];
	im.alpha = maxAlphavalue;
    
    [self.delegate setVideoID:index :self.exTypeLabel.text.integerValue];
    if(index == 0) {
        [self.delegate showChoiceMessage];
    } else {
        [self.delegate showConfirmMessage];
    }
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    // 1 - Get touch position
    CGPoint touchPoint = [touch locationInView:self];
    
    // 1.1 - Get the distance from the center
    float dist = [self calculateDistanceFromCenter:touchPoint];
    // 1.2 - Filter out touches too close to the center
    if (dist < 40 || dist > 100)
    {
        // forcing a tap to be on the ferrule
        NSLog(@"ignoring tap (%f,%f)", touchPoint.x, touchPoint.y);
        return NO;
    }
    
    // 2 - Calculate distance from center
    float dx = touchPoint.x - container.center.x;
    float dy = touchPoint.y - container.center.y;
    // 3 - Calculate arctangent value
    deltaAngle = atan2(dy,dx);
    // 4 - Save current transform
    startTransform = container.transform;
    
    // 5 - Set current sector's alpha value to the minimum value
	UIImageView *im = [self getSectorByValue:currentSector];
	im.alpha = minAlphavalue;
    return YES;
}

- (void)endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    [self.timer invalidate];
    self.timer = nil;
    
    // 1 - Get current container rotation in radians
    CGFloat radians = atan2f(container.transform.b, container.transform.a);
    // 2 - Initialize new value
    CGFloat newVal = 0.0;
    // 3 - Iterate through all the sectors
    for (SMSector *s in sectors) {
//        // 4 - See if the current sector contains the radian value
//        if (radians > s.minValue && radians < s.maxValue) {
//            // 5 - Set new value
//            newVal = radians - s.midValue;
//            // 6 - Get sector number
//            currentSector = s.sector;
//			break;
//        }
        // 4 - Check for anomaly (occurs with even number of sectors)
        if (s.minValue > 0 && s.maxValue < 0) {
            if (s.maxValue > radians || s.minValue < radians) {
                // 5 - Find the quadrant (positive or negative)
                if (radians > 0) {
                    newVal = radians - M_PI;
                } else {
                    newVal = M_PI + radians;
                }
                currentSector = s.sector;
            }
        }
        // 6 - All non-anomalous cases
        else if (radians > s.minValue && radians < s.maxValue) {
            newVal = radians - s.midValue;
            currentSector = s.sector;
        }
    }

    
    // 7 - Set up animation for final rotation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    CGAffineTransform t = CGAffineTransformRotate(container.transform, -newVal);
    container.transform = t;
    [UIView commitAnimations];
    
    // 9 - Call protocol method
    [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"value is %i", self.currentSector]];
    
    // 10 - Highlight selected sector
	UIImageView *im = [self getSectorByValue:currentSector];
	im.alpha = maxAlphavalue;
}

- (BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    CGFloat radians = atan2f(container.transform.b, container.transform.a);
    NSLog(@"rad is %f", radians);
    
    CGPoint pt = [touch locationInView:self];
    float dx = pt.x  - container.center.x;
    float dy = pt.y  - container.center.y;
    float ang = atan2(dy,dx);
    float angleDifference = deltaAngle - ang;
    container.transform = CGAffineTransformRotate(startTransform, -angleDifference);
    return YES;
}

- (float) calculateDistanceFromCenter:(CGPoint)point {
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    float dx = point.x - center.x;
    float dy = point.y - center.y;
    return sqrt(dx*dx + dy*dy);
}

- (void) buildSectorsOdd {
	// 1 - Define sector length
    CGFloat fanWidth = M_PI*2/numberOfSections;
	// 2 - Set initial midpoint
    CGFloat mid = 0;
	// 3 - Iterate through all sectors
    for (int i = 0; i < numberOfSections; i++) {
        SMSector *sector = [[SMSector alloc] init];
		// 4 - Set sector values
        sector.midValue = mid;
        sector.minValue = mid - (fanWidth/2);
        sector.maxValue = mid + (fanWidth/2);
        sector.sector = i;
        mid -= fanWidth;
        if (sector.minValue < - M_PI) {
            mid = -mid;
            mid -= fanWidth;
        }
		// 5 - Add sector to array
        [sectors addObject:sector];
		NSLog(@"cl is %@", sector);
    }
}

- (void) buildSectorsEven {
    // 1 - Define sector length
    CGFloat fanWidth = M_PI*2/numberOfSections;
    // 2 - Set initial midpoint
    CGFloat mid = 0;
    // 3 - Iterate through all sectors
    for (int i = 0; i < numberOfSections; i++) {
        SMSector *sector = [[SMSector alloc] init];
        // 4 - Set sector values
        sector.midValue = mid;
        sector.minValue = mid - (fanWidth/2);
        sector.maxValue = mid + (fanWidth/2);
        sector.sector = i;
        if (sector.maxValue-fanWidth < - M_PI) {
            mid = M_PI;
            sector.midValue = mid;
            sector.minValue = fabsf(sector.maxValue);
            
        }
        mid -= fanWidth;
        NSLog(@"cl is %@", sector);
        // 5 - Add sector to array
        [sectors addObject:sector];
    }
}

- (UIImageView *) getSectorByValue:(int)value {
    UIImageView *res;
    NSArray *views = [container subviews];
    for (UIImageView *im in views) {
        if (im.tag == value)
            res = im;
    }
    return res;
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
