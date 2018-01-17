//
//  NSObject+MTExt.h
//  MTKit
//
//  Created by Day Ling on 2018/1/10.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MTExt)

#pragma mark - Associate value
///=============================================================================
/// @name Associate value
///=============================================================================

/**
 Associate one object to `self`, as if it was a strong property (strong, nonatomic).
 
 @param value   The object to associate.
 @param key     The pointer to get value from `self`.
 */
- (void)mt_setAssociateValue:(nullable id)value withKey:(void *)key;

/**
 Associate one object to `self`, as if it was a weak property (week, nonatomic).
 
 @param value  The object to associate.
 @param key    The pointer to get value from `self`.
 */
- (void)mt_setAssociateWeakValue:(nullable id)value withKey:(void *)key;

/**
 Get the associated value from `self`.
 
 @param key The pointer to get value from `self`.
 */
- (nullable id)mt_getAssociatedValueForKey:(void *)key;

/**
 Remove all associated values.
 */
- (void)mt_removeAssociatedValues;


#pragma mark - Others
///=============================================================================
/// @name Others
///=============================================================================

/**
 Returns the class name in NSString.
 */
+ (NSString *)mt_className;

/**
 Returns the class name in NSString.
 
 @discussion Apple has implemented this method in NSObject(NSLayoutConstraintCallsThis),
 but did not make it public.
 */
- (NSString *)mt_className;

/**
 Returns a copy of the instance with `NSKeyedArchiver` and ``NSKeyedUnarchiver``.
 Returns nil if an error occurs.
 */
- (nullable id)mt_deepCopy;

/**
 Returns a copy of the instance use archiver and unarchiver.
 Returns nil if an error occurs.
 
 @param archiver   NSKeyedArchiver class or any class inherited.
 @param unarchiver NSKeyedUnarchiver clsas or any class inherited.
 */
- (nullable id)mt_deepCopyWithArchiver:(Class)archiver unarchiver:(Class)unarchiver;

@end

NS_ASSUME_NONNULL_END
