//
//  MTMediator.m
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "MTMediator.h"
#import "NSString+MtExt.h"

@interface MTMediator ()

@property (nonatomic, strong) NSMutableDictionary *cachedTarget;

@end

@implementation MTMediator
+ (instancetype)sharedInstance {
    static MTMediator *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[MTMediator alloc] init];
    });
    return mediator;
}

/**
 获取代码中创建的Controller
 
 @param targetName Controller 名字
 @param parameter 参数
 @param shouldCacheTarget 是否缓存
 @return 返回创建好的Controller
 */
- (id)performTarget:(NSString *)targetName parameter:(NSDictionary *)parameter shouldCacheTarget:(BOOL)shouldCacheTarget {
    Class targetClass;
    NSObject *target = self.cachedTarget[targetName];
    //判断是否登录，必须登录的页面
    if (NO) {
        //未登录跳转到登陆页面
    }
    if (target == nil) {
        targetClass = NSClassFromString(targetName);
        target = [[targetClass alloc] init];
    }
    if (target == nil) {
        //NotFound 404
        return nil;
    }
    if (shouldCacheTarget) {
        self.cachedTarget[targetName] = target;
    }
    UIViewController *controller = (UIViewController *)target;
    [controller setMt_parameter:parameter];
    return controller;
}

/**
 清除缓存的Controller
 
 @param targetName ControllerName
 */
- (void)releaseCachedTargetWithTargetName:(NSString *)targetName {
    [self.cachedTarget removeObjectForKey:targetName];
}

/**
 获取Storyboard中的Controller
 
 @param targetName Storyboard中的 Controller_ID
 @param parameter 传的参数
 @param sbName Storyboard名字 不传或者穿空串默认Main
 @return Controller对象
 */
- (id)performSBTarget:(NSString *)targetName parameter:(NSDictionary *)parameter sbName:(NSString *)sbName {
    
    if (NO) {
        //如果当前页面需要登录权限，未登录跳转至登录页面
        return nil;
    }
    if (sbName == nil || ![sbName mt_isNotEmpty]) {
        sbName = @"Main";
    }
    UIViewController *controller = [[UIStoryboard storyboardWithName:sbName bundle:nil] instantiateViewControllerWithIdentifier:targetName];
    if (controller == nil) {
        //notfound
        return nil;
    }
    controller.mt_parameter = parameter;
    return controller;
}

- (NSMutableDictionary *)cachedTarget {
    if (_cachedTarget == nil) {
        _cachedTarget = [NSMutableDictionary dictionary];
    }
    return _cachedTarget;
}

@end
