//
//  Model.h
//  JBLEngine
//
//  Created by Deepak Kumar on 8/5/16.
//  Copyright © 2016 Harman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Model : NSObject

// Model Id
@property (nonatomic, copy, readonly) NSString *mid;

// Speaker Icon
@property (nonatomic, copy, readonly) NSString *imageName;

// Theme color
@property (nonatomic, strong, readonly) UIColor *color;

- (instancetype)initWithDic:(NSDictionary *)pDict;

@end
