//
//  Http.h
//  JBLTestDemo
//
//  Created by mickey on 2017/12/26.
//  Copyright © 2017年 Aaron Hou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Http : NSObject<NSURLSessionTaskDelegate,NSURLSessionDataDelegate,NSURLConnectionDelegate,NSURLSessionDelegate,NSURLConnectionDelegate>
{
    NSURLSession *_defaultSession;
    NSURLSessionConfiguration *_defaultConfiguration;
    dispatch_queue_t _eventHttpQueue;
    
}
typedef void(^DownLoadProgressHandler)(CGFloat proress);
- (NSURLRequest *)firstRequestForHttps;
- (NSURLRequest *)getRquestForServerConnectInfo:(NSURL *)url progress:(DownLoadProgressHandler)progress;
- (NSURLRequest *)getMediaFileFromURL:(NSString *)url progress:(DownLoadProgressHandler)progress;
- (NSURLSessionDataTask *)downloadTask:(NSString *)urlString;

- (Http *)initHttp;
@property (atomic, strong)NSMutableData *recData;

@property (nonatomic, strong) NSURLSessionDataTask *downloadTask;
//文件总长度
@property (nonatomic, assign) NSInteger fileLength;
//当前下载长度
@property (nonatomic, assign) NSInteger currentLength;
//文件句柄对象
@property (nonatomic, strong) NSFileHandle *fileHandle;

//@property (nonatomic,)


@property(nonatomic, copy)  void(^UpLoadProgressHandler)(NSString* progress);
@property(nonatomic, copy)  void(^DownloadProgressHandler)(CGFloat proress);
//DownLoadProgressHandler downloadhandler;


@end
