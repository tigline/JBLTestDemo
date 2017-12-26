//
//  DeviceInfo.m
//  JBLEngine
//
//  Created by Jain, Rahul on 29/07/16.
//  Copyright © 2016 Harman. All rights reserved.
//

#import "DeviceInfo.h"
//#import "PackageFormat_JBLP.h"

@implementation DeviceInfo
- (void)setFirmwareValue:(NSString *)firmwareVersion{
    // firmware version with dot
    _completefirmwareVersion = firmwareVersion;
    
    if(firmwareVersion.length > 3){
        firmwareVersion = [firmwareVersion substringToIndex:3];
    }
    NSMutableArray *buffer = [NSMutableArray arrayWithCapacity:[firmwareVersion length]];
    for (int i = 0; i < [firmwareVersion length]; i++) {
        [buffer addObject:[NSString stringWithFormat:@"%C", [firmwareVersion characterAtIndex:i]]];
    }
    // firmware version without hardware string
    _firmwareVersion = [buffer componentsJoinedByString:@"."];
}
@end
