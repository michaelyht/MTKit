//
//  UIScrollView+MTExt.m
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "UIScrollView+MTExt.h"

@implementation UIScrollView (MTExt)

/**
 Scroll content to top with animation.
 */
- (void)mt_scrollToTop {
    [self mt_scrollToTopAnimated:YES];
}

/**
 Scroll content to bottom with animation.
 */
- (void)mt_scrollToBottom {
    [self mt_scrollToBottomAnimated:YES];
}

/**
 Scroll content to left with animation.
 */
- (void)mt_scrollToLeft {
    [self mt_scrollToLeftAnimated:YES];
}

/**
 Scroll content to right with animation.
 */
- (void)mt_scrollToRight {
    [self mt_scrollToRightAnimated:YES];
}

/**
 Scroll content to top.
 
 @param animated  Use animation.
 */
- (void)mt_scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

/**
 Scroll content to bottom.
 
 @param animated  Use animation.
 */
- (void)mt_scrollToBottomAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

/**
 Scroll content to left.
 
 @param animated  Use animation.
 */
- (void)mt_scrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

/**
 Scroll content to right.
 
 @param animated  Use animation.
 */
- (void)mt_scrollToRightAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}

@end
