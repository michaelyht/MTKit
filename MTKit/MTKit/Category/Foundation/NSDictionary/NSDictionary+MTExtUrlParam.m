//
//  NSDictionary+MTExtUrlParam.m
//  MTKit
//
//  Created by Day Ling on 2018/1/10.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "NSDictionary+MTExtUrlParam.h"

@implementation NSDictionary (MTExtUrlParam)
/**
 *  @brief  将NSDictionary转换成url 参数字符串
 *
 *  @return url 参数字符串
 */
- (NSString *)mt_urlParamString {
    NSMutableString *string = [NSMutableString string];
    for (NSString *key in [self allKeys]) {
        if ([string length]) {
            [string appendString:@"&"];
        }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        // 这部分使用到的过期api
        CFStringRef escaped = CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)[[self objectForKey:key] description],
                                                                      NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                      kCFStringEncodingUTF8);
#pragma clang diagnostic pop
        
        [string appendFormat:@"%@=%@", key, escaped];
        CFRelease(escaped);
    }
    return string;
}

@end

@implementation NSString (mtExt2UrlParam)

/**
 *  将url参数转换成NSDictionary
 *
 *  @return NSDictionary
 */
- (NSDictionary *)mt_toParamDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *parameters = [self componentsSeparatedByString:@"&"];
    for(NSString *parameter in parameters) {
        NSArray *contents = [parameter componentsSeparatedByString:@"="];
        if([contents count] == 2) {
            NSString *key = [contents objectAtIndex:0];
            NSString *value = [contents objectAtIndex:1];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#pragma clang diagnostic pop
            if (key && value) {
                [dict setObject:value forKey:key];
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end
