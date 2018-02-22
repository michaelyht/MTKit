//
//  MTAPIClient.h
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>
#import "MT_Reachability.h"

@interface MTAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;


@property (nonatomic, assign, readonly) BOOL isReachable;


/**
 是否监控网络
 */
@property (nonatomic, assign) BOOL isDetectNetwork;


/**
 当前网络状态
 NotReachable = 0,  //无网络
 ReachableViaWiFi,  //WIFI
 ReachableViaWWAN   // 手机网络
 */
@property (nonatomic, assign) MTNetworkStatus netWorkStatus;

@end
