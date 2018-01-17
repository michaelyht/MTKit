//
//  NSDictionary+MTExt.m
//  MTKit
//
//  Created by Day Ling on 2018/1/10.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "NSDictionary+MTExt.h"

@implementation NSDictionary (MTExt)

/**
 返回所有key (按字典序排列)
 
 @return key array
 */
- (NSArray *)mt_allKeysSorted {
    return [[self allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

/**
 返回所有value (按key的字典序排列)
 
 @return value array
 */
- (NSArray *)mt_allValuesSortedByKeys {
    NSArray *sortedKeys = [self mt_allKeysSorted];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (id key in sortedKeys) {
        [arr addObject:self[key]];
    }
    return arr;
}

/**
 是否包含 key
 
 @param key key
 @return yes/no
 */
- (BOOL)mt_containsObjectForKey:(id)key {
    return [[self allKeys] containsObject:key];
}

/**
 根据一组 key 来取对象
 
 @param keys key array
 @return value array
 */
- (NSDictionary *)mt_entriesForKeys:(NSArray *)keys {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:keys.count];
    for (id key in keys) {
        id value = self[key];
        if (value) dic[key] = value;
    }
    return dic;
}

@end
