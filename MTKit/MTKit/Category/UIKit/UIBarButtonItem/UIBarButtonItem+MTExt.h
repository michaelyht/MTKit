//
//  UIBarButtonItem+MTExt.h
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (MTExt)

@property (nullable, nonatomic, copy) void (^mt_actionBlock)(id);

@end

NS_ASSUME_NONNULL_END
