//
//  MTBannerCell.m
//  MTKit
//
//  Created by Michael on 2018/1/30.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "MTBannerCell.h"

@implementation MTBannerCell
@synthesize containerView = _containerView;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.containerView.frame = self.bounds;
}

#pragma mark - getters、setters
- (UIView *)containerView {
    if (_containerView == nil) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

- (void)setContainerView:(UIView *)containerView {
    if (_containerView) {
        [_containerView removeFromSuperview];
    }
    _containerView = containerView;
    [self addSubview:_containerView];
}


@end
