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

@interface RootbusinessViewController : UIViewController

@property (nonatomic, weak) PeripheralInfo *businessPeripheral;

@end
