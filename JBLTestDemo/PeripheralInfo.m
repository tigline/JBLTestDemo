//
//  PeripheralInfo.m
//  JBLTestDemo
//
//  Created by Aaron Hou on 26/12/2017.
//  Copyright © 2017 Aaron Hou. All rights reserved.
//

#import "PeripheralInfo.h"
#import "Constants_JBLP.h"
#import "XMLReader.h"


@implementation PeripheralInfo


- (UpgradeType)setUpgradeFrom:(NSDictionary *)upgrdaeInfo{
    return kUpgradeTypeBt_MCU;
}


- (NSURLSession *)getDefultSessionForurl:(NSURL *)url{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    return defaultSession;
}

/**
 To check latest update on server
 
 @param updateInfo callback for available update info
 */
- (void)checkUpdate:(void (^)(NSDictionary *updateInfoDict, NSError *error))updateInfo{
    
    NSURL *url = [NSURL URLWithString:_otaUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    __weak typeof (self) weakSelf = self;
    __block NSURLSession *session = [self getDefultSessionForurl:url];
    
    NSURLSessionDataTask * dataTask = [[weakSelf getDefultSessionForurl:url] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                       {
                                           if(error){
                                               updateInfo(nil, error);
                                               
                                           }else{
                                               NSString *xmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                               
                                               NSError *error = nil;
                                               NSDictionary *whatNewDict = [XMLReader dictionaryForXMLString:xmlString error:&error];
                                               
                                               
                                               weakSelf.upgradeType = [weakSelf setUpgradeFrom:whatNewDict];
                                               
                                               if(error){
                                                   updateInfo(nil, error);
                                               }else{
                                                   
                                                   NSDictionary *releaseDescriptorsDict = [whatNewDict objectForKey:RELEASE_DESCRIPTOR];
                                                   NSDictionary *releaseDict = [releaseDescriptorsDict objectForKey:RELEASE];
                                                   
                                                   NSString *firmwareVersion = [releaseDict objectForKey:VERSION];
                                                   firmwareVersion = [firmwareVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
                                                   
                                                   if(weakSelf.deviceInfo.firmwareVersion && firmwareVersion){
                                                       if(([firmwareVersion integerValue]/10) > ([weakSelf.deviceInfo.completefirmwareVersion integerValue]/10)){
                                                           updateInfo(whatNewDict, error);
                                                       }else{
                                                           updateInfo(nil, nil);
                                                       }
                                                   }
                                                   
                                               }
                                           }
                                           [session finishTasksAndInvalidate];
                                       }];
    [dataTask resume];
}


@end
