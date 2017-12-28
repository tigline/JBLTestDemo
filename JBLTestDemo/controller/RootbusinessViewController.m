//
//  RootbusinessViewController.m
//  JBLTestDemo
//
//  Created by Aaron Hou on 26/12/2017.
//  Copyright © 2017 Aaron Hou. All rights reserved.
//

#import "RootbusinessViewController.h"

@interface RootbusinessViewController ()
@property (nonatomic, strong) UIActivityIndicatorView *searchIndictorView;

@end

@implementation RootbusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _operation = [[LinkOperation alloc] init];
    _operation.operationDelegate = self;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)notifyBluetoothState:(BOOL)isOn
{
    if (!isOn) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self showBluetoothDisconnectedAlert];
    }
}

- (UIActivityIndicatorView *)setIndicateView
{
    if (_searchIndictorView) {
        return _searchIndictorView;
    }
    
    _searchIndictorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0,0,80,80)];
    _searchIndictorView.center = self.view.center;
    [_searchIndictorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [_searchIndictorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_searchIndictorView setBackgroundColor:[UIColor lightGrayColor]];
    
    [self.view addSubview:_searchIndictorView];
    
    return _searchIndictorView;
    //[_searchIndictorView startAnimating];
    //[self.tableView setScrollEnabled:NO];
}

- (void)showBluetoothDisconnectedAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Bluetooth Off" message:@"Please Power On Bluetooth" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
    [alertController addAction:sureAction];
//    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:NO completion:nil];
    
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
