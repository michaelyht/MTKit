//
//  NSString+MtExt.h
//  MTKit
//
//  Created by Day Ling on 2018/1/10.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MTExt)

#pragma mark - Utilities

/**
 返回UUID  eg:A72E2B8C-40DA-4BFD-BADB-9CD98013FE5E
 
 @return UUID
 */
+ (NSString *)mt_stringByUUID;

/**
 *  @brief  清除html标签
 *
 *  @return 清除后的结果
 */
- (NSString *)mt_stringByTrimmingHTMLLabel;

/**
 *  @brief  清除js脚本
 *
 *  @return 清楚js后的结果
 */
- (NSString *)mt_stringByTrimmingScriptsAndStrippingHTML;

/**
 *  @brief  去除字符串两端空格
 *
 *  @return 去除字符串两端的字符串
 */
- (NSString *)mt_stringByTrimmingWhitespace;

/**
 去除字符串中所有的空格
 
 @return 新的字符串
 */
- (NSString *)mt_stringByTrimmingAllWhitespace;

/**
 *  @brief  去除字符串两端空格与换行符
 *
 *  @return 去除字符串两端空格与换行符
 */
- (NSString *)mt_stringByTrimmingWhitespaceAndNewlines;

/**
 nil, @"", @"  ", @"\n" will Returns NO; otherwise Returns YES.
 */
- (BOOL)mt_isNotEmpty;

/**
 获取拼音
 
 @return 字符串拼音
 */
- (NSString*)mt_pinYin;

/**
 *  获取拼音首字母
 *
 *  @return 获取拼音首字母
 */
- (NSString*)mt_initialOfPinyin;

/**
 *  将字符串转化为NSURL
 *
 *  @return  NSURL地址
 */
- (NSURL *)mt_toUrl;

/**
 *  将资源字符串转化为图片资源
 *
 *  @return  图片
 */
- (UIImage *)mt_toImage;

- (NSNumber *)mt_numberValue;

#pragma mark - Encode and decode
///=============================================================================
/// @name Encode and decode
///=============================================================================

/**
 *  字符串加密为base64
 *
 *  @return 返回String
 */
- (nullable NSString *)mt_base64EncodedString;

/**
 *  解密base64字符串
 *
 *  @return 返回解析后的字符串
 */
- (nullable NSString *)mt_stringFromBase64EncodedString;

/**
 URL encode a string in utf-8.
 @return the encoded string.
 */
- (NSString *)mt_tringByURLEncode;

/**
 URL decode a string in utf-8.
 @return the decoded string.
 */
- (NSString *)mt_stringByURLDecode;

/**
 Escape commmon HTML to Entity.
 Example: "a < b" will be escape to "a&lt;b".
 */
- (NSString *)mt_stringByEscapingHTML;

/**
 格式化电话号码显示
 
 @return fg. 133 3333 3333
 */
- (NSString *)mt_formattoPhoneNumber;

/**
 格式化银行卡显示
 
 @return fg. xxxx xxxx xxxx xxx
 */
- (NSString *)mt_formattoCardNumber;


@end

NS_ASSUME_NONNULL_END

