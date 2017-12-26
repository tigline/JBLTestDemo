//
//  OperationFormat.h
//  JBLTestDemo
//
//  Created by Aaron Hou on 21/12/2017.
//  Copyright © 2017 Aaron Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants_JBLP.h"
@interface OperationFormat : NSObject

+ (BOOL)checkCRCOnAdvertismentDataOK:(NSData *)advData;
+ (unsigned int)parseAdvDataManufacturerDataForVID:(NSData *)data;
+ (unsigned int)parseAdvDataManufacturerDataForPID:(NSData *)data;
+ (uChar)parseAdvDataManufacturerDataForMID:(NSData *)data;
+ (NSData *)requestForDeviceRolePacketFormate;
+ (NSData *)setBrightness:(unsigned int)brightnessValue;
+ (NSData *)reqBrightnessInfo;
+ (NSData *)setLedPatternForPluse:(unsigned int)patternType des:(NSData *)desData;
+ (uChar)parseAckPacketFormatForCmdID:(NSData *)data;
+ (NSData *)MFBEnquiry;
+ (uChar)parseMFBMode:(NSData *)data;

+(unsigned int)parseRetBrightnessWithData:(NSData *)brightnessData;
+ (NSData *)MFBSetWithDevSetIndex:(MFBDevIndex)state;
+ (NSData *)reqDevInfoPacketFormat;
@end
