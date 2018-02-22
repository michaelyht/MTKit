//
//  UserInfoUtil.h
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Security/Security.h>

@interface UserInfoUtil : NSObject


/**
 存储用户密码到keyChain
 
 @param password 用户密码
 @param userId 对应服务器唯一的userid
 */
+ (void)setPassword:(NSString *)password forKeyChainUserID:(NSString *)userId;

/**
 从Keychain中取保存的密码
 
 @param userId 用户唯一的ID
 @return 返回用户密码
 */
+ (NSString *)getPasswordForKeychainUserId:(NSString *)userId;


/**
 通过ID删除keyChain中保存的对象
 
 @param ID keyChain中保存的ID
 */
+ (void)deleteObjForKeyChainByID:(NSString *)ID;


/**
 保存登录名和密码 -- 用于签名
 
 @param loginName 登录名
 @param md5Pwd md5后的登录密码
 */
+ (void)saveSignatureByLoginName:(NSString *)loginName md5Pwd:(NSString *)md5Pwd;

/**
 删除用户签名的登录名和密码
 */
+ (void)removeSignature;
@end

