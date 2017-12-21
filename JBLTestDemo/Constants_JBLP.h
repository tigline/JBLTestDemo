//
//  Constants_JBLP.h
//  BLE_Application
//
//  Created by Cloudy on 14/12/2.
//  Copyright (c) 2014年 Matchbox. All rights reserved.
//

//Created new branch -BoomBox_UI
#ifndef BLE_Application_Constants_JBLP_h
#define BLE_Application_Constants_JBLP_h

#define k_CBAdvDataManufacturerData @"kCBAdvDataManufacturerData"
#define k_CBAdvDataLocalName        @"kCBAdvDataLocalName"
#define k_CBAdvDataIsConnectable    @"kCBAdvDataIsConnectable"
#define k_VID 0x57

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SUPPORTED_VIDS @"Supported Harman VIDS"

#ifdef DEBUG  // for local build and testing purpose only

#define FLIP4_UPGRADE_URL @"http://storage.harman.com/Testing/JBLConnectPlus/Flip4/Flip4_upgrade_Test_index.xml"
                            //@"http://testingportal.net23.net/small_dfu.xml"
#define PULSE3_UPGRADE_URL   @"http://storage.harman.com/Testing/JBLConnectPlus/Pulse3/Pulse3_upgrade_Test_index.xml"

#define ONYX_UPGRADE_URL @"http://storage.harman.com/Testing/HK/Onyx4/Onyx4_upgrade_Test_index.xml"
            //@"http://testingportal.net23.net/Flip4_upgrade_Test_index_test_purpose.xml"

#define BOOMBOX_UPGRADE_URL @"http://storage.harman.com/Testing/JBLConnectPlus/BoomBox/BoomBox_upgrade_Test_index.xml"

#define CHARGE3_UPGRADE_URL   @"http://storage.harman.com/Testing/JBLConnectPlus/Charge3/Charge3_upgrade_Test_index.xml"

//for Whats new
#define WHATS_NEW_PULSE3_URL @"http://storage.harman.com/Testing/JBLConnectPlus/Pulse3/news_Test_Pulse3.xml"
#define WHATS_NEW_FLIP4_URL @"http://storage.harman.com/Testing/JBLConnectPlus/Flip4/news_Test_Flip4.xml"
#define WHATS_NEW_ONYX_URL @"http://storage.harman.com/Testing/HK/Onyx4/news_Test_onyx4.xml"
#define WHATS_NEW_BOOMBOX_URL @"http://storage.harman.com/Testing/JBLConnectPlus/BoomBox/news_Test_BoomBox.xml"
#define WHATS_NEW_CHARGE3_URL @"http://storage.harman.com/Testing/JBLConnectPlus/Charge3/news_Test_Charge3.xml"

#else // Change this URL for Release version

#define FLIP4_UPGRADE_URL @"http://storage.harman.com/JBLConnectPlus/Flip4/Flip4_upgrade_index.xml"
#define PULSE3_UPGRADE_URL @"http://storage.harman.com/JBLConnectPlus/Pulse3/Pulse3_upgrade_index.xml"
#define ONYX_UPGRADE_URL @"http://storage.harman.com/HK/Onyx4_upgrade_index.xml"

#define BOOMBOX_UPGRADE_URL @"http://storage.harman.com/JBLConnectPlus/BoomBox/BoomBox_upgrade_index.xml"

#define CHARGE3_UPGRADE_URL   @"http://storage.harman.com/JBLConnectPlus/Charge3/Charge3_upgrade_index.xml"

//for Whats new
#define WHATS_NEW_PULSE3_URL @"http://storage.harman.com/JBLConnectPlus/Pulse3/news_Pulse3.xml"
#define WHATS_NEW_FLIP4_URL @"http://storage.harman.com/JBLConnectPlus/Flip4/news_Flip4.xml"
#define WHATS_NEW_ONYX_URL @"http://storage.harman.com/HK/Onyx4/news_onyx4.xml"
#define WHATS_NEW_BOOMBOX_URL @"http://storage.harman.com/JBLConnectPlus/BoomBox/news_BoomBox.xml"
#define WHATS_NEW_CHARGE3_URL @"http://storage.harman.com/JBLConnectPlus/Charge3/news_Charge3.xml"

#endif


//  version
#define JBLEngine_SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define JBLEngine_SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define JBLEngine_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define JBLEngine_SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define JBLEngine_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


//TODO : will be Remove later_progressView.
#define isRoleImeplemented   1

#define  RELEASE_DESCRIPTOR  @"ReleaseDescriptors"
#define  RELEASE             @"Release"
#define  VERSION             @"version"
#define  MD5                 @"md5"
#define  TEXT                @"text"

// dfu info Constant
#define lastModified         @"Last-Modified"
#define dateFormatWithTime   @"E, d MMM yyyy HH:mm:ss Z"
#define dateFormat           @"MMM dd, yyyy"


#define kDeviceName [[UIDevice currentDevice] name]

#define bleTxRxService  [CBUUID UUIDWithString:kBLE_TX_RX_SERVICE]
#define kBLE_TX_RX_SERVICE @"65786365-6c70-6f69-6e74-2e636f6d0000"
#define kRX_CHAR @"65786365-6c70-6f69-6e74-2e636f6d0001"
#define kTX_CHAR @"65786365-6c70-6f69-6e74-2e636f6d0002"
#define kGAP_SERVICE @"1800"

#define PACKET_LENGTH  104
#define PULSE2_PACKET_LENGTH  128

#define  uChar unsigned char

// enable this flag while doing tasks like logging or showing toast o
#define debugMode_JBLP 0

//State of OTA 50% when downloding completed
#define DOWNLOADING_COMPLETED 0.5

typedef NS_ENUM(NSInteger, CammandType){
    kRenameType         = 0,
    kChannelType        = 1,
    kRoleType           = 2,
    kRetDevInfoType     = 3
};


typedef NS_ENUM(NSInteger, E_SetDataType_JBLP){
    eDevAllInfo_JBLP          = 0,
    eDevInfoToken_JBLP        = 1,
    eRename_JBLP              = 2,
    eLinkDev_JBLP             = 3
};


typedef NS_ENUM(NSInteger, AudioMode){
    kDashboard = 0,
    kPartyAudioMode,
    kStereoAudioMode,
    kDjAudioMode,
};

typedef NS_ENUM(NSInteger, DeviceMode){
    kDeviceModeNormal = 0,
    kDeviceModeBroadcaster = 1,
    kDeviceModeReceiver = 2,
};

// token ID
typedef NS_ENUM(NSInteger, ETokenID_JBLP){
    eDeviceName_JBLP            = 0xC1,
    eProductID_JBLP             = 0x42,
    eModuleID_JBLP              = 0x43,
    eBatteryStatus_JBLP         = 0x44,
    eLinkedDeviceCount_JBLP     = 0x45,
    eActiveChannel_JBLP         = 0x46,
    eAudioSource_JBLP           = 0x47,
    eDevReUpgradeStatus_JBLP    = 0x48,
    eConnectLED_JBLP            = 0x51,
    eLEDPattern_JBLP            = 0x53,
    eBright_JBLP                = 0x56
};

typedef NS_ENUM(NSInteger, EACKType_JBLP){
    eDevACKType_JBLP            = 0x00,
    eRetDevInfoType_JBLP        = 0x01,
    eRetDevInfoTokenType_JBLP   = 0x02
};

typedef NS_ENUM(NSInteger, EChannelType_JBLP){
    eStereo_JBLP                = 0x00,
    eLeft_JBLP                  = 0x01,
    eRight_JBLP                 = 0x02
};

typedef NS_ENUM(NSInteger, ECMDTpye_JBLP) {
    eDevACK_JBLP                 = 0x00,
    eDisACK_JBLP                 = 0x02,
    eAppACK_JBLP                 = 0x03,
    
    eReqDevInfo_JBLP             = 0x11,
    eRetDevInfo_JBLP             = 0x12,
    eReqDevInfoToken_JBLP        = 0x13,
    eSetDevInfo_JBLP             = 0x15,
    eSetRoleInfo_JBLP            = 0x16,
    eGetRoleInfo_JBLP            = 0x17,
    
    eReqLinkDev_JBLP             = 0x21,
    eNotifyLinkDevDrop_JBLP      = 0x22,
    eReqDropLinkDev_JBLP         = 0x23,
    
    eReqStartLinking_JBLP        = 0x25,
    
    eIdentDev_JBLP               = 0x31,
    SetMFBStatus_JBLP            = 0x32,  // MFB VR set command
    ReqMFBStatus_JBLP            = 0x33,  // MFB VR req command
    RetMFBStatus_JBLP            = 0x34,  // MFB VR return req status command
    
    eDeviceVersion_JBLP          = 0x42,
    eDeviceUpgradeStatus_JBLP    = 0x45,
    eDfuRetNoticStatus_JBLP      = 0x46,
    eDeviceReUpgradeLength_JBLP  = 0x49,
    
    eNotifyDfuCancel_JBLP        = 0x47,
    
    eNotifyPatterIdAndStatus_JBLP = 0x52,
    eNotifyMusicMode_JBLP         = 0x54,   //music mode
    eNotifyPatterChange_JBLP      = 0x55,   // patter change
    eNotifyColorChange_JBLP       = 0x57,
    ENotifyAppIsNewVersion_JBLP   = 0x16,
    
    eReqLedPattern            = 0x51,    // request Led Pattern Info
    eRetLedPattern            = 0x52,    // request Led Pattern Info
    eSetLEDPattern            = 0x53,    // Set Led pattern
    eNotifyLEDPattern         = 0x54,     // NotifyLedPattern
    
    eSetPatternBrightness            = 0x55,    // Set Brightness pattern
    eReqPatternBrightness            = 0x56,    // request Brightness  Info
    eRetPatternBrightness            = 0x57,    // request Brightness  Info
    eNotifyPatternBrightness         = 0x58,    // notify Brightness Info

    ReqEQMode                = 0x61,
    RetEQMode                = 0x62,
    SetEQMode                = 0x63,
    NotifyEQChangeMode       = 0x64,
    
    ReqFeedbackTone         = 0x65,
    RetFeedbackTone         = 0x66,
    SetFeedbackTone         = 0x67,
    
    ReqHFPStatus            = 0x68,
    RetHFPStatus            = 0x69,
    SetHFPStatus            = 0x70
};


typedef NS_ENUM(NSInteger, ESpeakerOwnerType_JBLP){
    eSpeakerOwnerHost_JBLP               = 0x00,
    eSpeakerOwnerlink_JBLP               = 0x01
};


typedef NS_ENUM(NSInteger, ENotifyDfuStateStatusCode_JBLP) {
    eNotifyDfuStateError_JBLP       = 0x00,
    eNotifyDfuStateReady_JBLP      = 0x01,
    eNotifyDfuStateDownloading_JBLP= 0x02,
    eNotifyDfuStateUpgrade_JBLP    = 0x03
};

typedef NS_ENUM(NSInteger, EByeByeStatusCode_JBLP) {
    
    eUnknown_JBLP                  = 0x00,
    eDevicePowerOff_JBLP           = 0x01,
    eEstablishedDrop_JBLP          = 0x02,
    eOthers_JBLP                   = 0x03
};
typedef NS_ENUM(NSInteger, EMsgCode_JBLP) {
    
    eUnknownReason_JBLP            = 0x00,
    eUserCancelled_JBLP            = 0x01
    
};

typedef NS_ENUM(NSInteger, EByebyePage_JBLP) {
    
    eDisPage_JBLP            = 1,
    eDashPage_JBLP           = 2
    
};

// BLE Type
typedef NS_ENUM(NSUInteger, BLEType) {
    iAP = 0,
    BLE,
};

// Protocol Type
typedef NS_ENUM(NSUInteger, ProtocolType){
    kFSProtocol = 0,
    kHARMANProtocol,
    kLinkProtocol
};

// Device Model
typedef NS_ENUM(NSUInteger, DeviceType) {
    JBLFlip3_JBLP  = 0x0023, //0x0016
    JBLPLUSE2 = 0x0026, //0x0018
    JBLTrip = 0x0024, //x0017
    JBLCharge3_JBLP = 0x1EBC,
    JBLFlip4_JBLP = 0x1ED1,
    JBLPulse3_JBLP = 0x1ED2,
    JBLBoomBox_JBLP = 0x1EE7,
    HKOnyx = 0x1EE5,

};



typedef NS_ENUM(NSInteger, ButtonMode) {
    kPlayPauseMode = 0,
    kVoiceControlMode
};

typedef NS_ENUM(NSInteger, OTA_Status) {
    kOTA_FIleDownloadingStarted = 0,
    kOTA_FIleDownloading,
    kOTA_FIleDownloading_Completed,
    kOTA_FIleDownloadingFailed,
    kOTA_Upgrade_Started,
    kOTA_Uprading,
    kOTA_Done,
    kOTA_Failed
};

typedef NS_ENUM(NSInteger, UpgradeStates) {
    stateDownload       = 0,     //
    stateDownloadFail   = 1,
    stateDownloadDone   = 2,
    stateSendFile       = 3,    //
    stateSendFinished   = 4,     //
    stateSendFileReady  = 6,    //
    stateFinished       = 5,     //
    stateFailSend       = 7
};

typedef NS_ENUM(NSInteger, UpgradeType) {
    kUpgradeTypeBt = 0,
    kUpgradeTypeMCU,
    kUpgradeTypeBt_MCU
};

typedef NS_ENUM(NSInteger, EPerUpgradeStatus_JBLP){
    eUnUpgrade_JBLP         = 0,
    eUpgradeing_JBLP        = 1,
    eUpgraded_JBLP          = 2
    
};

typedef NS_ENUM(NSUInteger, ThemeType){
    WaveThemeType           = 0x1,
    JetThemeType            = 0x2,
    ExplosionThemeType      = 0x3,
    EqualizerThemeType      = 0x4,
    RaveThemeType           = 0x5,
    FountainThemeType       = 0x6,
    FireThemeType           = 0x7,
    CustomizeThemeType      = 0x8
};
typedef NS_ENUM(NSInteger, AudioSourceType){
    kAudioSourceTypeNone          = 0x0,
    kAudioSourceTypeA2DP          = 0x1,
    kAudioSourceTypeAUX           = 0x2,
    kAudioSourceTypeReceiver      = 0x3
};


typedef NS_ENUM(NSUInteger, VendorType) {
    Harman_Kardon = 0x0ecb,
    JBL= 0x57,
};

typedef NS_ENUM(NSInteger, DevIndex) {
    DevIndexHost = 0x00,
    DevIndexSecond = 0x01,
    DevIndexLink = 0x02,
};

#endif
