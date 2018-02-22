//
//  AFURLSessionManager+MTDownload.h
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN


@interface AFURLSessionManager (MTDownload)

- (NSURLSessionDownloadTask *)mt_downloadTaskWithRequest:(NSURLRequest *)request
                                                progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgressBlock
                                             destination:(nullable NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                       completionHandler:(nullable void (^)(NSURLResponse *response, NSURL * _Nullable filePath, NSURLSessionDownloadTask *downloadTask, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
