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

@property (nonatomic, strong) UIActivityIndicatorView *searchIndictorView;

@property (nonatomic, strong) LinkOperation *operation;

@end

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation SearchDeviceTableViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _peripherArray = [NSMutableArray arrayWithCapacity:0];
    _advertisementData = [NSMutableArray arrayWithCapacity:0];
    
    
    _operation = [[LinkOperation alloc] init];
    _operation.delegate = self;
    //    operation.operationDelegate = self;
    [self setIndicateView];
    
    
}

- (void)setIndicateView
{
    _searchIndictorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0,0,80,80)];
    _searchIndictorView.center = self.view.center;
    [_searchIndictorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [_searchIndictorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_searchIndictorView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:_searchIndictorView];
    //[_searchIndictorView startAnimating];
    //[self.tableView setScrollEnabled:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[_searchIndictorView startAnimating];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_operation.connectPeripheral.state == CBPeripheralStateConnected) {
        return;
    }
    [_searchIndictorView startAnimating];
    [_operation searchlinkDevice:^(BOOL successVaule) {
        if (successVaule) {
            [_searchIndictorView stopAnimating];
        }else {
            
        }
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    [_advertisementData removeAllObjects];
//    [_peripherArray removeAllObjects];
    //[_operation stopScan];
    //_operation.connectPeripheral = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - GetPeripheralInfoDelegate -

- (void)getAdvertisementData:(NSDictionary *)info andPeripheral:(CBPeripheral *)peripheral
{
    [_advertisementData addObject:info];
    [_peripherArray addObject:peripheral];
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
    [_searchIndictorView startAnimating];
    [self.tableView setScrollEnabled:NO];
    _operation.connectPeripheral = _peripherArray[indexPath.row];
    NSNumber *number = [NSNumber numberWithInteger:indexPath.row];
    
    if (_operation.connectPeripheral.state == CBPeripheralStateConnected) {
        [self performSegueWithIdentifier:@"toDeviceDashboard" sender:number];
    }
    else
    {
        [_operation connectDiscoverPeripheral:^(BOOL isConnect) {
            if (isConnect) {
                [_searchIndictorView stopAnimating];
                [self.tableView setScrollEnabled:YES];
                [self performSegueWithIdentifier:@"toDeviceDashboard" sender:number];
                //[_operation getRetDevInfo];
            }
        }];
    }
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"toDeviceDashboard"]) {
        //CBPeripheral *connectPeripheral = ((CBPeripheral *)_peripherArray)[sender];
        ((DeviceDashboardViewController *)(segue.destinationViewController)).peripheral = [_peripherArray objectAtIndex:[sender integerValue]];
        ((DeviceDashboardViewController *)(segue.destinationViewController)).deviceInfo = [_advertisementData objectAtIndex:[sender integerValue]];
        ((DeviceDashboardViewController *)(segue.destinationViewController)).operation = _operation;
    }
}


@end
