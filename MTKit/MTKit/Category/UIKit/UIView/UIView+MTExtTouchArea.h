//
//  UIView+MTExtTouchArea.h
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MTExtTouchArea)

#pragma mark - Click on the hotspot

/**
 *  @brief  设置按钮额外热区
 */
@property (nonatomic, assign) UIEdgeInsets mt_touchAreaInsets;

@end
