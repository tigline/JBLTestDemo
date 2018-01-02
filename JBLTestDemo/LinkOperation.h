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
#import "DeviceInfo.h"




typedef void (^bluetoothStateBlock)(CBManagerState state); //Bluetooth State Block
typedef void (^peripheralConnectionBlock)(BOOL isConnect); // Connection block
typedef void (^JBLGetMfbCommandBlock)(uChar CMD);
typedef void (^JBLgetBrightnessBlock)(NSUInteger brightness);
typedef void (^JBLMfbCommandBlock)(BOOL isSuccess);
//typedef void (^GetFeedbackToneBlock)(BOOL feedbackToneValue);
typedef void (^JBLGetFeedbackToneBlock)(BOOL feedbackToneValue);
typedef void (^JBLGetHFPStatusBlock)(BOOL hfpStatusValue);
typedef void (^JBLConnectSuccessBlock)(BOOL successVaule);
typedef void (^JBLGetLedPatternsBlock)(NSInteger ledPatternIndex);
typedef void(^JBLNotifyLedPatternsBlock)(unsigned int themeId);


@protocol PeripheralOperationDelegate <NSObject>

@optional

- (void)notifyBluetoothState:(BOOL)isOn;

/**
 *  when get device data.
 *
 *  @param array  device data array
 */
- (void)dataWithCharacteristic:(NSArray *)array;

/**
 *  when write
 */
- (void)writeCharacteristic;

/**
 *  when disconnected
 */
- (void)disconnected;

/**
 *  connected failed
 */
- (void)failToConnect;

@end

@protocol GetPeripheralInfoDelegate <NSObject>

@optional

/**
 *
 *
 *  @param info  deviceInfo
 *  @param peripheral 123
 */
- (void)getAdvertisementData:(NSDictionary *)info andPeripheral:(CBPeripheral *)peripheral;

@end

@interface LinkOperation : NSObject<NSURLSessionDelegate>

@property (nonatomic, copy) JBLGetMfbCommandBlock getMfbCommandBlock;

@property (nonatomic, copy) JBLgetBrightnessBlock getBrightnessBlock;

@property (nonatomic, copy) JBLMfbCommandBlock mfbCommandBlock;

@property (nonatomic, copy) JBLGetFeedbackToneBlock feedbackToneBlock;

@property (nonatomic, copy) JBLGetHFPStatusBlock getHFPStatusBlock;

@property (nonatomic, copy) JBLConnectSuccessBlock connectSuccessBlock;

@property (nonatomic, copy) JBLNotifyLedPatternsBlock getNotifyLedPatternBlock;

@property (nonatomic, strong) NSMutableArray *dataArray;

/**
 *  GetPeripheralDataDelegate
 */
@property (nonatomic, weak) id <GetPeripheralInfoDelegate> delegate;

/**
 *  GetCGMDataDelegate
 */
@property (nonatomic, weak) id <PeripheralOperationDelegate> operationDelegate;

/**
 *  Center Device
 */
@property (nonatomic, strong) CBCentralManager *centeralManager;

/**
 *  Peripheral DeviceArray
 */
@property (nonatomic, strong) NSMutableArray *peripheralArray;

/**
 *  Connected Peripheral Device
 */
@property (nonatomic, strong) CBPeripheral *connectPeripheral; 

/**
 *  Peripheral Characteristic
 */
@property (nonatomic, strong) CBCharacteristic *readAndWriteCharacteristic;

/**
 *
 */
@property (nonatomic, strong) CBCharacteristic *notifyCharacteristic;

/**
 *  stopScan
 */
- (void)stopScan;

/**
 *  disconnected
 */
- (void)cancelConnectPeripheral;

/**
 *  connect device
 */
- (void)connectDiscoverPeripheral:(peripheralConnectionBlock)state;;

- (void)readDeviceInfo:(NSData *)data;


/**
 *  scan device
 */
- (void)searchlinkDevice:(JBLConnectSuccessBlock)connectSuccessBlock;

/**
 *  wirte data
 *
 *  @param data
 */
- (void)writeCharacter:(NSData *)data;

//setCurrentBrightNess

-(void)setCurrentBrightNess:(NSUInteger )brightness;


@property (nonatomic, strong) DeviceInfo *deviceInfo;

@property (nonatomic,copy) NSString *otaUrl;

@property (nonatomic,copy) NSString *whatsNewUrl;

//0 upgrade bt  ;2 upgrade mcu ; 3 upgrade bt&&mcu
@property (assign, nonatomic) NSInteger upgradeType;

- (void)checkUpdate:(void (^)(NSDictionary *updateInfoDict, NSError *error))updateInfo;

- (void)readCharacter;

- (void)getRetDevInfo;

- (NSMutableArray *)loadJBLThemes;

- (void)updateThemes:(unsigned int)themeId andRGBData:(NSData *)RGBData;

- (void)getButtonMode:(void (^) (uChar mode))block;

- (void)getCurrentBrightNess:(void(^)(NSUInteger brightness))block;

- (void)setButtonMode:(ButtonMode)mode status:(void (^) (BOOL success))block;

- (void)setFeedbackToneValue:(BOOL)feedbackValue;

- (void)getFeedbackToneValue:(JBLGetFeedbackToneBlock)feedbackToneBlock;

- (void)getHFPStatusValue:(JBLGetHFPStatusBlock)getHFPStatusBlock;

- (void)setHFPStatusValue:(BOOL)hfpValueEnabled;

//- (void)getAllLedPatternInfoWithHandler;

- (void)getLedPatternInfo:(JBLNotifyLedPatternsBlock)block;

@end
