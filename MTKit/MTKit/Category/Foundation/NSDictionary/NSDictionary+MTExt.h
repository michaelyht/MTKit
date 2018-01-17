//
//  NSDictionary+MTExt.h
//  MTKit
//
//  Created by Day Ling on 2018/1/10.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_STATIC_INLINE BOOL NSDictionaryIsEmpty(NSDictionary *dictionary)
{
    if (dictionary && dictionary.count > 0 ) return NO;
    
    return YES;
}

@interface NSDictionary (MTExt)

/**
 返回所有key (按字典序排列)
 
 @return key array
 */
- (NSArray *)mt_allKeysSorted;


/**
 返回所有value (按key的字典序排列)
 
 @return value array
 */
- (NSArray *)mt_allValuesSortedByKeys;


/**
 是否包含 key
 
 @param key key
 @return yes/no
 */
- (BOOL)mt_containsObjectForKey:(id)key;


/**
 根据一组 key 来取对象
 
 @param keys key array
 @return value array
 */
- (NSDictionary *)mt_entriesForKeys:(NSArray *)keys;


@end

NS_ASSUME_NONNULL_END
