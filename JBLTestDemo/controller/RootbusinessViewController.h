//
//  RootbusinessViewController.h
//  JBLTestDemo
//
//  Created by Aaron Hou on 26/12/2017.
//  Copyright © 2017 Aaron Hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "PeripheralInfo.h"
#import "LinkOperation.h"

@interface RootbusinessViewController : UITableViewController <PeripheralOperationDelegate>

@property (nonatomic, weak) PeripheralInfo *businessPeripheral;

@property (nonatomic, strong) LinkOperation *operation;

- (UIActivityIndicatorView *)setIndicateView;

@end
