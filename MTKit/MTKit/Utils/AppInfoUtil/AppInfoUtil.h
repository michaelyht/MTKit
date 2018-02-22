//
//  AppInfoUtil.h
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AddressBook/ABAddressBook.h"
#import "EventKit/EventKit.h"
#import "AVFoundation/AVFoundation.h"
#import "AssetsLibrary/AssetsLibrary.h"
#import <AFNetworking/AFHTTPSessionManager.h>

typedef void(^GrantBlock)(BOOL granted);

@interface AppInfoUtil : NSObject

///-------------------------------------
/// @name  app基本信息
///-------------------------------------

/**
 当前app名称
 */
+ (NSString *)appName;

/*
 当前app版本号 -- ---用户所见
 1.x.x
 */
+ (NSString *)appVersion;

/**
 用于更新的版本号
 
 @return 1、2、3整数
 */
+ (NSString *)appBundleVerson;

/**
 build 版本号
 */
+ (NSString *)appBuild;

/**
 apps 证书编号 (例如MacKun.az.com)
 */
+ (NSString *)appBundleID;

///--------------------------------------------------------------
/// @name  沙盒缓存大小
///--------------------------------------------------------------

/**
 *  沙盒的路径
 */
+ (NSString *)documentsDirectoryPath;
/**
 沙盒的内容大小 (例如5 MB)
 */
+ (NSString *)documentsFolderSizeAsString;

/**
 沙盒内的字节大小
 */
+ (int)documentsFolderSizeInBytes;
/**
 *  程序的大小 包括文件 缓冲 以及 下载
 *
 *  @return  所有文件大小
 */
+ (NSString *)applicationSize;


/////---------------------------------------------------------------
///// @name  app 隐私权限
/////---------------------------------------------------------------

/**
 定位权限是否开启
 */
+ (BOOL)isOpenAccessToLocationData;

/**
 通讯录访问权限是否开启
 */
+ (BOOL)isOpenAccessToAddressBook;

/**
 相机权限是否开启
 */
+ (BOOL)isOpenAccessToCalendar;

/**
 推送功能是否开启
 */
+ (BOOL)isOpenAccessToReminders;

/**
 相册权限是否开启
 */
+ (BOOL)isOpenAccessToPhotosLibrary;

/**
 *  麦克风开启
 */
+ (void)isOpenAccessToMicrophone:(GrantBlock)flag;

///-------------------------------------
/// @name  app 相关事件
///-------------------------------------

///**
// *  获取当前视图
// *
// */
+(UIViewController*)getCurrentViewConttoller;

/**
 拨打电话
 
 @param phone <#phone description#>
 */
+ (void)callWithPhone:(NSString *)phone;

/**
 *  跳到app的评论页
 *
 *  @param appId APP的id号
 */
+ (void)jumpToAppReviewPageWithAppId:(NSString *)appId;

/**
 检查是否有版本更新
 
 @param appID AppID
 @param success 回调
 */
+ (void)checkUpdateWithAppID:(NSString *)appID success:(void (^)(NSDictionary *resultDic , BOOL isNewVersion ,NSString * newVersion , NSString *currentVersion, NSError *error))success;

/**
 禁止iOS系统进入休眠状态
 */
+ (void)banDormancy;

/**
 恢复可休眠状态
 */
+ (void)recoverBanDormancy;

/**
 获取当前连接的WIFI SSID
 
 @return WIFI SSID
 */
+ (NSString *)getCurrentWifiSSID;

/**
 设置浅色状态栏
 字体为白色
 info.plist 中 设置 UIViewControllerBasedStatusBarAppearance 为 NO
 */
+ (void)setStatusBarLight;

/**
 设置默认状态栏
 字体为黑色
 info.plist 中 设置 UIViewControllerBasedStatusBarAppearance 为 NO
 */
+ (void)setStatusBarDefault;

/**
 跳转到App设置页面
 */
+ (void)jumpToAppSettingView;

@end
