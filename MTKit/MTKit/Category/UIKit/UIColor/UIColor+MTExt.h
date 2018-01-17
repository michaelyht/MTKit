//
//  UIColor+MTExt.h
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef mt_UIColorHex
#define mt_UIColorHex(_hex_)   [UIColor mt_colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (MTExt)

/**
 *   用HexString 生成 UIColor
 *
 *  @param hexString   #RGB  #ARGB   #RRGGBB  #AARRGGBB 或者不带#
 */
+ (UIColor *)mt_colorWithHexString:(NSString *)hexString;

/**
 *   用HexString 生成 UIColor
 *
 *  @param hexString   #RGB  #ARGB   #RRGGBB  #AARRGGBB 或者不带#
 *  @param alpha 透明度
 */
+ (UIColor *)mt_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
/**
 *  当前UIColor用的HexString
 */
- (NSString *)mt_hexString;
/**
 *  当前UIColor用的RGB(255,255,255,1.0) 用纯数字
 */
+ (UIColor *)mt_colorWithWholeRed:(CGFloat)red
                            green:(CGFloat)green
                             blue:(CGFloat)blue
                            alpha:(CGFloat)alpha;


/**
 *  @brief  随机颜色
 *
 *  @return UIColor
 */
+ (UIColor *)mt_randomColor;

/**
 *  @brief  渐变颜色
 *
 *  @param c1     开始颜色
 *  @param c2     结束颜色
 *  @param height 渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor*)mt_gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height;

@end

NS_ASSUME_NONNULL_END
