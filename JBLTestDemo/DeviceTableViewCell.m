//
//  DeviceTableViewCell.m
//  JBLTestDemo
//
//  Created by mickey on 2017/12/20.
//  Copyright © 2017年 Aaron Hou. All rights reserved.
//

#import "DeviceTableViewCell.h"

@implementation DeviceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellDataWithTitleText:(NSString *)title detailText:(NSDictionary *)dic
{
    self.textLabel.text = title;
    self.detailTextLabel.text = [NSString stringWithFormat:@"kCBAdvDataIsConnectable = %@,\n kCBAdvDataLocalName = %@,\n kCBAdvDataManufacturerData= %@,\n kCBAdvDataTxPowerLevel = %@", dic[@"kCBAdvDataIsConnectable"], dic[@"kCBAdvDataLocalName"], dic[@"kCBAdvDataManufacturerData"], dic[@"kCBAdvDataTxPowerLevel"]];
    //self.detailTextLabel.numberOfLines = 0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
