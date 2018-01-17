//
//  NSNumber+MTExt.h
//  MTKit
//
//  Created by Day Ling on 2018/1/10.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (MTExt)

+ (NSNumber *)mt_numberWithString:(NSString *)string;

#pragma mark - util

/* 展示 */

/**
 浮点数截取小数点后几位，四舍五入
 
 @param digit 小数点后尾数
 @return 截取后的string
 */
- (NSString*)mt_toDisplayNumberWithDigit:(NSInteger)digit;


/**
 *  @brief  四舍五入
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber *)mt_numberRoundByDigit:(NSUInteger)digit;

/**
 *  @brief  取上整
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber*)mt_numberCeilByDigit:(NSUInteger)digit;

/**
 *  @brief  取下整
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber*)mt_numberFloorByDigit:(NSUInteger)digit;

@end

NS_ASSUME_NONNULL_END
