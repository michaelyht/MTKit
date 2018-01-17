//
//  UIImageView+MTExt.h
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (MTExt)

/**
 *  @brief  根据bundle中的图片名创建imageview
 *
 *  @param imageName bundle中的图片名
 *
 *  @return imageview
 */
+ (id)mt_imageViewWithImageNamed:(NSString*)imageName;

/**
 根据frame创建imageview
 
 @param imageName 图片名称
 @param frame frame
 @return imageview
 */
+ (id)mt_imageViewWithStretchableImage:(NSString*)imageName Frame:(CGRect)frame;

/**
 *  @brief  创建imageview动画
 *
 *  @param imageArray 图片名称数组
 *  @param duration   动画时间
 *
 *  @return imageview
 */
+ (id)mt_imageViewWithImageArray:(NSArray*)imageArray duration:(NSTimeInterval)duration;

#pragma mark - 画水印

/**
 图片水印
 
 @param image 图片对象
 @param mark 水印腿片
 @param rect 区域
 */
- (void)mt_setImage:(UIImage *)image
      withWaterMark:(UIImage *)mark
             inRect:(CGRect)rect;

/**
 文字水印
 
 @param image 图片对象
 @param markString mark_text
 @param rect 区域
 @param color mark_color
 @param font mark_font
 */
- (void)mt_setImage:(UIImage *)image
withStringWaterMark:(NSString *)markString
             inRect:(CGRect)rect
              color:(UIColor *)color
               font:(UIFont *)font;
- (void)mt_setImage:(UIImage *)image
withStringWaterMark:(NSString *)markString
            atPoint:(CGPoint)point
              color:(UIColor *)color
               font:(UIFont *)font;

#pragma mark - 倒影
/**
 *  @brief  倒影
 */
- (void)mt_reflect;

@end

NS_ASSUME_NONNULL_END
