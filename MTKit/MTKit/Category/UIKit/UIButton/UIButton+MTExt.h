//
//  UIButton+MTExt.h
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TouchUpInsideEvent)(UIButton *button);

@interface UIButton (MTExt)

@property (nonatomic, strong) TouchUpInsideEvent touchUpInsideEvent;


/**
 创建Button
 
 @param frame frame
 @param title 标题 - Normal
 @param touchUpInsideEvent 点击事件
 @return 创建好的Button
 */
+ (UIButton *)mt_createWithFrame:(CGRect)frame
                           title:(NSString *)title
              touchUpInsideEvent:(TouchUpInsideEvent)touchUpInsideEvent;

/**
 创建button
 
 @param frame frame
 @param title 标题 - Normal
 @param image 图片
 @param touchUpInsideEvent 点击事件
 @return 创建好的Button
 */
+ (UIButton *)mt_createWithFrame:(CGRect)frame
                           title:(NSString *)title
                           image:(nullable UIImage *)image
              touchUpInsideEvent:(TouchUpInsideEvent)touchUpInsideEvent;

/**
 创建button
 
 @param frame frame
 @param title 标题 - Normal
 @param image 图片
 @param touchUpInsideEvent 点击事件
 @return 创建好的Button
 */
+ (UIButton *)mt_createWithFrame:(CGRect)frame
                           title:(NSString *)title
                           image:(nullable UIImage *)image
                             tag:(NSInteger)tag
              touchUpInsideEvent:(TouchUpInsideEvent)touchUpInsideEvent;

/**
 *  设置高亮图片
 *
 *  @param image 高亮图片
 */
- (void)mt_setHighlightedImage:(UIImage *)image;

/**
 *  返回高亮图片
 *
 *  @return 高亮图片
 */
- (UIImage *)mt_highlightedImage;

/**
 *  设置普通图片
 *
 *  @param image 普通图片
 */
- (void)mt_setNormalImage:(UIImage *)image;

/**
 *  返回普通图片
 *
 *  @return 普通图片
 */
- (UIImage *)mt_normalImage;

/**
 *  设置选中的图片
 *
 *  @param image 选中的图片
 */
- (void)mt_setSelectedImage:(UIImage *)image;

/**
 *  返回选中的图片
 *
 *  @return 选中的图片
 */
- (UIImage *)mt_selectedImage;


/**
 *  @brief  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)mt_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

/**
 设置下划线,颜色跟按钮颜色一致
 */
- (void)mt_setUnderLine;

#pragma mark - 点击热区

/**
 *  @brief  设置按钮额外热区
 */
@property (nonatomic, assign) UIEdgeInsets mt_touchAreaInsets;

@end

NS_ASSUME_NONNULL_END
