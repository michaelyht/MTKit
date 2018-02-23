//
//  AFURLSessionManager+MTDownload.m
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "AFURLSessionManager+MTDownload.h"

@implementation AFURLSessionManager (MTDownload)

- (NSURLSessionDownloadTask *)mt_downloadTaskWithRequest:(NSURLRequest *)request
                                                progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgressBlock
                                             destination:(nullable NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                       completionHandler:(nullable void (^)(NSURLResponse *response, NSURL * _Nullable filePath, NSURLSessionDownloadTask *downloadTask, NSError * _Nullable error))completionHandler {
    __block NSURLSessionDownloadTask *downloadTask = nil;
    downloadTask = [self downloadTaskWithRequest:request progress:downloadProgressBlock destination:destination completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        completionHandler(response, filePath, downloadTask, error);
    }];
    return downloadTask;
}
@end
