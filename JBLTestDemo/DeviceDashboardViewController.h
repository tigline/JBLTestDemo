//
//  DeviceDashboardViewController.h
//  JBLTestDemo
//
//  Created by mickey on 2017/12/21.
//  Copyright © 2017年 Aaron Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "LinkOperation.h"
@interface DeviceDashboardViewController : UIViewController

@property (nonatomic, assign) CBPeripheral *peripheral;
@property (nonatomic, assign) NSDictionary *deviceInfo;
@property (nonatomic, strong) LinkOperation *operation;
@property (weak, nonatomic) IBOutlet UISlider *slide;

@end
