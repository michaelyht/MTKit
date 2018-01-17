//
//  NSDate+MTExt.h
//  MTKit
//
//  Created by Day Ling on 2018/1/9.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MTExt)

#pragma mark - Component Properties
///=============================================================================
/// @name Component Properties
///=============================================================================

@property (nonatomic, readonly) NSInteger year; ///< Year component
@property (nonatomic, readonly) NSInteger month; ///< Month component (1~12)
@property (nonatomic, readonly) NSInteger day; ///< Day component (1~31)
@property (nonatomic, readonly) NSInteger hour; ///< Hour component (0~23)
@property (nonatomic, readonly) NSInteger minute; ///< Minute component (0~59)
@property (nonatomic, readonly) NSInteger second; ///< Second component (0~59)
@property (nonatomic, readonly) NSInteger nanosecond; ///纳秒 ,十亿分之一秒
@property (nonatomic, readonly) NSInteger weekday; ///< Weekday component (1~7, first day is based on user semting)
@property (nonatomic, readonly) NSInteger weekdayOrdinal; ///< WeekdayOrdinal component
@property (nonatomic, readonly) NSInteger weekOfMonth; ///< WeekOfMonth component (1~5)
@property (nonatomic, readonly) NSInteger weekOfYear; ///< WeekOfYear component (1~53)
@property (nonatomic, readonly) NSInteger yearForWeekOfYear; ///< YearForWeekOfYear component
@property (nonatomic, readonly) NSInteger quarter; ///< Quarter component
@property (nonatomic, readonly) BOOL isLeapMonth; ///< Weather the month is leap month
@property (nonatomic, readonly) BOOL isLeapYear; ///< Weather the year is leap year
@property (nonatomic, readonly) BOOL isToday; ///< Weather date is today (based on current locale)
@property (nonatomic, readonly) BOOL isYesterday; ///< Weather date is yesterday (based on current locale)


#pragma mark - mt
/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)mt_dayOfWeek;
+ (NSInteger)mt_dayOfWeekByDate:(NSDate *)date;

/**
 * 判断时间早晚
 */
+(NSComparisonResult)mt_compareDay:(NSDate *)oneDay withOtherDay:(NSDate *)anotherDay;

/**
 Returns a date representing the receiver date shifted later by the provided number of years.
 
 @param years  Number of years to add.
 @return Date modified by the number of desired years.
 */
- (NSDate *)mt_dateByAddingYears:(NSInteger)years;

/**
 Returns a date representing the receiver date shifted later by the provided number of months.
 
 @param months  Number of months to add.
 @return Date modified by the number of desired months.
 */
- (NSDate *)mt_dateByAddingMonths:(NSInteger)months;

/**
 Returns a date representing the receiver date shifted later by the provided number of weeks.
 
 @param weeks  Number of weeks to add.
 @return Date modified by the number of desired weeks.
 */
- (NSDate *)mt_dateByAddingWeeks:(NSInteger)weeks;

/**
 Returns a date representing the receiver date shifted later by the provided number of days.
 
 @param days  Number of days to add.
 @return Date modified by the number of desired days.
 */
- (NSDate *)mt_dateByAddingDays:(NSInteger)days;

/**
 Returns a date representing the receiver date shifted later by the provided number of hours.
 
 @param hours  Number of hours to add.
 @return Date modified by the number of desired hours.
 */
- (NSDate *)mt_dateByAddingHours:(NSInteger)hours;

/**
 Returns a date representing the receiver date shifted later by the provided number of minutes.
 
 @param minutes  Number of minutes to add.
 @return Date modified by the number of desired minutes.
 */
- (NSDate *)mt_dateByAddingMinutes:(NSInteger)minutes;

/**
 Returns a date representing the receiver date shifted later by the provided number of seconds.
 
 @param seconds  Number of seconds to add.
 @return Date modified by the number of desired seconds.
 */
- (NSDate *)mt_dateByAddingSeconds:(NSInteger)seconds;

@end
