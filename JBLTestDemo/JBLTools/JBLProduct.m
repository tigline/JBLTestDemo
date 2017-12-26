//
//  JBLProduct.m
//  JBLEngine
//
//  Created by Deepak Kumar on 8/9/16.
//  Copyright © 2016 Harman. All rights reserved.
//

#import "JBLProduct.h"
#import "Model.h"

@implementation JBLProduct

/**
 Create JBLProduct from JBLProduct.xml when JBLSpeaker found in discovery.
 
 @param pDict created from JBLProduct.xml
 @return return JBLProduct
 */
- (instancetype)initWithDic:(NSDictionary *)pDict{
    self = [super init];
    if (self) {
        
        _productName   = [pDict objectForKey:@"name"];
        
        _pid    = [pDict objectForKey:@"pid"];
        
        NSDictionary *capabilityDict = [pDict objectForKey:@"capability"];
        _capability = [[Capability alloc] initWithDic:capabilityDict];
        
        _models = [NSMutableArray new];
        for (NSDictionary *modelDict in [capabilityDict objectForKey:@"model"]) {
            [_models addObject:[[Model alloc] initWithDic:modelDict]];
        }
    }
    return self;
}

@end
