//
//  MTBannerFooter.m
//  MTKit
//
//  Created by Michael on 2018/1/30.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "MTBannerFooter.h"

#define MT_ARROW_MARGIN      15.f

@implementation MTBannerFooter
@synthesize normal_title = _normal_title,
enter_title = _enter_title;

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.imgv_arrow];
        [self addSubview:self.lbl_title];
        
        self.imgv_arrow.image = [UIImage imageNamed:@"MTBanner_arrow.png"];
        self.state = MTBannerFooterStateNormal;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat arrowX = self.bounds.size.width / 2 - MT_ARROW_MARGIN - 2;
    CGFloat arrowY = self.bounds.size.height / 2 - MT_ARROW_MARGIN / 2;
    CGFloat arrowW = MT_ARROW_MARGIN;
    CGFloat arrowH = MT_ARROW_MARGIN;
    self.imgv_arrow.frame = CGRectMake(arrowX, arrowY, arrowW, arrowH);
    
    CGFloat labelX = self.bounds.size.width / 2 + 2;
    CGFloat labelY = 0;
    CGFloat labelW = MT_ARROW_MARGIN;
    CGFloat labelH = self.bounds.size.height;
    self.lbl_title.frame = CGRectMake(labelX, labelY, labelW, labelH);
}

#pragma mark - setters & getters
- (void)setState:(MTBannerFooterState)state{
    _state = state;
    
    switch (state) {
        case MTBannerFooterStateNormal:{
            self.lbl_title.text = self.normal_title;
            [UIView animateWithDuration:0.3 animations:^{
                self.imgv_arrow.transform = CGAffineTransformMakeRotation(0);
            }];
        }
            break;
        case MTBannerFooterStateEnter:{
            self.lbl_title.text = self.enter_title;
            [UIView animateWithDuration:0.3 animations:^{
                self.imgv_arrow.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }
            break;
            
        default:
            break;
    }
}

- (UIImageView *)imgv_arrow{
    if (!_imgv_arrow) {
        _imgv_arrow = [[UIImageView alloc] init];
    }
    return _imgv_arrow;
}

- (UILabel *)lbl_title{
    if (!_lbl_title) {
        _lbl_title = [[UILabel alloc] init];
        _lbl_title.font = [UIFont systemFontOfSize:13];
        _lbl_title.textColor = [UIColor darkGrayColor];
        _lbl_title.numberOfLines = 0;
        _lbl_title.adjustsFontSizeToFitWidth = YES;
    }
    return _lbl_title;
}

- (void)setNormal_title:(NSString *)normal_title{
    _normal_title = normal_title;
    
    if (self.state == MTBannerFooterStateNormal) {
        self.lbl_title.text = normal_title;
    }
}

- (NSString *)normalTitle{
    if (!_normal_title) {
        // default
        _normal_title = @"拖动查看详情";
    }
    return _normal_title;
}

- (void)setEnter_title:(NSString *)enter_title{
    _enter_title = enter_title;
    
    if (self.state == MTBannerFooterStateEnter) {
        self.lbl_title.text = enter_title;
    }
}

- (NSString *)enter_title{
    if (!_enter_title) {
        // default
        _enter_title = @"释放查看详情";
    }
    return _enter_title;
}


@end
