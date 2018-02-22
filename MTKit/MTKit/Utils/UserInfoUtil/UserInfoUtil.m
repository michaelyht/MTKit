//
//  UserInfoUtil.m
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "UserInfoUtil.h"
//#import "TTConstants.h"

@implementation UserInfoUtil

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

/**
 存储用户密码到keyChain
 
 @param password 用户密码
 @param userId 对应服务器唯一的userid
 */
+ (void)setPassword:(NSString *)password forKeyChainUserID:(NSString *)userId {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:userId];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:password] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

/**
 从Keychain中取保存的密码
 
 @param userId 用户唯一的ID
 @return 返回用户密码
 */
+ (NSString *)getPasswordForKeychainUserId:(NSString *)userId {
    NSString *ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:userId];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", userId, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

/**
 通过ID删除keyChain中保存的对象
 
 @param ID keyChain中保存的ID
 */
+ (void)deleteObjForKeyChainByID:(NSString *)ID {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:ID];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

/**
 保存登录名和密码 -- 用于签名
 
 @param loginName 登录名
 @param md5Pwd md5后的登录密码
 */
+ (void)saveSignatureByLoginName:(NSString *)loginName md5Pwd:(NSString *)md5Pwd {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    [userDefault setObject:loginName forKey:[TTConstants sharedInstance].signLoginNameKey];
//    [userDefault setObject:md5Pwd forKey:[TTConstants sharedInstance].signLoginPwdKey];
    [userDefault synchronize];
}

/**
 删除用户签名的登录名和密码
 */
+ (void)removeSignature {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    [userDefault removeObjectForKey:[TTConstants sharedInstance].signLoginNameKey];
//    [userDefault removeObjectForKey:[TTConstants sharedInstance].signLoginPwdKey];
    [userDefault synchronize];
}

@end
