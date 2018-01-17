//
//  UILabel+MTExt.h
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MTExt)
/**
 判断nil,如果设置为nil,返回@""
 */
@property (nonatomic, strong) NSString *mt_text;

@end
