//
//  UITextField+MTExt.h
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (MTExt)

/**
 占位文字颜色
 */
@property (nonatomic, strong) UIColor *mt_placeholderColor;


/**
 去掉两端空格和换行符的值
 */
@property (nonatomic, strong, readonly) NSString *mt_text;

@end

NS_ASSUME_NONNULL_END
