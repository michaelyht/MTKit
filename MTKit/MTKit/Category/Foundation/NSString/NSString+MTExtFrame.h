//
//  NSString+MTExtFrame.h
//  MTKit
//
//  Created by Day Ling on 2018/1/10.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (MTExtFrame)

/**
 *  @brief 根据字数的不同,返回UILabel中的text文字需要占用多少Size
 *  @param size 约束的尺寸
 *  @param font 文本字体
 *  @return 文本的实际尺寸
 */
- (CGSize)mt_sizeWithFont:(UIFont *)font size:(CGSize)size;

/**
 *  @brief  根据文本字数/文本宽度约束/文本字体 求得text的Size
 *  @param width 宽度约束
 *  @param font  文本字体
 *  @return 文本的实际高度
 */
- (CGFloat)mt_heightWithFont:(UIFont *)font width:(CGFloat)width;

/**
 *  @brief  根据文本字数/文本宽度约束/文本字体 求得text的Size
 *  @param font  文本字体
 *  @return 文本的实际长度
 */
- (CGFloat)mt_widthWithFont:(UIFont *)font;

/**
 *  @brief  根据文本字数/文本宽度约束/文本字体 求得text的Size
 *  @param height 宽度约束
 *  @param font  文本字体
 *  @return 文本的实际长度
 */
- (CGFloat)mt_widthWithFont:(UIFont *)font height:(CGFloat)height;

@end
