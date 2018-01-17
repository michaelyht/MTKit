//
//  NSDate+MTExtInternetDate.h
//  MTKit
//
//  Created by Day Ling on 2018/1/10.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MTDateFormatHintNone,
    MTDateFormatHintRFC822,
    MTDateFormatHintRFC3339
} MTDateFormatHint;


@interface NSDate (MTExtInternetDate)

+ (NSDate *)mt_dateFromInternetDateTimeString:(NSString *)dateString
                                   formatHint:(MTDateFormatHint)hint;

+ (NSDate *)mt_dateFromRFC3339String:(NSString *)dateString;
+ (NSDate *)mt_dateFromRFC822String:(NSString *)dateString;

/**
 获取网络时间
 2s超时
 @return 如果超时，返回本地时间
 */
+ (NSDate *)mt_getNetworkDate;

/**
 获取网络时间
 
 @param timeout 超时时间
 @return 如果超时，返回本地时间
 */
+ (NSDate *)mt_getNetworkDateByTimeout:(NSInteger)timeout;

@end
