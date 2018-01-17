//
//  NSDictionary+MTExtUrlParam.h
//  MTKit
//
//  Created by Day Ling on 2018/1/10.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (MTExtUrlParam)

/**
 *  @brief  将NSDictionary转换成url 参数字符串
 *
 *  @return url 参数字符串
 */
- (NSString *)mt_urlParamString;

@end

@interface NSString (MTExtUrlParam)

/**
 *  将url参数转换成NSDictionary
 *
 *  @return NSDictionary
 */
- (NSDictionary *)mt_toParamDictionary;

@end

NS_ASSUME_NONNULL_END
