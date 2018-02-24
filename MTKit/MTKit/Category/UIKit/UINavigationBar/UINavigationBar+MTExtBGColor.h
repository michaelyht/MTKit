//
//  UINavigationBar+MTExtBGColor.h
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (MTExtBGColor)

@property (nonatomic, strong) UIView *overlay;

- (void)mt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)mt_setElementsAlpha:(CGFloat)alpha;
- (void)mt_setTranslationY:(CGFloat)translationY;
- (void)mt_reset;

@end
