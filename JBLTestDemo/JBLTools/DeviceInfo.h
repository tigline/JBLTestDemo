// 
//  DeviceInfo.h
//  JBLEngine
// 
//  Created by Jain, Rahul on 29/07/16.
//  Copyright © 2016 Harman. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DeviceInfo : NSObject
// Broadcaster: 1, Receiver: 2, Normal: 0
@property (nonatomic, assign) unsigned char role;

// Battry chargint/not charging
@property (nonatomic, assign) short batteryStatus;

// Batrry value in percentage
@property (nonatomic, assign) unsigned char batteryValue;

// Channel left = 1\right = 2\stereo = 0
@property (nonatomic, assign) unsigned char activeChanne;

// Bluetooth A2dp, No Audio playing, AUX IN
@property (nonatomic, assign) unsigned char audioSource;

// Voice control selected
@property (nonatomic,assign)  BOOL isMFBEnable;

// Peripheral mac address
@property (nonatomic,copy) NSString *macAddress;

@property (nonatomic,copy) NSString *tokenValue;

// Firmware verion without hardware sting
@property (nonatomic,copy, readonly) NSString *firmwareVersion;

// firmware verion without hardware sting
@property (nonatomic,copy, readonly) NSString *completefirmwareVersion;


/**
 Set firmaware version with dot seperated
 */
- (void)setFirmwareValue:(NSString *)firmwareVersion;

@end
