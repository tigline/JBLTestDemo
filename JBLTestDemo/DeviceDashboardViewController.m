//
//  DeviceDashboardViewController.m
//  JBLTestDemo
//
//  Created by mickey on 2017/12/21.
//  Copyright © 2017年 Aaron Hou. All rights reserved.
//

#import "DeviceDashboardViewController.h"

@interface DeviceDashboardViewController ()

@end

@implementation DeviceDashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _peripheral.name;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)TestFuncBtn:(id)sender {
    

    [_operation getCurrentBrightNess];
}

//- (IBAction)updateValue:(UISlider *)sender {
//
//    NSUInteger brightnessValue = (NSUInteger)sender.value;
//    [_operation setCurrentBrightNess:brightnessValue];
//
//}

- (IBAction)updateValue:(UISlider *)sender {
        NSUInteger brightnessValue = (NSUInteger)sender.value;
        [_operation setCurrentBrightNess:brightnessValue];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
