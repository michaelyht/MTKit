//
//  MTQRCodeUtil.h
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>

@interface MTQRCodeUtil : NSObject

/**
 生成普通的二维码
 
 @param dataString 二维码内容
 @param imageViewWidth 宽度
 @return 二维码图片
 */
+ (UIImage *)generateNormalQRCodeOfString:(NSString *)dataString imageViewWidth:(CGFloat)imageViewWidth;

/**
 生成一张带有logo的二维码
 
 @param dataString 二维码数据
 @param logoImageName logo图片名称
 @param scale 0-1相对于父视图的比例, 0，不显示，1，代表与父视图大小相同
 @return 二维码图片
 */
+ (UIImage *)generateWithLogoQRCodeOfString:(NSString *)dataString logoImageName:(NSString *)logoImageName scale:(CGFloat)scale;

/**
 生成彩色的二维码
 
 @param dataString 二维码内容
 @param backgroundColor 背景色
 @param mainColor 主色
 @return 二维码图片
 */
+ (UIImage *)enerateWithColorQRCodeOfString:(NSString *)dataString backgroundColor:(CIColor *)backgroundColor mainColor:(CIColor *)mainColor;

@end
