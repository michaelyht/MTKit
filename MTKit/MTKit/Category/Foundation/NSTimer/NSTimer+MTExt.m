//
//  NSTimer+MTExt.m
//  MTKit
//
//  Created by Day Ling on 2018/1/10.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "NSTimer+MTExt.h"

@implementation NSTimer (MTExt)

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
                                repeats:(BOOL)inRepeats {
    void (^block)() = [inBlock copy];
    block = [inBlock copy];
    id ret = [self scheduledTimerWithTimeInterval:inTimeInterval
                                           target:self
                                         selector:@selector(mt_ExecuteSimpleBlock:)
                                         userInfo:block
                                          repeats:inRepeats];
    return ret;
}
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
                       repeats:(BOOL)inRepeats {
    void (^block)() = [inBlock copy];
    id ret = [self timerWithTimeInterval:inTimeInterval
                                  target:self
                                selector:@selector(mt_ExecuteSimpleBlock:)
                                userInfo:block
                                 repeats:inRepeats];
    return ret;
}

/**
 *  暂停NSTimer
 */
- (void)mt_pauseTimer {
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}

/**
 *   开始NSTimer
 */
- (void)mt_resumeTimer {
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

/**
 *  延迟开始NSTimer
 */
- (void)mt_resumeTimerAfterTimeInterval:(NSTimeInterval)interval {
    if (![self isValid]) {
        return ;
    }
    
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

#pragma mark - private
+ (void)mt_ExecuteSimpleBlock:(NSTimer *)inTimer;
{
    if([inTimer userInfo])
    {
        void (^block)() = (void (^)())[inTimer userInfo];
        block();
    }
}

@end
