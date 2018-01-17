//
//  UIView+MTExtTouchArea.m
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "UIView+MTExtTouchArea.h"
#import <objc/runtime.h>

@implementation UIView (MTExtTouchArea)

#pragma mark - 点击热区
- (UIEdgeInsets)mt_touchAreaInsets{
    return [objc_getAssociatedObject(self, @selector(mt_touchAreaInsets)) UIEdgeInsetsValue];
}

/**
 *  @brief  设置按钮额外热区
 */
- (void)setMt_touchAreaInsets:(UIEdgeInsets)touchAreaInsets{
    NSValue *value = [NSValue valueWithUIEdgeInsets:touchAreaInsets];
    objc_setAssociatedObject(self, @selector(mt_touchAreaInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    UIEdgeInsets touchAreaInsets = self.mt_touchAreaInsets;
    CGRect bounds = self.bounds;
    bounds = CGRectMake(bounds.origin.x - touchAreaInsets.left,
                        bounds.origin.y - touchAreaInsets.top,
                        bounds.size.width + touchAreaInsets.left + touchAreaInsets.right,
                        bounds.size.height + touchAreaInsets.top + touchAreaInsets.bottom);
    return CGRectContainsPoint(bounds, point);
}


@end
