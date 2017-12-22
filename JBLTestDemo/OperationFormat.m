//
//  OperationFormat.m
//  JBLTestDemo
//
//  Created by Aaron Hou on 21/12/2017.
//  Copyright © 2017 Aaron Hou. All rights reserved.
//

#import "OperationFormat.h"
#import "CRC_JBLP.h"
#import "Constants_JBLP.h"
#import <UIKit/UIKit.h>

@implementation OperationFormat


+(BOOL)checkCRCOnAdvertismentDataOK:(NSData *)advData
{
    Byte *pByte = (Byte *)[advData bytes];
    NSData *srcName = [NSData dataWithBytes:pByte+6 length:2];// 7 to 6
    unsigned int srcNamechar;
    [srcName getBytes:&srcNamechar length:sizeof(srcNamechar)];
    srcNamechar = srcNamechar & 0x0000FFFF;
    
    NSData *data = [kDeviceName dataUsingEncoding:NSUTF8StringEncoding];
    u16 srcName_crc = crc16_JBLP(0,[data bytes], (unsigned int)data.length);
    if(srcNamechar == srcName_crc){
        //  NSLog(@"CRC is equal of both speaker");
        return YES;
    }else{
        // NSLog(@"CRC is not equal of both speaker");
        return NO;
    }
    return NO;
    
    
}

+ (unsigned int)parseAdvDataManufacturerDataForVID:(NSData *)data {
    
    Byte *pByte = (Byte *)[data bytes];
    NSData *VIDData = [NSData dataWithBytes:pByte length:2];// 4 TO 2
    
    uint VIDInt = 0;
    [VIDData getBytes:&VIDInt length:sizeof(VIDInt)];
    VIDInt = VIDInt & 0x0000FFFF;   // get lower 2 bytes
    
    return VIDInt;
}


+ (unsigned int)parseAdvDataManufacturerDataForPID:(NSData *)data
{
    Byte *pByte = (Byte *)[data bytes];
    NSData *PIDData = [NSData dataWithBytes:pByte+2 length:2];// 4 TO 2
    
    uint PIDInt = 0;
    [PIDData getBytes:&PIDInt length:sizeof(PIDInt)];
    PIDInt = PIDInt & 0x0000FFFF;   // get lower 2 bytes
    
    return PIDInt;
}

+ (uChar)parseAdvDataManufacturerDataForMID:(NSData *)data
{
    Byte *pByte = (Byte *)[data bytes];
    NSData *MID = [NSData dataWithBytes:pByte+4 length:1]; // 6 to 4
    
    unsigned char MIDchar;
    [MID getBytes:&MIDchar length:sizeof(MIDchar)];
    
    
    return MIDchar;
}

+ (NSData *)requestForDeviceRolePacketFormate
{
    Byte temp[3] = {};
    temp[0] = 0xAA;        // identifier
    temp[1] = eGetRoleInfo_JBLP;        // cmd
    temp[2] = 0x00;
    NSData *data = [NSData dataWithBytes:temp length:3];
    return data;
}

// setBrightness
+(NSData *)setBrightness:(unsigned int)brightnessValue
{
    Byte temp[4] = {};
    temp[0] = 0xAA;             // identifier
    temp[1] = eSetPatternBrightness;             //
    temp[2] = 0x01;             // payload len
    temp[3] = brightnessValue;
    NSData *data = [NSData dataWithBytes:temp length:4];
    return data;
}

+ (NSData *)reqBrightnessInfo
{
    char temp[3] = {};
    temp[0] = 0xAA;             // identifier
    temp[1] = eReqPatternBrightness;      //
    temp[2] = 0x00;             // payload len
    NSData *data = [NSData dataWithBytes:temp length:3];
    return data;
}

+(NSData *)setLedPatternForPluse:(unsigned int)patternType des:(NSData *)desData
{
    Byte temp[8] = {};
    temp[0] = 0xAA;             // identifier
    temp[1] = eSetLEDPattern;             //
    temp[2] = 0x05;             // payload len
    temp[3] = patternType;
    
    Byte *pByte =(Byte *)[desData bytes];  // NSData to Byte
    for (int i = 0; i <desData.length ; i++) {
        temp[4+i] = pByte[i];
    }
    NSData *data = [NSData dataWithBytes:temp length:desData.length+4];
    return data;
}

+ (uChar)parseAckPacketFormatForCmdID:(NSData *)data
{
    Byte *pByte = (Byte *)[data bytes];                 // NSData to Byte
    NSData *cmdIDData = [NSData dataWithBytes:(pByte + 1) length:1];    // Get cmdID data
    
    unsigned char cmdIDUchar;
    [cmdIDData getBytes:&cmdIDUchar length:sizeof(cmdIDUchar)];
    
    return cmdIDUchar;
}

+ (NSData *)MFBEnquiry
{
    
    Byte temp[3] = {};
    temp[0] = 0xAA;                         // identifier
    temp[1] = ReqMFBStatus_JBLP;                    // 0x33
    temp[2] = 0x00;                         // payload len

    
    
    // temp[3] = devIndex;
    
    //  NSData *data = [NSData dataWithBytes:temp length:3];
    //  return data;
    NSData *data = [NSData dataWithBytes:temp length:3];
    return data;
}

+ (uChar)parseMFBMode:(NSData *)data
{
    Byte *pByte = (Byte *)[data bytes];
    NSData *statusData = [NSData dataWithBytes:pByte+3 length:1];
    
    uChar statusCode;
    [statusData getBytes:&statusCode length:sizeof(statusData)];
    
    return statusCode;
}

+(unsigned int)parseRetBrightnessWithData:(NSData *)brightnessData
{
    Byte *pByte = (Byte *)[brightnessData bytes]; // NSData to Byte
    NSData *brightNessValue = [NSData dataWithBytes:(pByte +3) length:1];
    // convert NSData BrightnessValue to int
    unsigned int brightnes = 0;
    [brightNessValue getBytes:&brightnes length:sizeof(brightnes)];
    brightnes = brightnes & 0x00FFFFFF;

    
    return brightnes;
}

+ (NSData *)MFBSetWithDevSetIndex:(MFBDevIndex)state {
    Byte temp[4] = {};
    temp[0] = 0xAA;                         // identifier
    temp[1] = SetMFBStatus_JBLP;                    // 0x32
    temp[2] = 0x01;                         // payload len
    temp[3] = state;
    
    NSData *data = [NSData dataWithBytes:temp length:4];
    return data;  // no return
}


@end
