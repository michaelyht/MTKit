//
//  MTHttpAction.h
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTAPIClient.h"
#import "MTConstants.h"
#import "MT_Define_App.h"

/**
 *  HTTP访问回调
 *
 *  @param errCode 状态码 0 访问失败   200 正常  500 空 其他异常
 *  @param data    返回数据 nil 为空
 *  @param errMsg     错误描述
 */
typedef void(^ResultBlock)(NSInteger errCode, id data, NSString *errMsg);

/**
 1.1.4新增 -- 第三方接口获取的数据，不判断返回值，直接返回接口的数据
 
 @param data 接口返回的数据
 */
typedef void(^Result3rdBlock)(id data, NSError *error);

@interface MTHttpAction : NSObject

@property (nonatomic, strong) MTAPIClient *apiClient;


+ (instancetype)sharedHttpAction MTKitDeprecated("2.0后废弃，使用sharedHttpActionWithService:方法，新增对每个接口Key值的控制");

/**
 2.0新增初始化
 
 @param apiCodeSuccess 服务器正确的返回码
 @param apiReturnCodeKey 返回码的Key
 @param apiReturnDataKey 返回内容的Key
 @param apiReturnMsgKey 返回提示信息的Key
 @return 回调
 */
+ (instancetype)sharedHttpActionByApiReturnCodeSuccess:(NSInteger)apiCodeSuccess
                                               codeKey:(NSString *)apiReturnCodeKey
                                               dataKey:(NSString *)apiReturnDataKey
                                                msgKey:(NSString *)apiReturnMsgKey;

- (BOOL)isReachable;

#pragma mark - 网络请求方法

/**
 *  普通的访问请求(有提示，带判断网络状态, 带loading..)
 *
 *  @param URLString    接口地址
 *  @param requestBlock 回调函数
 */
- (void)POSTHUDByUrlString:(NSString *)URLString result:(ResultBlock)requestBlock;


/**
 *  普通的访问请求(有提示，带判断网络状态)
 *
 *  @param URLString    接口地址
 *  @param requestBlock 回调函数
 */
- (void)POSTByUrlString:(NSString *)URLString result:(ResultBlock)requestBlock;

/**
 *  普通的访问请求(有提示，带判断网络状态, 带loading..)
 *
 *  @param URLString    接口地址
 *  @param parameters   字典参数
 *  @param requestBlock 回调函数
 */
- (void)POSTHUDByUrlString:(NSString *)URLString parameters:(id)parameters result:(ResultBlock)requestBlock;

/**
 *  普通的访问请求(有提示，带判断网络状态)
 *
 *  @param URLString    接口地址
 *  @param parameters   字典参数
 *  @param requestBlock 回调函数
 */
- (void)POSTByUrlString:(NSString *)URLString parameters:(id)parameters result:(ResultBlock)requestBlock;

/**
 *  普通的访问请求(有提示，带判断网络状态, 带loading)
 *
 *  @param URLString    接口地址
 *  @param parameters   字典参数
 *  @param requestBlock 回调函数
 */
- (void)GETHUDByUrlString:(NSString *)URLString parameters:(id)parameters result:(ResultBlock)requestBlock;

/**
 *  普通的访问请求(有提示，带判断网络状态)
 *
 *  @param URLString    接口地址
 *  @param parameters   字典参数
 *  @param requestBlock 回调函数
 */
- (void)GETByUrlString:(NSString *)URLString parameters:(id)parameters result:(ResultBlock)requestBlock;

/**
 获取html代码
 
 @param URLString html连接
 @param requestBlock 回调函数
 */
- (void)getHtmlStringOfURLString:(NSString *)URLString result:(ResultBlock)requestBlock;


#pragma mark - 新增访问三方接口，直接返回所有返回值。

/**
 访问三方接口，直接返回所有返回值。不作Code判断，只做Http访问结果判断
 GET请求
 @param URLString 接口地址
 @param parameters 字典参数
 @param result 回调函数
 */
- (void)GET3rdByUrlString:(NSString *)URLString parameters:(id)parameters result:(Result3rdBlock)result;

/**
 访问三方接口，直接返回所有返回值。不作Code判断，只做Http访问结果判断
 POST请求
 @param URLString 接口地址
 @param parameters 字典参数
 @param result 回调函数
 */
- (void)POST3rdByUrlString:(NSString *)URLString parameters:(id)parameters result:(Result3rdBlock)result;

#pragma mark - 设置\获取Http Header 的值
/**
 设置Http Header参数值
 
 @param value value
 @param field key
 */
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

/**
 获取Http header的值
 
 @param field key
 @return value
 */
- (NSString *)valueForHTTPHeaderField:(NSString *)field;

@end
