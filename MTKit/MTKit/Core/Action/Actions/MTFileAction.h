//
//  MTFileAction.h
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface MTFileAction : NSObject

+ (instancetype)sharedFileAction;

- (BOOL)isReachable;


/**
 上传图片 -- 默认压缩后上传
 
 @param urlString 上传图片地址
 @param imageKey 服务器接收图片的属性key
 @param parameters 接收的参数{key:value}
 @param imagePath 要上传的图片路径
 @param progress 上传进度
 @param result 回调, 如果error = nil,则请求成功，是否上传成功，判断object的数据。
 */
- (void)uploadImage2UrlString:(NSString *)urlString
              receiveImageKey:(NSString *)imageKey
                   parameters:(NSDictionary *)parameters
                    imagePath:(NSString *)imagePath
                     progress:(nullable void (^)(NSProgress * _Nonnull progress))progress
                       result:(void(^)(id object, NSError *error))result;

/**
 上传图片 -- 默认压缩后上传
 
 @param urlString 上传图片地址
 @param imageKey 服务器接收图片的属性key
 @param parameters 接收的参数{key:value}
 @param imagePath 要上传的图片路径
 @param isScale 是否压缩
 @param progress 上传进度
 @param result 回调, 如果error = nil,则请求成功，是否上传成功，判断object的数据。
 */
- (void)uploadImage2UrlString:(NSString *)urlString
              receiveImageKey:(NSString *)imageKey
                   parameters:(NSDictionary *)parameters
                    imagePath:(NSString *)imagePath
                      isScale:(BOOL)isScale
                     progress:(nullable void (^)(NSProgress * _Nonnull progress))progress
                       result:(void(^)(id object, NSError *error))result;

/**
 上传文件
 
 @param urlString 上传图片地址
 @param fileKey 服务器接收文件的属性key
 @param parameters 接收的参数{key:value}
 @param filePath 要上传的文件路径
 @param progress 上传进度
 @param result 回调, 如果error = nil,则请求成功，是否上传成功，判断object的数据。
 */
- (void)uploadFile2UrlUrlString:(NSString *)urlString
                 receiveFileKey:(NSString *)fileKey
                     parameters:(NSDictionary *)parameters
                       filePath:(NSString *)filePath
                       progress:(nullable void (^)(NSProgress * _Nonnull progress))progress
                         result:(void(^)(id object, NSError *error))result;


/**
 下载文件
 
 @param urlString 下载地址
 @param parameters 参数
 @param savedUrl 本地保存的地址 fg. NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
 @param progress 进度条
 @param result 回调
 */
- (NSURLSessionDownloadTask *)downloadFile2UrlString:(NSString *)urlString
                                          parameters:(NSDictionary *)parameters
                                            savedUrl:(NSURL *)savedUrl
                                            progress:(nullable void (^)(NSProgress * _Nonnull progress))progress result:(void(^)(NSURLResponse *response, NSURL *filePath, NSError *error))result;

/**
 暂停下载
 
 @param downloadTask 下载的任务
 */
- (void)pauseDownloadByTask:(NSURLSessionDownloadTask *)downloadTask;

/**
 断点续传
 
 @param downloadTask 下载的任务
 */
- (void)resumeDownloadByTask:(NSURLSessionDownloadTask *)downloadTask;

@end

NS_ASSUME_NONNULL_END
