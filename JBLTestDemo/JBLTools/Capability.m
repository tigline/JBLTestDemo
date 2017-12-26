//
//  Capability.m
//  JBLEngine
//
//  Created by Deepak Kumar on 8/5/16.
//  Copyright © 2016 Harman. All rights reserved.
//

#import "Capability.h"

@implementation Capability

#define ISOTA @"isOTA"
#define LED @"led"
#define MFB @"mfb"
#define BATTERY @"battery"
#define RENAME @"rename"
#define BRIGHTNESS @"brightness"
#define HFP @"HFP"
#define EQUILIZER @"EQ"
#define FEEDBACK_TONE @"feedbackTone"

- (instancetype)initWithDic:(NSDictionary *)pDict{
    self = [super init];
    if (self) {
        _OTASupport     = [[pDict objectForKey:ISOTA] boolValue];
        _led            = [[pDict objectForKey:LED] boolValue];
        _mfb            = [[pDict objectForKey:MFB] boolValue];
        _batteryLevel   = [[pDict objectForKey:BATTERY] boolValue];
        _nameSupport    = [[pDict objectForKey:RENAME] boolValue];
        _brightnessSupport   = [[pDict objectForKey:BRIGHTNESS] boolValue];
        _hfp            = [[pDict objectForKey:HFP] boolValue];
        _equilizerSupport = [[pDict objectForKey:EQUILIZER] boolValue];
        _feedbackTone = [[pDict objectForKey:FEEDBACK_TONE] boolValue];
        
    }
    return self;
}

@end
