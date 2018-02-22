//
//  BaseService.h
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTHttpAction.h"
#import "MTFileAction.h"

@interface BaseService : NSObject

/**
 网络请求Action
 */
@property (nonatomic, strong) MTHttpAction *httpAction;

/**
 文件上传，下载Action。
 */
@property (nonatomic, strong) MTFileAction *fileAction;



+ (instancetype)sharedService;

/**
 API 请求成功返回的状态值
 */
@property (nonatomic, assign) NSInteger apiReturnCodeSuccess;

/**
 API 请求成功返回的状态值Key值
 */
@property (nonatomic, strong) NSString *apiReturnCodeKey;

/**
 API 请求返回的数据Key
 */
@property (nonatomic, strong) NSString *apiReturnDataKey;

/**
 API 请求返回的提示信息KEY
 */
@property (nonatomic, strong) NSString *apiReturnMsgKey;

@end
