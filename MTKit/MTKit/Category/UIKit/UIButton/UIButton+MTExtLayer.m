//
//  UIButton+MTExtLayer.m
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "UIButton+MTExtLayer.h"

@implementation UIButton (MTExtLayer)

- (void)setMt_cornerRadius:(CGFloat)mt_cornerRadius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = mt_cornerRadius;
}

- (CGFloat)mt_cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setMt_borderWidth:(CGFloat)mt_borderWidth {
    self.layer.borderWidth = mt_borderWidth;
}

- (CGFloat)mt_borderWidth {
    return self.layer.borderWidth;
}

- (void)setMt_borderColor:(UIColor *)mt_borderColor {
    self.layer.borderColor = mt_borderColor.CGColor;
}

- (UIColor *)mt_borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

@end
