//
//  UITextView+MTExt.h
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT double UITextView_PlaceholderVersionNumber;
FOUNDATION_EXPORT const unsigned char UITextView_PlaceholderVersionString[];

@interface UITextView (MTExt)

@property (nonatomic, strong) IBInspectable NSString *mt_placeholder;
@property (nonatomic, strong) NSAttributedString *mt_attributedPlaceholder;
@property (nonatomic, strong) IBInspectable UIColor *mt_placeholderColor;

+ (UIColor *)mt_defaultPlaceholderColor;


@end
