//
//  UIButton+MTExtLayer.h
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MTExtLayer)

/**
 按钮圆角
 */
@property (nonatomic, assign) CGFloat mt_cornerRadius;

/**
 边框宽度
 */
@property (nonatomic, assign) CGFloat mt_borderWidth;

/**
 边框颜色
 */
@property (nonatomic, strong) UIColor *mt_borderColor;

@end
