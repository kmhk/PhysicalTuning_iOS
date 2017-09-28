//
//  Global.h
//  GetFit
//
//  Created by jin on 1/6/14.
//  Copyright (c) 2014 jin. All rights reserved.
//

#ifndef GetFit_Global_h
#define GetFit_Global_h

typedef enum _exerciseType {
    FAT_BURNER      = 0,
    UPPER_BODY      = 1,
    BELLY           = 2,
    LEGS            = 3,
    CORE            = 4,
    ALL             = 5
} exerciseType;

typedef enum _exerciseStatus {
    NON_EXERCISE    = 0,
    EITHER_EXERCISE  = 1,
    BOTH_EXERCISE   = 2
} exerciseStatus;

int currentPlayerIndex;
int durationSec;
BOOL isExercised;
BOOL isTuning;
CGRect rect;

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define COLOR_BAR                   0x00abeb

#define PURCHASE_ID_EFFECT @"com.appzeal.getfit.inapp.fullvideo"
#define kPurchaseEffect @"PURCHASE_VIDEO"

#endif
