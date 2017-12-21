//
//  DeviceTableViewCell.h
//  JBLTestDemo
//
//  Created by mickey on 2017/12/20.
//  Copyright © 2017年 Aaron Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *connectState;

- (void)setCellDataWithTitleText:(NSString *)title detailText:(NSDictionary *)dic;
@end
