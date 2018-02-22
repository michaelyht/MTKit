//
//  MTProgressHUD.h
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//默认取消时间
#define MTPGS_DISS_SECOND    2

@interface MTProgressHUD : NSObject

/**
 信息提示 -- 深色背景
 
 @param tips 信息
 */
+ (void)showInfoTips:(NSString *)tips;

/**
 信息提示 -- 无图标
 
 @param tips 信息
 */
+ (void)showBlankInfoTips:(NSString *)tips;

/**
 信息提示 -- 浅色背景
 
 @param tips 信息
 */
+ (void)showLightInfoTips:(NSString *)tips;

/**
 信息提示 -- 深色背景
 
 @param tips 提示信息
 @param delay 延迟时间
 */
+ (void)showInfoTips:(NSString *)tips delay:(float)delay;

/**
 信息提示 -- 深色背景
 
 @param tips 提示信息
 @param delay 延迟时间
 @param image 提示图片，nil则为默认图片
 */
+ (void)showInfoTips:(NSString *)tips delay:(float)delay infoImage:(UIImage *)image;

/**
 信息提示 -- 浅色背景
 
 @param tips 提示信息
 @param delay 延迟时间
 @param image 提示图片，nil则为默认图片
 */
+ (void)showLightInfoTips:(NSString *)tips delay:(float)delay infoImage:(UIImage *)image;

/**
 成功提示, 默认2秒取消
 
 @param tips 提示语
 */
+ (void)showSuccessTips:(NSString *)tips;

/**
 成功提示
 
 @param tips 提示语
 @param delay 延迟几秒取消
 */
+ (void)showSuccessTips:(NSString *)tips withDismissDelay:(float)delay;

/**
 错误提示,默认2秒取消
 
 @param tips 提示语
 */
+ (void)showErrorTips:(NSString *)tips;

/**
 错误提示
 
 @param tips 提示语
 @param delay 延迟几秒取消
 */
+ (void)showErrorTips:(NSString *)tips withDismissDelay:(float)delay;

/**
 等待提示框,转圆圈,无提示语
 */
+ (void)showFlatLoading;

/**
 等待提示框,转圆圈
 
 @param tips 提示语
 */
+ (void)showFlatLoadingWithTips:(NSString *)tips;

/**
 等待框,iOS 菊花转, 无提示语
 
 */
+ (void)showNativeLoading;

/**
 等待框,iOS 菊花转
 
 @param tips 提示语
 */
+ (void)showNativeLoadingWithTips:(NSString *)tips;

/**
 取消提示框
 */
+ (void)hideProgressHUD;

@end
