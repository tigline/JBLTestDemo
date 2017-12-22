//
//  LinkOperation.h
//  Weinei-iPhone
//
//  Created by
//  Copyright © 2016年 cml. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreBluetooth/CoreBluetooth.h>
#import "Constants_JBLP.h"


typedef void (^bluetoothStateBlock)(CBManagerState state); //Bluetooth State Block
typedef void (^peripheralConnectionBlock)(BOOL isConnect); // Connection block
typedef void (^JBLGetMfbCommandBlock)(uChar CMD);
typedef void (^JBLgetBrightnessBlock)(NSUInteger brightness);;
typedef void (^JBLMfbCommandBlock)(BOOL isSuccess);


@protocol PeripheralOperationDelegate <NSObject>

@optional

/**
 *  拿到数据
 *
 *  @param array 通过蓝牙设备获取到的数据
 */
- (void)dataWithCharacteristic:(NSArray *)array;

/**
 *  对特性写命令码
 */
- (void)writeCharacteristic;

/**
 *  设备断开连接
 */
- (void)disconnected;

/**
 *  设备连接失败
 */
- (void)failToConnect;

@end

@protocol GetPeripheralInfoDelegate <NSObject>

@optional

/**
 *  搜索到cgm设备的回调
 *
 *  @param info       设备信息
 *  @param peripheral 搜索到的设备
 */
- (void)getAdvertisementData:(NSDictionary *)info andPeripheral:(CBPeripheral *)peripheral;

@end

@interface LinkOperation : NSObject

@property (nonatomic, copy) JBLGetMfbCommandBlock getMfbCommandBlock;

@property (nonatomic, copy) JBLgetBrightnessBlock getBrightnessBlock;

@property (nonatomic, copy) JBLMfbCommandBlock mfbCommandBlock;

@property (nonatomic, strong) NSMutableArray *dataArray;

/**
 *  GetPeripheralDataDelegate 代理
 */
@property (nonatomic, weak) id <GetPeripheralInfoDelegate> delegate;

/**
 *  GetCGMDataDelegate 代理
 */
@property (nonatomic, weak) id <PeripheralOperationDelegate> operationDelegate;

/**
 *  中心设备
 */
@property (nonatomic, strong) CBCentralManager *centeralManager;

/**
 *  外围设备数组
 */
@property (nonatomic, strong) NSMutableArray *peripheralArray;

/**
 *  连接的外围设备
 */
@property (nonatomic, strong) CBPeripheral *connectPeripheral;

/**
 *  连接设备发现的属性
 */
@property (nonatomic, strong) CBCharacteristic *readAndWriteCharacteristic;

/**
 *  连接的设备发现的
 */
@property (nonatomic, strong) CBCharacteristic *notifyCharacteristic;

/**
 *  停止扫描
 */
- (void)stopScan;

/**
 *  断开连接
 */
- (void)cancelConnectPeripheral;

/**
 *  连接设备
 */
- (void)connectDiscoverPeripheral:(peripheralConnectionBlock)state;;

- (void)readDeviceInfo:(NSData *)data;

-(void)getCurrentBrightNess;

/**
 *  扫描设备
 */
- (void)searchlinkDevice;

/**
 *  写数据
 *
 *  @param data 需要写入的命令码
 */
- (void)writeCharacter:(NSData *)data;

-(void)setCurrentBrightNess:(NSUInteger )brightness;
/**
 *  读数据
 */
- (void)readCharacter;

- (NSMutableArray *)loadJBLThemes;
- (void)updateThemes:(unsigned int)themeId andRGBData:(NSData *)RGBData;

- (void)getButtonMode:(void (^) (uChar mode))block;
-(void)getCurrentBrightNess:(void(^)(NSUInteger brightness))block;
- (void)setButtonMode:(ButtonMode)mode status:(void (^) (BOOL success))block;

@end
