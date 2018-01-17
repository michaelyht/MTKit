//
//  NSUserDefaults+MTExt.m
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "NSUserDefaults+MTExt.h"

@implementation NSUserDefaults (MTExt)

+ (void)mt_setObject:(id)obj forKey:(NSString *)key {
    if (key == nil) {
        return;
    }
    [[self standardUserDefaults] setObject:obj forKey:key];
    [[self standardUserDefaults] synchronize];
}

+ (id)mt_objectForKey:(NSString *)key {
    if (key == nil) {
        return nil;
    }
    id value = [[self standardUserDefaults] objectForKey:key];
    return value;
}

+ (void)mt_removeObjectForKey:(NSString *)key {
    if (key == nil) {
        return;
    }
    [[self standardUserDefaults] removeObjectForKey:key];
    [[self standardUserDefaults] synchronize];
}

@end
