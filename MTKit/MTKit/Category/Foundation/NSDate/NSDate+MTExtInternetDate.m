//
//  NSDate+MTExtInternetDate.m
//  MTKit
//
//  Created by Day Ling on 2018/1/10.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "NSDate+MTExtInternetDate.h"
#import "NSDate+MTExtFormat.h"

static NSDateFormatter *_internetDateTimeFormatter = nil;

@implementation NSDate (MTExtInternetDate)

/**
 获取网络时间
 2s超时
 @return 如果超时，返回本地时间
 */
+ (NSDate *)mt_getNetworkDate {
    return [self mt_getNetworkDateByTimeout:2];
}

/**
 获取网络时间
 
 @param timeout 超时时间
 @return 如果超时，返回本地时间
 */
+ (NSDate *)mt_getNetworkDateByTimeout:(NSInteger)timeout {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSString *urlString = @"hmtp://m.baidu.com";
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval:timeout];
    [request setHTTPShouldHandleCookies:FALSE];
    [request setHTTPMethod:@"GET"];
    NSHTTPURLResponse *response;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *date = [[response allHeaderFields] objectForKey:@"Date"];
    NSDate* inputDate = [NSDate mt_dateFromInternetDateTimeString:date formatHint:MTDateFormatHintRFC822];
    return inputDate;
#pragma clang diagnostic pop
}


+ (NSDate *)mt_dateFromInternetDateTimeString:(NSString *)dateString
                                   formatHint:(MTDateFormatHint)hint {
    NSDate *date = nil;
    if (dateString) {
        if (hint != MTDateFormatHintRFC3339) {
            // Try RFC822 first
            date = [NSDate mt_dateFromRFC822String:dateString];
            if (!date) date = [NSDate mt_dateFromRFC3339String:dateString];
        } else {
            // Try RFC3339 first
            date = [NSDate mt_dateFromRFC3339String:dateString];
            if (!date) date = [NSDate mt_dateFromRFC822String:dateString];
        }
    }
    // Finished with date string
    return date;
}

+ (NSDate *)mt_dateFromRFC3339String:(NSString *)dateString {
    NSDate *date = nil;
    if (dateString) {
        NSDateFormatter *dateFormatter = [NSDate mt_internetDateTimeFormamter];
        @synchronized(dateFormatter) {
            
            // Process date
            NSString *RFC3339String = [[NSString stringWithString:dateString] uppercaseString];
            RFC3339String = [RFC3339String stringByReplacingOccurrencesOfString:@"Z" withString:@"-0000"];
            // Remove colon in timezone as it breaks NSDateFormatter in iOS 4+.
            // - see hmtps://devforums.apple.com/thread/45837
            if (RFC3339String.length > 20) {
                RFC3339String = [RFC3339String stringByReplacingOccurrencesOfString:@":"
                                                                         withString:@""
                                                                            options:0
                                                                              range:NSMakeRange(20, RFC3339String.length-20)];
            }
            if (!date) { // 1996-12-19T16:39:57-0800
                [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"];
                date = [dateFormatter dateFromString:RFC3339String];
            }
            if (!date) { // 1937-01-01T12:00:27.87+0020
                [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZZZ"];
                date = [dateFormatter dateFromString:RFC3339String];
            }
            if (!date) { // 1937-01-01T12:00:27
                [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss"];
                date = [dateFormatter dateFromString:RFC3339String];
            }
            if (!date) NSLog(@"Could not parse RFC3339 date: \"%@\" Possible invalid format.", dateString);
            
        }
    }
    // Finished with date string
    return date;
}
+ (NSDate *)mt_dateFromRFC822String:(NSString *)dateString {
    NSDate *date = nil;
    if (dateString) {
        NSDateFormatter *dateFormatter = [NSDate mt_internetDateTimeFormamter];
        @synchronized(dateFormatter) {
            
            // Process
            NSString *RFC822String = [[NSString stringWithString:dateString] uppercaseString];
            if ([RFC822String rangeOfString:@","].location != NSNotFound) {
                if (!date) { // Sun, 19 May 2002 15:21:36 GMT
                    [dateFormatter setDateFormat:@"EEE, d MMM yyyy HH:mm:ss zzz"];
                    date = [dateFormatter dateFromString:RFC822String];
                }
                if (!date) { // Sun, 19 May 2002 15:21 GMT
                    [dateFormatter setDateFormat:@"EEE, d MMM yyyy HH:mm zzz"];
                    date = [dateFormatter dateFromString:RFC822String];
                }
                if (!date) { // Sun, 19 May 2002 15:21:36
                    [dateFormatter setDateFormat:@"EEE, d MMM yyyy HH:mm:ss"];
                    date = [dateFormatter dateFromString:RFC822String];
                }
                if (!date) { // Sun, 19 May 2002 15:21
                    [dateFormatter setDateFormat:@"EEE, d MMM yyyy HH:mm"];
                    date = [dateFormatter dateFromString:RFC822String];
                }
            } else {
                if (!date) { // 19 May 2002 15:21:36 GMT
                    [dateFormatter setDateFormat:@"d MMM yyyy HH:mm:ss zzz"];
                    date = [dateFormatter dateFromString:RFC822String];
                }
                if (!date) { // 19 May 2002 15:21 GMT
                    [dateFormatter setDateFormat:@"d MMM yyyy HH:mm zzz"];
                    date = [dateFormatter dateFromString:RFC822String];
                }
                if (!date) { // 19 May 2002 15:21:36
                    [dateFormatter setDateFormat:@"d MMM yyyy HH:mm:ss"];
                    date = [dateFormatter dateFromString:RFC822String];
                }
                if (!date) { // 19 May 2002 15:21
                    [dateFormatter setDateFormat:@"d MMM yyyy HH:mm"];
                    date = [dateFormatter dateFromString:RFC822String];
                }
            }
            if (!date) NSLog(@"Could not parse RFC822 date: \"%@\" Possible invalid format.", dateString);
            
        }
    }
    // Finished with date string
    return date;
}

#pragma mark - private
+ (NSDateFormatter *)mt_internetDateTimeFormamter {
    @synchronized(self) {
        if (!_internetDateTimeFormatter) {
            NSLocale *en_US_POSIX = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            _internetDateTimeFormatter = [[NSDateFormatter alloc] init];
            [_internetDateTimeFormatter setLocale:en_US_POSIX];
            [_internetDateTimeFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        }
    }
    return _internetDateTimeFormatter;
}

@end
