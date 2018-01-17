//
//  NSDate+MTExtFormat.m
//  MTKit
//
//  Created by Day Ling on 2018/1/9.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "NSDate+MTExtFormat.h"
#import "NSDate+MTExt.h"

@implementation NSDate (MTExtFormat)

/**
 * 根据日期返回字符串 format源字符串格式
 */
+ (NSString *)mt_stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date mt_stringWithFormat:format];
}

- (NSString *)mt_stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}

+ (NSDate *)mt_dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    
    NSDate *date = [inputFormatter dateFromString:string];
    
    return date;
}

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)mt_ymdFormat {
    return [NSDate mt_ymdFormat];
}
+ (NSString *)mt_ymdFormat {
    return @"yyyy-MM-dd";
}
- (NSString *)mt_hmsFormat {
    return [NSDate mt_hmsFormat];
}
+ (NSString *)mt_hmsFormat {
    return @"HH:mm:ss";
}
- (NSString *)mt_ymdHmsFormat {
    return [NSDate mt_ymdHmsFormat];
}
+ (NSString *)mt_ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self mt_ymdFormat], [self mt_hmsFormat]];
}

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)mt_stringWithTimeInfo {
    return [NSDate mt_stringWithTimeInfoByDate:self];
}
+ (NSString *)mt_stringWithTimeInfoByDate:(NSDate *)date {
    return [self mt_stringWithTimeInfoByDateString:[self mt_stringWithDate:date format:[self mt_ymdHmsFormat]]];
}
+ (NSString *)mt_stringWithTimeInfoByDateString:(NSString *)dateString {
    NSDate *date = [self mt_dateWithString:dateString format:[self mt_ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate month] - [date month]);
    int year = (int)([curDate year] - [date year]);
    int day = (int)([curDate day] - [date day]);
    
    NSTimeInterval remtime = 1.0;
    if (time < 3600) { // 小于一小时
        remtime = time / 60;
        remtime = remtime <= 0.0 ? 1.0 : remtime;
        return [NSString stringWithFormat:@"%.0f分钟前", remtime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        remtime = time / 3600;
        remtime = remtime <= 0.0 ? 1.0 : remtime;
        return [NSString stringWithFormat:@"%.0f小时前", remtime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate month] == 1 && [date month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self daysInMonth:date month:[date month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate day] + (totalDays - (int)[date day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate month];
            int preMonth = (int)[date month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}


/**
 days 之前显示 x分钟前/x小时前/昨天/x天前, 之后显示成日期
 
 @param days 几天的时间
 @return days 之前显示 x分钟前/x小时前/昨天/x天前, 之后显示成日期
 */
- (NSString *)mt_stringWithTimeInfoByAfterDaysOfInteger:(NSInteger)days {
    NSInteger daysAgo = [self daysAgo];
    if (daysAgo > days) {
        return [self mt_ymdHmsFormat];
    }
    return [self mt_stringWithTimeInfo];
}


#pragma mark - private
+ (NSUInteger)daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
            case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
            case 2:
            return [date isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)daysAgo {
    return [NSDate daysAgo:self];
}

+ (NSUInteger)daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

@end
