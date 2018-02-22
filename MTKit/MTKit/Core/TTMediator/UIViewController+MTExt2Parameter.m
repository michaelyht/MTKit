//
//  UIViewController+MTExt2Parameter.m
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "UIViewController+MTExt2Parameter.h"
#import <objc/runtime.h>

const NSString *kVCParameter;
@implementation  UIViewController (MTExt2Parameter)

- (void)setMt_parameter:(NSDictionary *)tt_parameter {
    objc_setAssociatedObject(self, &kVCParameter, tt_parameter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)mt_parameter {
    return objc_getAssociatedObject(self, &kVCParameter);
}

@end
