//
//  NSUserDefaults+MTExt.h
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (MTExt)

+ (void)mt_setObject:(id)obj forKey:(NSString *)key;

+ (id)mt_objectForKey:(NSString *)key;

+ (void)mt_removeObjectForKey:(NSString *)key;

@end
