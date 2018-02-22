//
//  MTMediator.h
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIViewController+MTExt2Parameter.h"

@interface MTMediator : NSObject

+ (instancetype)sharedInstance;

/**
 获取代码中创建的Controller
 
 @param targetName Controller 名字
 @param parameter 参数
 @param shouldCacheTarget 是否缓存
 @return 返回创建好的Controller
 */
- (id)performTarget:(NSString *)targetName parameter:(NSDictionary *)parameter shouldCacheTarget:(BOOL)shouldCacheTarget;


/**
 清除缓存的Controller
 
 @param targetName ControllerName
 */
- (void)releaseCachedTargetWithTargetName:(NSString *)targetName;


/**
 获取Storyboard中的Controller
 
 @param targetName Storyboard中的 Controller_ID
 @param parameter 传的参数
 @param sbName Storyboard名字
 @return Controller对象
 */
- (id)performSBTarget:(NSString *)targetName parameter:(NSDictionary *)parameter sbName:(NSString *)sbName;

@end
