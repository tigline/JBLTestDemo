//
//  DeviceDashboardViewController.m
//  JBLTestDemo
//
//  Created by mickey on 2017/12/21.
//  Copyright © 2017年 Aaron Hou. All rights reserved.
//

#import "DeviceDashboardViewController.h"
#import "JBLThemeModel.h"

@interface DeviceDashboardViewController () <UIPickerViewDelegate, UIPickerViewDataSource>


@end

@implementation DeviceDashboardViewController
{
    NSMutableArray *themeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view layoutIfNeeded];
    self.title = _peripheral.name;
    
    _partyButton.layer.cornerRadius = _partyButton.frame.size.width*0.05f;
    _stereoButton.layer.cornerRadius = _stereoButton.frame.size.width*0.05f;
    _slide.layer.cornerRadius = _slide.frame.size.width*0.05f;
    
    //UINavigationItem *setItem = [[UINavigationItem alloc]init];
    UIBarButtonItem *setButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(gotoSetViewController)];
    self.navigationItem.rightBarButtonItem = setButton;
    
    
    NSArray *themeArrayBySource = [_operation loadJBLThemes];
    themeArray = [NSMutableArray new];
    for(int i = 0; i< [themeArrayBySource count];i++)
    {
        JBLThemeModel *theme = [[JBLThemeModel alloc]initWithThemeDic:[themeArrayBySource objectAtIndex:i]];
        //[theme updateThemeCurrentRGBValue:[themeArray objectAtIndex:i]];
        [themeArray addObject:theme];
    }
    
    
    [self setupDeviceStatus];
    //

    // Do any additional setup after loading the view.
}

- (void)setupDeviceStatus
{
    [_operation getButtonMode:^(unsigned char mode) {
        BOOL modeBtnValue = [[NSNumber numberWithUnsignedChar:mode] boolValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            _modeSwitchBtn.on = modeBtnValue;
        });
        
    }];
    
    [_operation getCurrentBrightNess:^(NSUInteger brightness) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _slide.value = brightness;
        });
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeModeBtn:(UISwitch *)sender {
    
    if (sender.on == YES) {
        [_operation setButtonMode:kVoiceControlMode status:^(BOOL success) {
            
        }];
    }else {
        [_operation setButtonMode:kPlayPauseMode status:^(BOOL success) {
            
        }];
    }
    
}

- (IBAction)TestFuncBtn:(id)sender {
    
    [self setupDeviceStatus];
    //[_operation getCurrentBrightNess];
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

- (void)gotoSetViewController {
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return themeArray.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    if (component == 0) {
//        return nil;
//    }else{
        JBLThemeModel * themeMode = [themeArray objectAtIndex:row];
        NSString *rowName = themeMode.strThemeName;
        return rowName;
//    }
}
/** 当选择某一个列中的某一行的时候会调用该方法 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    // 使用一个UIAlertView来显示用户选中的列表项
    JBLThemeModel * themeMode = [themeArray objectAtIndex:row];
    NSLog(@"select theme: %@", themeMode.strThemeName);
    [_operation updateThemes:themeMode.themeType andRGBData:[themeMode getThemeColorInDataWithResetValue:YES]];
    
}


/*
- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}
*/
- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    
}

- (void)setNeedsFocusUpdate {
    
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    return YES;
}

- (void)updateFocusIfNeeded {
    
}

@end
