//
//  NSString+MTExtHash.m
//  MTKit
//
//  Created by Day Ling on 2018/1/10.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "NSString+MTExtHash.h"
#import "NSData+MTExt.h"

@implementation NSString (MTExtHash)

- (NSString *)mt_md2String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] mt_md2String];
}

- (NSString *)mt_md4String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] mt_md4String];
}

- (NSString *)mt_md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] mt_md5String];
}

- (NSString *)mt_sha1String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] mt_sha1String];
}

- (NSString *)mt_sha224String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] mt_sha224String];
}

- (NSString *)mt_sha256String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] mt_sha256String];
}

- (NSString *)mt_sha384String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] mt_sha384String];
}

- (NSString *)mt_sha512String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] mt_sha512String];
}

- (NSString *)mt_crc32String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] mt_crc32String];
}

- (NSString *)mt_hmacMD5StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            mt_hmacMD5StringWithKey:key];
}

- (NSString *)mt_hmacSHA1StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            mt_hmacSHA1StringWithKey:key];
}

- (NSString *)mt_hmacSHA224StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            mt_hmacSHA224StringWithKey:key];
}

- (NSString *)mt_hmacSHA256StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            mt_hmacSHA256StringWithKey:key];
}

- (NSString *)mt_hmacSHA384StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            mt_hmacSHA384StringWithKey:key];
}

- (NSString *)mt_hmacSHA512StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            mt_hmacSHA512StringWithKey:key];
}
@end
