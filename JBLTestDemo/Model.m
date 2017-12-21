//
//  Model.m
//  JBLEngine
//
//  Created by Deepak Kumar on 8/5/16.
//  Copyright © 2016 Harman. All rights reserved.
//

#import "Model.h"
#import "Constants_JBLP.h"

@implementation Model

- (instancetype)initWithDic:(NSDictionary *)pDict{
    self = [super init];
    if (self) {        
        _mid    = [pDict objectForKey:@"mid"];
        unsigned colorInt = 0;
        [[NSScanner scannerWithString:[pDict objectForKey:@"color"]] scanHexInt:&colorInt];
        _color  = UIColorFromRGB(colorInt);
        _imageName  = [pDict objectForKey:@"img"];
    }
    return self;
}


@end
