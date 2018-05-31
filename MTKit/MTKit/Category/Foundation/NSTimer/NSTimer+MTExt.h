//
//  NSTimer+MTExt.h
//  MTKit
//
//  Created by Day Ling on 2018/1/10.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSTimer (MTExt)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wstrict-prototypes"
/**
 *  开启一个当前线程内可重复执行的NSTimer对象
 *
 *  @param inTimeInterval 重复时间
 *  @param inBlock        操作内容
 *  @param inRepeats      是否重复
 *
 *  @return NSTimer对象
 */
+ (id)mt_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval
                                  block:(void (^)())inBlock
                                repeats:(BOOL)inRepeats;
/**
 *  开启一个需添加到线程的可重复执行的NSTimer对象
 *
 *  @param inTimeInterval 重复时间
 *  @param inBlock        操作内容
 *  @param inRepeats      是否重复
 *
 *  @return NSTimer对象
 */
+ (id)mt_timerWithTimeInterval:(NSTimeInterval)inTimeInterval
                         block:(void (^)())inBlock
                       repeats:(BOOL)inRepeats;
#pragma clang diagnostic pop
/**
 *  暂停NSTimer
 */
- (void)mt_pauseTimer;
/**
 *   开始NSTimer
 */
- (void)mt_resumeTimer;
/**
 *  延迟开始NSTimer
 */
- (void)mt_resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
