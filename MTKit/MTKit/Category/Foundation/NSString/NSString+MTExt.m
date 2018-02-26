//
//  NSString+MtExt.m
//  MTKit
//
//  Created by Day Ling on 2018/1/10.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "NSString+MTExt.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSNumber+MTExt.h"
//#import "NSString+mtExt2Vertify.h"

@implementation NSString (MTExt)

#pragma mark - Utilities
/**
 返回UUID
 
 @return UUID
 */
+ (NSString *)mt_stringByUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

/**
 *  @brief  清除html标签
 *
 *  @return 清除后的结果
 */
- (NSString *)mt_stringByTrimmingHTMLLabel {
    return [self stringByReplacingOccurrencesOfString:@"<[^>]+>" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
}

/**
 *  @brief  清除js脚本
 *
 *  @return 清楚js后的结果
 */
- (NSString *)mt_stringByTrimmingScriptsAndStrippingHTML {
    NSMutableString *mString = [self mutableCopy];
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<script[^>]*>[\\w\\W]*</script>"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *matches = [regex matchesInString:mString
                                      options:NSMatchingReportProgress
                                        range:NSMakeRange(0, [mString length])];
    for (NSTextCheckingResult *match in [matches reverseObjectEnumerator]) {
        [mString replaceCharactersInRange:match.range withString:@""];
    }
    return [mString mt_stringByTrimmingHTMLLabel];
}

/**
 *  @brief  去除字符串两端空格
 *
 *  @return 去除字符串两端的字符串
 */
- (NSString *)mt_stringByTrimmingWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

/**
 去除字符串中所有的空格
 
 @return 新的字符串
 */
- (NSString *)mt_stringByTrimmingAllWhitespace {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

/**
 *  @brief  去除字符串两端空格与换行符
 *
 *  @return 去除字符串两端空格与换行符
 */
- (NSString *)mt_stringByTrimmingWhitespaceAndNewlines {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 nil, @"", @"  ", @"\n" will Returns NO; otherwise Returns YES.
 */
- (BOOL)mt_isNotEmpty {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

/**
 获取拼音
 
 @return 字符串拼音
 */
- (NSString*)mt_pinYin {
    //方式一
    //先转换为带声调的拼音
    NSMutableString*str = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)str,NULL,kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL,kCFStringTransformStripDiacritics,NO);
    return str;
}

/**
 *  获取拼音首字母
 *
 *  @return 获取拼音首字母
 */
- (NSString*)mt_initialOfPinyin {
    //1.先传化为拼音
    NSString*pinYin = [self.mt_pinYin uppercaseString];
    //2.获取首字母
    if (!pinYin||![pinYin mt_isNotEmpty]) {
        return @"#";
    }
    pinYin=[pinYin substringToIndex:1];
    if ([pinYin compare:@"A"]==NSOrderedAscending||[pinYin compare:@"Z"]==NSOrderedDescending) {
        pinYin = @"#";
    }
    return pinYin;
}


/**
 *  将字符串转化为NSURL
 *
 *  @return  NSURL地址
 */
-(NSURL *)mt_toUrl {
    if (![self mt_isNotEmpty]) {
        return nil;
    }
    NSString *urlString = self;
    if (![urlString hasPrefix:@"http"]) {
        urlString = [NSString stringWithFormat:@"http://%@", self];
    }
    return [NSURL URLWithString:urlString];
}

/**
 *  将资源字符串转化为图片资源
 *
 *  @return  图片
 */
-(UIImage *)mt_toImage {
    if (![self mt_isNotEmpty]) {
        return nil;
    }
    return [UIImage imageNamed:self];
}

- (NSNumber *)mt_numberValue {
    return [NSNumber mt_numberWithString:self];
}

#pragma mark - Encode and decode
///=============================================================================
/// @name Encode and decode
///=============================================================================

/**
 *  字符串加密为base64
 *
 *  @return 返回String
 */
- (nullable NSString *)mt_base64EncodedString {
    NSData *nsdata = [self
                      dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    // Print the Base64 encoded string
    return  base64Encoded;
}

/**
 *  解密base64字符串
 *
 *  @return 返回解析后的字符串
 */
- (nullable NSString *)mt_stringFromBase64EncodedString {
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:self options:0];
    
    // Decoded NSString from the NSData
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    return base64Decoded;
}

/**
 URL encode a string in utf-8.
 @return the encoded string.
 */
- (NSString *)mt_tringByURLEncode {
    if ([self respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)]) {
        /**
         AFNetworking/AFURLRequestSerialization.m
         
         Returns a percent-escaped string following RFC 3986 for a query string key or value.
         RFC 3986 states that the following characters are "reserved" characters.
         - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
         - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
         In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
         query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
         should be percent-escaped in the query string.
         - parameter string: The string to be percent-escaped.
         - returns: The percent-escaped string.
         */
        static NSString * const kAFCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
        static NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
        
        NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
        [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
        static NSUInteger const batchSize = 50;
        
        NSUInteger index = 0;
        NSMutableString *escaped = @"".mutableCopy;
        
        while (index < self.length) {
            NSUInteger length = MIN(self.length - index, batchSize);
            NSRange range = NSMakeRange(index, length);
            // To avoid breaking up character sequences such as 👴🏻👮🏽
            range = [self rangeOfComposedCharacterSequencesForRange:range];
            NSString *substring = [self substringWithRange:range];
            NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
            [escaped appendString:encoded];
            
            index += range.length;
        }
        return escaped;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding cfEncoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *encoded = (__bridge_transfer NSString *)
        CFURLCreateStringByAddingPercentEscapes(
                                                kCFAllocatorDefault,
                                                (__bridge CFStringRef)self,
                                                NULL,
                                                CFSTR("!#$&'()*+,/:;=?@[]"),
                                                cfEncoding);
        return encoded;
#pragma clang diagnostic pop
    }
}

/**
 URL decode a string in utf-8.
 @return the decoded string.
 */
- (NSString *)mt_stringByURLDecode {
    if ([self respondsToSelector:@selector(stringByRemovingPercentEncoding)]) {
        return [self stringByRemovingPercentEncoding];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding en = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *decoded = [self stringByReplacingOccurrencesOfString:@"+"
                                                            withString:@" "];
        decoded = (__bridge_transfer NSString *)
        CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                NULL,
                                                                (__bridge CFStringRef)decoded,
                                                                CFSTR(""),
                                                                en);
        return decoded;
#pragma clang diagnostic pop
    }
}

/**
 Escape commmon HTML to Entity.
 Example: "a < b" will be escape to "a&lt;b".
 */
- (NSString *)mt_stringByEscapingHTML {
    NSUInteger len = self.length;
    if (!len) return self;
    
    unichar *buf = malloc(sizeof(unichar) * len);
    if (!buf) return self;
    [self getCharacters:buf range:NSMakeRange(0, len)];
    
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < len; i++) {
        unichar c = buf[i];
        NSString *esc = nil;
        switch (c) {
            case 34: esc = @"&quot;"; break;
            case 38: esc = @"&amp;"; break;
            case 39: esc = @"&apos;"; break;
            case 60: esc = @"&lt;"; break;
            case 62: esc = @"&gt;"; break;
            default: break;
        }
        if (esc) {
            [result appendString:esc];
        } else {
            CFStringAppendCharacters((CFMutableStringRef)result, &c, 1);
        }
    }
    free(buf);
    return result;
}

/**
 格式化电话号码显示
 
 @return fg. 133 3333 3333
 */
- (NSString *)mt_formattoPhoneNumber {
    if (self == nil || [self isEqualToString:@""]) {
        return @"";
    }
    NSMutableString *tmpString = [[NSMutableString alloc] initWithString:self];
    [tmpString replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, tmpString.length)];
    //    139 1697 0340
    if ([tmpString length] > 3) {
        [tmpString insertString:@" " atIndex:3];
    }
    if ([tmpString length] > 8) {
        [tmpString insertString:@" " atIndex:8];
    }
    return tmpString;
}

/**
 格式化银行卡显示
 
 @return fg. xxxx xxxx xxxx xxx
 */
- (NSString *)mt_formattoCardNumber {
    if (self == nil || [self isEqualToString:@""]) {
        return @"";
    }
    NSMutableString *tmpString = [[NSMutableString alloc] initWithString:self];
    [tmpString replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, tmpString.length)];
    //6222 0210 0112 2937 680
    if ([tmpString length] > 4) {
        [tmpString insertString:@" " atIndex:4];
    }
    if ([tmpString length] > 9) {
        [tmpString insertString:@" " atIndex:9];
    }
    if ([tmpString length] > 14) {
        [tmpString insertString:@" " atIndex:14];
    }
    if ([tmpString length] > 19) {
        [tmpString insertString:@" " atIndex:19];
    }
    return tmpString;
}

@end
