//
//  NSString+MTExtHash.h
//  MTKit
//
//  Created by Day Ling on 2018/1/10.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MTExtHash)

/**
 Returns a lowercase NSString for md2 hash.
 */
- (nullable NSString *)mt_md2String;

/**
 Returns a lowercase NSString for md4 hash.
 */
- (nullable NSString *)mt_md4String;

/**
 Returns a lowercase NSString for md5 hash.
 */
- (nullable NSString *)mt_md5String;

/**
 Returns a lowercase NSString for sha1 hash.
 */
- (nullable NSString *)mt_sha1String;

/**
 Returns a lowercase NSString for sha224 hash.
 */
- (nullable NSString *)mt_sha224String;

/**
 Returns a lowercase NSString for sha256 hash.
 */
- (nullable NSString *)mt_sha256String;

/**
 Returns a lowercase NSString for sha384 hash.
 */
- (nullable NSString *)mt_sha384String;

/**
 Returns a lowercase NSString for sha512 hash.
 */
- (nullable NSString *)mt_sha512String;

/**
 Returns a lowercase NSString for hmac using algorithm md5 with key.
 @param key The hmac key.
 */
- (nullable NSString *)mt_hmacMD5StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha1 with key.
 @param key The hmac key.
 */
- (nullable NSString *)mt_hmacSHA1StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha224 with key.
 @param key The hmac key.
 */
- (nullable NSString *)mt_hmacSHA224StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha256 with key.
 @param key The hmac key.
 */
- (nullable NSString *)mt_hmacSHA256StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha384 with key.
 @param key The hmac key.
 */
- (nullable NSString *)mt_hmacSHA384StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha512 with key.
 @param key The hmac key.
 */
- (nullable NSString *)mt_hmacSHA512StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for crc32 hash.
 */
- (nullable NSString *)mt_crc32String;

@end

NS_ASSUME_NONNULL_END
