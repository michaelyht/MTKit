//
//  MTBannerFooter.h
//  MTKit
//
//  Created by Michael on 2018/1/30.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MTBannerFooterState) {
    MTBannerFooterStateNormal = 0,    // 正常状态下的footer提示
    MTBannerFooterStateEnter,     // 进入下一页的footer提示
};

@interface MTBannerFooter : UICollectionReusableView

@property (nonatomic, assign) MTBannerFooterState state;

@property (nonatomic, strong) UIImageView *imgv_arrow;
@property (nonatomic, strong) UILabel *lbl_title;

@property (nonatomic, copy) NSString *normal_title;
@property (nonatomic, copy) NSString *enter_title;

@end
