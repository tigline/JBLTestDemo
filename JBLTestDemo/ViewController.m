//
//  ViewController.m
//  BlueToothDemo
//
//  Created by 徐正权 on 16/5/28.
//  Copyright © 2016年 徐正权. All rights reserved.
//

#import "ViewController.h"

// Class
#import "LinkOperation.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, GetPeripheralInfoDelegate>

@property (nonatomic, strong) NSMutableArray *advertisementData;

@property (nonatomic, strong) NSMutableArray *peripherArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LinkOperation *operation;

@property (nonatomic, strong) UIButton *writeBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _peripherArray = [NSMutableArray arrayWithCapacity:0];
    _advertisementData = [NSMutableArray arrayWithCapacity:0];
    
    [self createUI];
    
    _operation = [[LinkOperation alloc] init];
    _operation.delegate = self;
//    operation.operationDelegate = self;
    [_operation searchlinkDevice];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_advertisementData removeAllObjects];
    [_peripherArray removeAllObjects];
}

- (void)createUI
{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _peripherArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = ((CBPeripheral *)_peripherArray[indexPath.row]).name;
    NSDictionary *dic = _advertisementData[indexPath.row];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"kCBAdvDataIsConnectable = %@,\n kCBAdvDataLocalName = %@,\n kCBAdvDataManufacturerData= %@,\n kCBAdvDataTxPowerLevel = %@", dic[@"kCBAdvDataIsConnectable"], dic[@"kCBAdvDataLocalName"], dic[@"kCBAdvDataManufacturerData"], dic[@"kCBAdvDataTxPowerLevel"]];
    cell.detailTextLabel.numberOfLines = 0;
    
    UIButton *btn = [[UIButton alloc] init];
    CGRect bPos;
    bPos.origin.x = cell.frame.size.width * 0.75f;
    bPos.origin.y = cell.frame.size.height * 0.25f;
    bPos.size.width = cell.frame.size.width * 0.2f;
    bPos.size.height = cell.frame.size.height * 0.5f;
    btn.frame = bPos;
    btn.backgroundColor = [UIColor orangeColor];
    [cell addSubview:btn];
    [btn addTarget:self action:@selector(readHostInfo) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (NSData *)reqDevInfoPacketFormat
{
    char temp[3] = {};
    temp[0] = 0xAA;             // identifier
    temp[1] = 0x11;//eReqDevInfo_JBLP;      // 0x11
    temp[2] = 0x00;             // payload len
    
    NSData *data = [NSData dataWithBytes:temp length:3];
    return data;
}

- (void)readHostInfo
{
    [_operation readDeviceInfo:[self reqDevInfoPacketFormat]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _operation.connectPeripheral = _peripherArray[indexPath.row];
    [_operation connectDiscoverPeripheral];
}

#pragma mark - GetPeripheralInfoDelegate -

- (void)getAdvertisementData:(NSDictionary *)info andPeripheral:(CBPeripheral *)peripheral
{
    [_advertisementData addObject:info];
    [_peripherArray addObject:peripheral];
    [_tableView reloadData];
}

@end
