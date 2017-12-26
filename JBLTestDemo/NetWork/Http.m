//
//  Http.m
//  JBLTestDemo
//
//  Created by mickey on 2017/12/26.
//  Copyright © 2017年 Aaron Hou. All rights reserved.
//

#import "Http.h"
#import <Foundation/Foundation.h>

@implementation Http
{
    DownLoadProgressHandler _progress;
}


- (NSURLRequest *)firstRequestForHttps
{
    NSString *requestStr = @"http://ds.zx.test.tcljd.net:8500/";
    NSURL *url = [NSURL URLWithString:requestStr];
    NSMutableURLRequest *requset = [NSMutableURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [_defaultSession dataTaskWithRequest:requset];
    [task resume];
    
    return nil;
}

- (NSURLRequest *)getRquestForServerConnectInfo:(NSURL *)url progress:(DownLoadProgressHandler)progress
{
    [[_defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
          if (nil != error)
          {
              NSLog(@"Got response %@ with error %@.\n", response, error);
          }
          else
          {
              
          }
      }] resume];
    return nil;
}
- (NSURLRequest *)getMediaFileFromURL:(NSString *)urlString progress:(DownLoadProgressHandler)progress
{
    if (_downloadTask == nil)
    {
        //创建沙盒文件路径
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
                          stringByAppendingPathComponent:@"QQ_V5.4.0.dmg"];
        NSInteger currentLenth = [self fileLengthForPath:path];
        if (currentLenth > 0)
        {
            _currentLength = currentLenth;
        }
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        //设置Http请求头中的Range
        NSString *range = [NSString stringWithFormat:@"byte=%zd-", _currentLength];
        [request setValue:range forHTTPHeaderField:@"Range"];
        _downloadTask = [_defaultSession dataTaskWithRequest:request];
        _progress = progress;
        [_downloadTask resume];
        
        
    }
    
    return nil;
}

- (NSInteger)fileLengthForPath:(NSString *)path
{
    NSInteger fileLength = 0;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if ([fileManager fileExistsAtPath:path])
    {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict)
        {
            fileLength = [fileDict fileSize];
        }
    }
    return fileLength;
}


- (NSURLSessionDataTask *)downloadTask:(NSString *)urlString
{
    if (_downloadTask == nil)
    {
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        //设置Http请求头中的Range
        NSString *range = [NSString stringWithFormat:@"byte=%zd-", _currentLength];
        [request setValue:range forHTTPHeaderField:@"Range"];
        
        _downloadTask = [_defaultSession dataTaskWithRequest:request];
    }
    return _downloadTask;
}

- (NSURLRequest *)postRequsetForURL:(NSURL *)url FileURL:(NSURL *)fileURL
{
    return nil;
}
//上传
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    CGFloat progress = (CGFloat) totalBytesSent / totalBytesExpectedToSend;
    NSString *stringFloat = [NSString stringWithFormat:@"%f",progress];
    
    _UpLoadProgressHandler(stringFloat);
    
}
//下载
- (void)URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    CGFloat progress = (CGFloat) totalBytesWritten / totalBytesExpectedToWrite;
    NSString *stringFloat = [NSString stringWithFormat:@"%f",progress];
    NSLog(@"%@\n",stringFloat);
    
}
//接收到响应的时候 创建一个空的沙盒文件
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(nonnull NSURLResponse *)response completionHandler:(nonnull void (^)(NSURLSessionResponseDisposition))completionHandler
{
    //获得下载文件的总长度：请求下载的文件长度 + 当前已经下载的文件长度
    _fileLength = response.expectedContentLength + _currentLength;
    
    //沙盒文件路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
                      stringByAppendingPathComponent:@"QQ_V5.4.0.dmg"];
    NSLog(@"File downloaded to: %@", path);
    //创建空的文件到沙盒中
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path])
    {
        //如果没有下载文件
        [fileManager createFileAtPath:path contents:nil attributes:nil];
    }
    //创建文件句柄
    _fileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
    
    //允许处理服务器的响应，才会继续接收到服务器的返回数据
    completionHandler(NSURLSessionResponseAllow);
}


//接收具体数据：把数据写入沙盒文件中
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    //NSString * strData=[[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    //NSLog(@"DATA:\n%@\nEND DATA\n",strData);
    
    //指定数据的写入位置-- 文件内容的最后面
    [_fileHandle seekToEndOfFile];
    
    //向沙盒写入数据
    [_fileHandle writeData:data];
    
    //拼接文件总长度
    _currentLength += data.length;
    
    //NSLog(@"%ld", _currentLength);
    CGFloat curprogress = 1.0 * _currentLength/_fileLength;
    
    if (_progress) {
        _progress(curprogress);
    }
    
}

//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error


- (Http *)initHttp
{
    self = [super init];
    //创建配置
    _defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //创建缓存路径
    //#if TAGET_OS_IPHONE
    NSString *cachePath = @"/MyCacheDirectory";
    NSArray *myPathList = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *myPath = [myPathList objectAtIndex:0];
    NSString *bundleIndentifier = [[NSBundle mainBundle] bundleIdentifier];
    NSString *fullCachePath = [[myPath stringByAppendingPathComponent:bundleIndentifier] stringByAppendingPathComponent:cachePath];
    //#else
    //#endif
    
    //创建缓存
    NSURLCache *myCache = [[NSURLCache alloc] initWithMemoryCapacity:16386 diskCapacity:268435456 diskPath:fullCachePath];
    _defaultConfiguration.URLCache = myCache;
    _defaultConfiguration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
    
    //为每个请求创建配置
    if (_defaultSession == nil)
    {
        _defaultSession = [NSURLSession sessionWithConfiguration:_defaultConfiguration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    
    _recData = [[NSMutableData alloc]initWithCapacity:4096];
    
    return self;
}


@end
