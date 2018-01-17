//
//  UIScrollView+MTExt.h
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (MTExt)

/**
 Scroll content to top with animation.
 */
- (void)mt_scrollToTop;

/**
 Scroll content to bottom with animation.
 */
- (void)mt_scrollToBottom;

/**
 Scroll content to left with animation.
 */
- (void)mt_scrollToLeft;

/**
 Scroll content to right with animation.
 */
- (void)mt_scrollToRight;

/**
 Scroll content to top.
 
 @param animated  Use animation.
 */
- (void)mt_scrollToTopAnimated:(BOOL)animated;

/**
 Scroll content to bottom.
 
 @param animated  Use animation.
 */
- (void)mt_scrollToBottomAnimated:(BOOL)animated;

/**
 Scroll content to left.
 
 @param animated  Use animation.
 */
- (void)mt_scrollToLeftAnimated:(BOOL)animated;

/**
 Scroll content to right.
 
 @param animated  Use animation.
 */
- (void)mt_scrollToRightAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
