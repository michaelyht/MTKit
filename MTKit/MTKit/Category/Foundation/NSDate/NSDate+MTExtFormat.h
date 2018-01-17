//
//  NSDate+MTExtFormat.h
//  MTKit
//
//  Created by Day Ling on 2018/1/9.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSDate (MTExtFormat)

/**
 * 根据日期返回字符串 format源字符串格式
 */
+ (NSString *)mt_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)mt_stringWithFormat:(NSString *)format;
+ (NSDate *)mt_dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)mt_ymdFormat;
+ (NSString *)mt_ymdFormat;
- (NSString *)mt_hmsFormat;
+ (NSString *)mt_hmsFormat;
- (NSString *)mt_ymdHmsFormat;
+ (NSString *)mt_ymdHmsFormat;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)mt_stringWithTimeInfo;
+ (NSString *)mt_stringWithTimeInfoByDate:(NSDate *)date;
+ (NSString *)mt_stringWithTimeInfoByDateString:(NSString *)dateString;


/**
 days 之前显示 x分钟前/x小时前/昨天/x天前, 之后显示成日期
 
 @param days 几天的时间
 @return days 之前显示 x分钟前/x小时前/昨天/x天前, 之后显示成日期
 */
- (NSString *)mt_stringWithTimeInfoByAfterDaysOfInteger:(NSInteger)days;

@end

NS_ASSUME_NONNULL_END
