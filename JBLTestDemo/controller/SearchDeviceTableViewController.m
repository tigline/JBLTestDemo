//
//  SearchDeviceTableViewController.m
//  BlueToothDemo
//
//

#import "SearchDeviceTableViewController.h"
#import "LinkOperation.h"
#import "DeviceTableViewCell.h"
#import "LinkOperation.h"
#import "DeviceDashboardViewController.h"

@interface SearchDeviceTableViewController () <GetPeripheralInfoDelegate>

@property (nonatomic, strong) NSMutableArray *advertisementData;

@property (nonatomic, strong) NSMutableArray *peripherArray;

@property (nonatomic, assign) BOOL isSearch;




@end

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation SearchDeviceTableViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _peripherArray = [NSMutableArray arrayWithCapacity:0];
    _advertisementData = [NSMutableArray arrayWithCapacity:0];
    self.operation.delegate = self;
    self.operation.operationDelegate = self;

    //[self setIndicateView];
    
    
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[_searchIndictorView startAnimating];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (self.operation.connectPeripheral.state == CBPeripheralStateConnected) {
        return;
    }

    [self searchDevice];
}


- (void)searchDevice
{
    _isSearch = YES;
    [self.setIndicateView startAnimating];
    [self.operation searchlinkDevice:^(BOOL successVaule) {
        
        if (successVaule) {
            [self.setIndicateView stopAnimating];
            _isSearch = NO;
        }else {
            [self.setIndicateView stopAnimating];
            _isSearch = NO;
        }
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _isSearch = NO;
//    [_advertisementData removeAllObjects];
//    [_peripherArray removeAllObjects];
    //[_operation stopScan];
    //_operation.connectPeripheral = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.frame.origin.x > -10.0f && !_isSearch) {
        [_peripherArray removeAllObjects];
        [_advertisementData removeAllObjects];
        //[self.tableView reloadData];
        [self searchDevice];
    }
    
}


#pragma mark - GetPeripheralInfoDelegate -

- (void)getAdvertisementData:(NSDictionary *)info andPeripheral:(CBPeripheral *)peripheral
{
    [_advertisementData addObject:info];
    [_peripherArray addObject:peripheral];
    [self.tableView reloadData];
}

- (void)disconnected
{
    [_peripherArray removeAllObjects];
    [_advertisementData removeAllObjects];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _peripherArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    
//    DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        cell = [[DeviceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
//    }
//
//    [cell setCellDataWithTitleText:((CBPeripheral *)_peripherArray[indexPath.row]).name detailText:_advertisementData[indexPath.row]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = ((CBPeripheral *)_peripherArray[indexPath.row]).name;
    NSDictionary *dic = _advertisementData[indexPath.row];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"kCBAdvDataIsConnectable = %@,\n kCBAdvDataLocalName = %@,\n kCBAdvDataManufacturerData= %@,\n kCBAdvDataTxPowerLevel = %@", dic[@"kCBAdvDataIsConnectable"], dic[@"kCBAdvDataLocalName"], dic[@"kCBAdvDataManufacturerData"], dic[@"kCBAdvDataTxPowerLevel"]];
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.setIndicateView startAnimating];
    [self.tableView setScrollEnabled:NO];
    self.operation.connectPeripheral = _peripherArray[indexPath.row];
    NSNumber *number = [NSNumber numberWithInteger:indexPath.row];
    
    if (self.operation.connectPeripheral.state == CBPeripheralStateConnected) {
        [self.setIndicateView stopAnimating];
        [self performSegueWithIdentifier:@"toDeviceDashboard" sender:number];
    }
    else
    {
        [self.operation connectDiscoverPeripheral:^(BOOL isConnect) {
            if (isConnect) {
                [self.setIndicateView stopAnimating];
                [self.tableView setScrollEnabled:YES];
                [self performSegueWithIdentifier:@"toDeviceDashboard" sender:number];
                //[_operation getRetDevInfo];
            }
        }];
    }
    
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"toDeviceDashboard"]) {
        //CBPeripheral *connectPeripheral = ((CBPeripheral *)_peripherArray)[sender];
        ((DeviceDashboardViewController *)(segue.destinationViewController)).peripheral = [_peripherArray objectAtIndex:[sender integerValue]];
        ((DeviceDashboardViewController *)(segue.destinationViewController)).deviceInfo = [_advertisementData objectAtIndex:[sender integerValue]];
        ((DeviceDashboardViewController *)(segue.destinationViewController)).operation = self.operation;
    }
}


@end
