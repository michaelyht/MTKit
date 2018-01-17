//
//  UILabel+MTExt.m
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "UILabel+MTExt.h"

@implementation UILabel (MTExt)

@dynamic mt_text;

- (void)setMt_text:(NSString *)mt_text {
    self.text = mt_text == nil ? @"" : mt_text;
}

@end
