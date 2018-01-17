//
//  NSData+MTExt.h
//  MTKit
//
//  Created by Day Ling on 2018/1/9.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSData (MTExt)

#pragma mark - Hash
///=============================================================================
/// @name Hash
///=============================================================================

/**
 Returns a lowercase NSString for md2 hash.
 */
- (NSString *)mt_md2String;

/**
 Returns an NSData for md2 hash.
 */
- (NSData *)mt_md2Data;

/**
 Returns a lowercase NSString for md4 hash.
 */
- (NSString *)mt_md4String;

/**
 Returns an NSData for md4 hash.
 */
- (NSData *)mt_md4Data;

/**
 Returns a lowercase NSString for md5 hash.
 */
- (NSString *)mt_md5String;

/**
 Returns an NSData for md5 hash.
 */
- (NSData *)mt_md5Data;

/**
 Returns a lowercase NSString for sha1 hash.
 */
- (NSString *)mt_sha1String;

/**
 Returns an NSData for sha1 hash.
 */
- (NSData *)mt_sha1Data;

/**
 Returns a lowercase NSString for sha224 hash.
 */
- (NSString *)mt_sha224String;

/**
 Returns an NSData for sha224 hash.
 */
- (NSData *)mt_sha224Data;

/**
 Returns a lowercase NSString for sha256 hash.
 */
- (NSString *)mt_sha256String;

/**
 Returns an NSData for sha256 hash.
 */
- (NSData *)mt_sha256Data;

/**
 Returns a lowercase NSString for sha384 hash.
 */
- (NSString *)mt_sha384String;

/**
 Returns an NSData for sha384 hash.
 */
- (NSData *)mt_sha384Data;

/**
 Returns a lowercase NSString for sha512 hash.
 */
- (NSString *)mt_sha512String;

/**
 Returns an NSData for sha512 hash.
 */
- (NSData *)mt_sha512Data;

/**
 Returns a lowercase NSString for hmac using algorithm md5 with key.
 @param key  The hmac key.
 */
- (NSString *)mt_hmacMD5StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm md5 with key.
 @param key  The hmac key.
 */
- (NSData *)mt_hmacMD5DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha1 with key.
 @param key  The hmac key.
 */
- (NSString *)mt_hmacSHA1StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha1 with key.
 @param key  The hmac key.
 */
- (NSData *)mt_hmacSHA1DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha224 with key.
 @param key  The hmac key.
 */
- (NSString *)mt_hmacSHA224StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha224 with key.
 @param key  The hmac key.
 */
- (NSData *)mt_hmacSHA224DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha256 with key.
 @param key  The hmac key.
 */
- (NSString *)mt_hmacSHA256StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha256 with key.
 @param key  The hmac key.
 */
- (NSData *)mt_hmacSHA256DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha384 with key.
 @param key  The hmac key.
 */
- (NSString *)mt_hmacSHA384StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha384 with key.
 @param key  The hmac key.
 */
- (NSData *)mt_hmacSHA384DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha512 with key.
 @param key  The hmac key.
 */
- (NSString *)mt_hmacSHA512StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha512 with key.
 @param key  The hmac key.
 */
- (NSData *)mt_hmacSHA512DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for crc32 hash.
 */
- (NSString *)mt_crc32String;

/**
 Returns crc32 hash.
 */
- (uint32_t)mt_crc32;


#pragma mark - Encrypt and Decrypt
///=============================================================================
/// @name Encrypt and Decrypt
///=============================================================================

/**
 Returns an encrypted NSData using AES.
 
 @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
 
 @param iv    An initialization vector length of 16(128bits).
 Pass nil when you don't want to use iv.
 
 @return      An NSData encrypted, or nil if an error occurs.
 */
- (nullable NSData *)mt_aes256EncryptWithKey:(NSData *)key iv:(nullable NSData *)iv;

/**
 Returns an decrypted NSData using AES.
 
 @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
 
 @param iv    An initialization vector length of 16(128bits).
 Pass nil when you don't want to use iv.
 
 @return      An NSData decrypted, or nil if an error occurs.
 */
- (nullable NSData *)mt_aes256DecryptWithkey:(NSData *)key iv:(nullable NSData *)iv;


#pragma mark - Encode and decode
///=============================================================================
/// @name Encode and decode
///=============================================================================

/**
 Returns string decoded in UTF8.
 */
- (nullable NSString *)mt_utf8String;

/**
 Returns a uppercase NSString in HEX.
 */
- (nullable NSString *)mt_hexString;

/**
 Returns an NSData from hex string.
 
 @param hexString   The hex string which is case insensitive.
 
 @return a new NSData, or nil if an error occurs.
 */
+ (nullable NSData *)mt_dataWithHexString:(NSString *)hexString;

/**
 Returns an NSString for base64 encoded.
 */
- (nullable NSString *)mt_base64EncodedString;

/**
 Returns an NSData from base64 encoded string.
 
 @warning This method has been implemented in iOS7.
 
 @param base64EncodedString  The encoded string.
 */
+ (nullable NSData *)mt_dataWithBase64EncodedString:(NSString *)base64EncodedString;

/**
 Returns an NSDictionary or NSArray for decoded self.
 Returns nil if an error occurs.
 */
- (nullable id)mt_jsonValueDecoded;


#pragma mark - Inflate and deflate
///=============================================================================
/// @name Inflate and deflate
///=============================================================================

/**
 Decompress data from gzip data.
 @return Inflated data.
 */
- (nullable NSData *)mt_gzipInflate;

/**
 Comperss data to gzip in default compresssion level.
 @return Deflated data.
 */
- (nullable NSData *)mt_gzipDeflate;

/**
 Decompress data from zlib-compressed data.
 @return Inflated data.
 */
- (nullable NSData *)mt_zlibInflate;

/**
 Comperss data to zlib-compressed in default compresssion level.
 @return Deflated data.
 */
- (nullable NSData *)mt_zlibDeflate;


#pragma mark - Others
///=============================================================================
/// @name Others
///=============================================================================

/**
 Create data from the file in main bundle (similar to [UIImage imageNamed:]).
 
 @param name The file name (in main bundle).
 
 @return A new data create from the file.
 */
+ (nullable NSData *)mt_dataNamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

