//
//  JBLProduct.h
//  JBLEngine
//
//  Created by Deepak Kumar on 8/9/16.
//  Copyright © 2016 Harman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Capability.h"

@interface JBLProduct : NSObject

// Speaker name
@property (nonatomic, copy, readonly) NSString *productName;

// Product Id
@property (nonatomic, copy, readonly) NSString *pid;

// Speaker capability
@property (nonatomic, strong) Capability *capability;

// Supporting Models
@property (nonatomic, strong) NSMutableArray *models;

- (instancetype)initWithDic:(NSDictionary *)pDict;


@end
