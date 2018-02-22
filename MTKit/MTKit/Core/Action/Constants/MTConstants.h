//
//  MTConstants.h
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTConstants : NSObject

+ (instancetype)sharedInstance;

#pragma mark - API_Return_Info

/**
 API返回状态值的key值
 fg.  return:{
 code: 200,
 msg: "success",
 data: NSObject,
 }  apiReturnCode == code
 */
@property (nonatomic, strong) NSString *apiReturnCode;

/**
 API返回提示信息的key值
 fg.  return:{
 code: 200,
 msg: "success",
 data: NSObject,
 }  apiReturnMsg == msg
 */
@property (nonatomic, strong) NSString *apiReturnMsg;

/**
 API返回值使用对象的Key值
 fg.  return:{
 code: 200,
 msg: "success",
 data: NSObject,
 }  apiReturnData == data
 */
@property (nonatomic, strong) NSString *apiReturnData;

/**
 API返回成功的状态值
 */
@property (nonatomic, assign) NSInteger apiReturnCodeSuccess;

#pragma mark - API_Signature

/**
 签名的key
 */
@property (nonatomic, strong) NSString *signatureKey;

/**
 盐 - 开始位置
 */
@property (nonatomic, assign) NSInteger signSaltStartIndex;

/**
 盐 - 长度
 */
@property (nonatomic, assign) NSInteger signSaltLength;

/**
 如果用户登录，存入UserDefaults里的用户登录名的key值
 用于生成高级密钥串，防止接口数据泄露
 */
@property (nonatomic, strong) NSString *signLoginNameKey;

/**
 如果用户登录，存入UserDefaults里的用户登录密码MD5后的key值
 */
@property (nonatomic, strong) NSString *signLoginPwdKey;

@end

