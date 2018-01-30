//
//  MTBannerView.h
//  MTKit
//
//  Created by Michael on 2018/1/30.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTBannerFooter.h"

@class MTBannerView;

@protocol MTBannerViewDataSource <NSObject>
@required

/**
 返回 Banner 需要显示 Item(View) 的个数
 */
- (NSInteger)mt_numberOfItemsInBannerView:(MTBannerView *)bannerView;

/**
 返回Banner中的View(无需设置 frame)
 */
- (UIView *)mt_bannerView:(MTBannerView *)bannerView viewForItemAtIndex:(NSInteger)index;

@optional

/**
 返回 Footer 在不同状态时要显示的文字 ,如果需要
 */
- (NSString *)mt_bannerView:(MTBannerView *)banner titleForFooterWithState:(MTBannerFooterState)footerState;

@end

@protocol MTBannerViewDelegate <NSObject>

/**
 点击Banner的view
 */
- (void)mt_bannerView:(MTBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index;

/**
 滚动到某个view
 */
- (void)mt_bannerView:(MTBannerView *)banner didScrollToItemAtIndex:(NSInteger)index;

/**
 释放进入下一页面
 */
- (void)mt_bannerFooterDidEnter:(MTBannerView *)banner;

@end

@interface MTBannerView : UIView

/**
 是否自动循环,默认NO
 */
@property (nonatomic, assign, getter=isCycle) IBInspectable BOOL cycle;

/**
 是否显示 footer, 默认为 NO (此属性为 YES 时, cycle 会被置为 NO)
 */
@property (nonatomic, assign, getter=isShowFooter) IBInspectable BOOL showFooter;

/**
 是否自动滑动, 默认为 NO
 */
@property (nonatomic, assign) IBInspectable BOOL autoScroll;

/**
 自动滑动间隔时间(s), 默认为 3.0
 */
@property (nonatomic, assign) IBInspectable CGFloat scrollInterval;

/**
 UIPageControl
 */
@property (nonatomic, strong, readonly) UIPageControl *pageControl;
@property (nonatomic, assign, readwrite)  CGRect pageControlFrame;

/**
 当前的item
 */
@property (nonatomic, assign) NSInteger currentIndex;

- (void)setCurrentIndex:(NSInteger)currentIndex animated:(BOOL)animated;

@property (nonatomic, weak) IBInspectable id<MTBannerViewDataSource> dataSource;
@property (nonatomic, weak) IBInspectable id<MTBannerViewDelegate> delegate;

- (void)reloadData;

@end
