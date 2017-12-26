//
//  Capability.h
//  JBLEngine
//
//  Created by Deepak Kumar on 8/5/16.
//  Copyright © 2016 Harman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Capability : NSObject

// Hardware update support
@property (readonly, nonatomic, assign, getter = isOTASupport) BOOL OTASupport;

// Show battery Level
@property (readonly, nonatomic, assign, getter = isBatteryLevel) BOOL batteryLevel;

// LED supports
@property (readonly, nonatomic, assign, getter = isLED) BOOL led;

// MFB
@property (readonly, nonatomic, assign, getter = isMFB) BOOL mfb;

// MFB
@property (readonly, nonatomic, assign, getter = isNameSupport) BOOL nameSupport;

@property (readonly, nonatomic, assign, getter = isBrightnessSupport) BOOL brightnessSupport;


@property (readonly, nonatomic, assign, getter = isEquilizerSupport) BOOL equilizerSupport;

@property (readonly, nonatomic, assign, getter = isHFP) BOOL hfp;

@property (readonly, nonatomic, assign, getter = isFeedbackTone) BOOL feedbackTone;



- (instancetype)initWithDic:(NSDictionary *)pDict;

@end
