//
//  PeripheralInfo.h
//  JBLTestDemo
//
//  Created by Aaron Hou on 26/12/2017.
//  Copyright © 2017 Aaron Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>



@interface PeripheralInfo : NSObject<NSURLSessionDelegate>

@property (nonatomic, strong) CBPeripheral *peripheral;

@property (nonatomic, strong) NSDictionary *advertisementData;

@property (nonatomic, strong) DeviceInfo *deviceInfo;

@property (nonatomic,copy) NSString *otaUrl;

@property (nonatomic,copy) NSString *whatsNewUrl;

//0 upgrade bt  ;2 upgrade mcu ; 3 upgrade bt&&mcu
@property (assign, nonatomic) NSInteger upgradeType;



@end
