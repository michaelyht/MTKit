//
//  MTFileAction.m
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "MTFileAction.h"
#import "MTAPIClient.h"
#import "MTConstants.h"
#import "AFURLSessionManager+MTDownload.h"
#import "MTProgressHUD.h"
#import "MTAlertUtil.h"

#define ORIGINAL_MAX_WIDTH 720

@interface MTFileAction ()

@property (nonatomic, strong) MTAPIClient *apiClient;

@property (nonatomic, strong) MTConstants *constants;

@property (nonatomic, strong) NSMutableArray<NSURLSessionDownloadTask *> *downloadingTaskArray;

@end

@implementation MTFileAction

+ (instancetype)sharedFileAction {
    static MTFileAction *_sharedAction = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedAction = [[MTFileAction alloc] init];
    });
    return _sharedAction;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _apiClient = [MTAPIClient sharedClient];
        [self netWorkingListener];
    }
    return self;
}

- (BOOL)isReachable {
    return _apiClient.isReachable;
}


#pragma mark - upload image
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
                       result:(void(^)(id object, NSError *error))result {
    [self uploadImage2UrlString:urlString receiveImageKey:imageKey parameters:parameters imagePath:imagePath isScale:YES progress:progress result:result];
}

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
                       result:(void(^)(id object, NSError *error))result {
    _apiClient.requestSerializer = [AFHTTPRequestSerializer serializer];
    if (![self judgeNetworkingNotReachableForTips]) {
        return;
    }
    NSData *imageData = [[NSData alloc] initWithContentsOfFile:imagePath];
    if (imageData == nil) {
        [MTProgressHUD showInfoTips:@"图片路径错误，请检查路径"];
        return;
    }
    NSString *imageType = [self typeForImageData:imageData];
    if (imageType == nil) {
        [MTProgressHUD showInfoTips:@"图片信息错误，请上传PNG,JPEG,GIF等图片"];
        return;
    }
    NSString *fileName = [self fileNameForImageType:imageType];
    UIImage *image = [UIImage imageWithData:imageData];
    if (isScale) {
        image = [self imageByScalingToMaxSize:image];
    }
    [_apiClient POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *uploadData = nil;
        if ([imageType hasSuffix:@"jpeg"]) {
            uploadData = UIImageJPEGRepresentation(image, 0.9);
        } else {
            uploadData = UIImagePNGRepresentation(image);
        }
        [formData appendPartWithFileData:uploadData name:imageKey fileName:fileName mimeType:imageType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (result) {
            result(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (result) {
            result(nil, error);
        }
    }];
}

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
                         result:(void(^)(id object, NSError *error))result {
    if (![self judgeNetworkingNotReachableForTips]) {
        return;
    }
    _apiClient.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *fileName = [self fileNameForFilePath:filePath];
    [_apiClient POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:fileKey fileName:fileName mimeType:@"application/octet-stream" error:nil];
    } progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (result) {
            result(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (result) {
            result(nil, error);
        }
    }];
}

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
                                            progress:(nullable void (^)(NSProgress * _Nonnull progress))progress result:(void(^)(NSURLResponse *response, NSURL *filePath, NSError *error))result {
    NSURL *downloadUrl = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:downloadUrl];
    if (!_apiClient.isReachable) {
        [MTProgressHUD showErrorTips:@"网络未连接,请检查网络"];
        return nil;
    }
    //通过afnetworking的分类，返回downloadTask;
    NSURLSessionDownloadTask *downloadTask = [_apiClient mt_downloadTaskWithRequest:request progress:progress destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *destinationUrl = [savedUrl URLByAppendingPathComponent:[response suggestedFilename]];
        return destinationUrl;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSURLSessionDownloadTask * _Nonnull downloadTask, NSError * _Nullable error) {
        if (downloadTask.state == NSURLSessionTaskStateCompleted) {
            [self.downloadingTaskArray removeObject:downloadTask];
        }
        [MTProgressHUD hideProgressHUD];
        if (result) {
            result(response, filePath, error);
        }
    }];
    [self.downloadingTaskArray addObject:downloadTask];
    if (_apiClient.netWorkStatus == MTReachableViaWWAN) {
        [MTProgressHUD hideProgressHUD];
        [self showNetworkingWANDownloadTipByClick:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [MTProgressHUD showFlatLoading];
                [downloadTask resume];
            }
        }];
    }
    return downloadTask;
}

/**
 暂停下载
 
 @param downloadTask 下载的任务
 */
- (void)pauseDownloadByTask:(NSURLSessionDownloadTask *)downloadTask {
    if (downloadTask.state == NSURLSessionTaskStateRunning) {
        [downloadTask suspend];
    }
}

/**
 断点续传
 
 @param downloadTask 下载的任务
 */
- (void)resumeDownloadByTask:(NSURLSessionDownloadTask *)downloadTask {
    if (downloadTask.state == NSURLSessionTaskStateSuspended) {
        [downloadTask resume];
    }
}

#pragma mark - private Image Scale
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    btWidth = ORIGINAL_MAX_WIDTH;
    btHeight = (ORIGINAL_MAX_WIDTH / sourceImage.size.width) * sourceImage.size.height;
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - 处理网络状态变化未完成的下载任务

/**
 网络变成无网络
 */
- (void)networkingChangedNotReachable {
    if (_downloadingTaskArray.count > 0) {
        [self suspendAllDownloadTask];
        [MTAlertUtil showAlertWithTitle:@"下载未完成，请检查网络连接" message:nil cancleButtonTitle:@"确定" OtherButtonsArray:nil showInController:nil clickAtIndex:^(NSInteger buttonIndex) {
            
        }];
    }
}

/**
 网络变为3,4G.
 */
- (void)networkingChangedReachableViaWWAN {
    if (_downloadingTaskArray.count > 0) {
        [self suspendAllDownloadTask];
        [self showNetworkingWANDownloadTipByClick:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [self resumeAllDownloadTask];
            }
        }];
    }
}

/**
 网络变为wifi
 */
- (void)networkingChangedReachableViaWIFI {
    if (_downloadingTaskArray.count > 0) {
        [self resumeAllDownloadTask];
    }
}

/**
 挂起下载任务
 */
- (void)suspendAllDownloadTask {
    [self.downloadingTaskArray enumerateObjectsUsingBlock:^(NSURLSessionDownloadTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self pauseDownloadByTask:obj];
    }];
}

- (void)resumeAllDownloadTask {
    [self.downloadingTaskArray enumerateObjectsUsingBlock:^(NSURLSessionDownloadTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self resumeDownloadByTask:obj];
    }];
}

#pragma mark - 网络监听
- (void)netWorkingListener {
    //网络监控句柄
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //要监控网络连接状态，必须要先调用单例的startMonitoring方法
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: //未知
                break;
            case AFNetworkReachabilityStatusNotReachable: //未连接
            {
                [self networkingChangedNotReachable];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: //3G
            {
                [self networkingChangedReachableViaWWAN];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: //WIFI
            {
                [self networkingChangedReachableViaWIFI];
            }
                break;
            default:
                break;
        }
    }];
}

#pragma mark - getters setters
- (NSMutableArray *)downloadingTaskArray {
    if (_downloadingTaskArray == nil) {
        _downloadingTaskArray = [NSMutableArray array];
    }
    return _downloadingTaskArray;
}

#pragma mark - image type
- (NSString *)typeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
    
}

- (NSString *)fileNameForImageType:(NSString *)imageType {
    NSString *fileName = @"";
    if ([imageType hasSuffix:@"jpeg"]) {
        fileName = @"jpg";
    } else if ([imageType hasSuffix:@"gif"]) {
        fileName = @"gif";
    } else if ([imageType hasSuffix:@"tiff"]) {
        fileName = @"tiff";
    } else {
        fileName = @"png";
    }
    return [NSString stringWithFormat:@"fileName.%@", fileName];
}

- (NSString *)fileNameForFilePath:(NSString *)filePath {
    if (filePath == nil) {
        return nil;
    }
    NSArray *nameArray = [filePath componentsSeparatedByString:@"/"];
    return nameArray.lastObject;
}

#pragma mark - private
- (void)showNetworkingWANDownloadTipByClick:(void(^)(NSInteger buttonIndex)) click {
    [MTAlertUtil showAlertWithTitle:@"下载未完成，是否在移动数据下载?" message:nil cancleButtonTitle:@"暂停下载" OtherButtonsArray:@[@"土豪请继续"] showInController:nil clickAtIndex:^(NSInteger buttonIndex) {
        click(buttonIndex);
    }];
}

/**
 判断是否无网络，无网络提示
 */
- (BOOL)judgeNetworkingNotReachableForTips {
    if (!_apiClient.isReachable) {
        [MTProgressHUD showErrorTips:@"网络未连接,请检查网络"];
        return NO;
    }
    return YES;
}

@end
