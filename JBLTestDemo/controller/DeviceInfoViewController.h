//
//  DeviceInfoViewController.h
//  JBLTestDemo
//
//  Created by Aaron Hou on 26/12/2017.
//  Copyright © 2017 Aaron Hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *firmwareView;
@property (weak, nonatomic) IBOutlet UILabel *firmwareLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;


@end
