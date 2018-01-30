//
//  MTBannerView.m
//  MTKit
//
//  Created by Michael on 2018/1/30.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "MTBannerView.h"
#import "MTBannerCell.h"

// 总共的item数
#define MT_TOTAL_ITEMS (self.itemCount * 10000)

#define MT_FOOTER_WIDTH 64.0
#define MT_PAGE_CONTROL_HEIGHT 32.0

@interface MTBannerView ()<UICollectionViewDelegate, UICollectionViewDataSource>


@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) MTBannerFooter *footer;
@property (nonatomic, strong, readwrite) UIPageControl *pageControl;

@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, strong) NSTimer *timer;

@end

static NSString *BANNER_ITEM = @"BANNER_ITEM";
static NSString *BANNER_FOOTER = @"BANNER_FOOTER";

@implementation MTBannerView
@synthesize scrollInterval = _scrollInterval;
@synthesize autoScroll = _autoScroll;
@synthesize cycle =_cycle;
@synthesize showFooter = _showFooter;
@synthesize pageControl = _pageControl;



#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self updateSubviewsFrame];
}

#pragma mark - CustomMethod
- (void)reloadData{
    if (!self.dataSource || self.itemCount == 0) {
        return;
    }
    
    // 设置pageControl总页数
    self.pageControl.numberOfPages = self.itemCount;
    
    // 刷新数据
    [self.collectionView reloadData];
    
    // 开启定时器
    [self starMTimer];
}

/**
 *  当前 item 的 index
 */
- (void)setCurrentIndex:(NSInteger)currentIndex animated:(BOOL)animated{
    if (self.isCycle) {
        NSIndexPath *oldCurrentIndexPath = [[self.collectionView indexPathsForVisibleItems] firstObject];
        NSUInteger oldCurrentIndex = oldCurrentIndexPath.item;
        NSUInteger newCurrentIndex = oldCurrentIndex - oldCurrentIndex % self.itemCount + currentIndex;
        if(newCurrentIndex >= MT_TOTAL_ITEMS) {
            return;
        }
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:newCurrentIndex inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionLeft
                                            animated:animated];
        [self didScrollItemAtIndex:newCurrentIndex % self.itemCount];
    } else {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:currentIndex inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionLeft
                                            animated:animated];
        [self didScrollItemAtIndex:currentIndex];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.isCycle) {
        return MT_TOTAL_ITEMS;
    } else {
        return self.itemCount;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MTBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BANNER_ITEM forIndexPath:indexPath];
    if ([self.dataSource respondsToSelector:@selector(mt_bannerView:viewForItemAtIndex:)]) {
        cell.containerView = [self.dataSource mt_bannerView:self viewForItemAtIndex:indexPath.item % self.itemCount];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)theCollectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)theIndexPath{
    UICollectionReusableView *footer = nil;
    
    if(kind == UICollectionElementKindSectionFooter) {
        footer = [theCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:BANNER_FOOTER forIndexPath:theIndexPath];
        self.footer = (MTBannerFooter *)footer;
        
        // 配置footer的提示语
        if ([self.dataSource respondsToSelector:@selector(mt_bannerView:titleForFooterWithState:)]) {
            self.footer.normal_title = [self.dataSource mt_bannerView:self titleForFooterWithState:MTBannerFooterStateNormal];
            self.footer.enter_title = [self.dataSource mt_bannerView:self titleForFooterWithState:MTBannerFooterStateEnter];
        }
        
        self.footer.bounds = CGRectMake(0, 0, MT_FOOTER_WIDTH, self.bounds.size.height);
    }
    
    if (self.showFooter) {
        self.footer.hidden = NO;
    } else {
        self.footer.hidden = YES;
    }
    
    return footer;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(mt_bannerView:didSelectItemAtIndex:)]) {
        [self.delegate mt_bannerView:self didSelectItemAtIndex:(indexPath.item % self.itemCount)];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *currentIndexPath = [[collectionView indexPathsForVisibleItems] firstObject];
    if (currentIndexPath) {
        [self didScrollItemAtIndex:currentIndexPath.item % self.itemCount];
    }
}

#pragma mark - UIScrollViewDelegate
#pragma mark timer相关

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 用户滑动的时候停止定时器
    [self stopTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 用户停止滑动的时候开启定时器
    [self starMTimer];
}


#pragma mark footer相关
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.showFooter) return;
    
    static CGFloat lastOffset;
    CGFloat footerDisplayOffset = (scrollView.contentOffset.x - (self.frame.size.width * (self.itemCount - 1)));
    
    // footer的动画
    if (footerDisplayOffset > 0) {
        // 开始出现footer
        if (footerDisplayOffset > MT_FOOTER_WIDTH) {
            if (lastOffset > 0) return;
            self.footer.state = MTBannerFooterStateEnter;
        } else {
            if (lastOffset < 0) return;
            self.footer.state = MTBannerFooterStateNormal;
        }
        lastOffset = footerDisplayOffset - MT_FOOTER_WIDTH;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!self.showFooter) return;
    
    CGFloat footerDisplayOffset = (scrollView.contentOffset.x - (self.frame.size.width * (self.itemCount - 1)));
    
    // 通知footer代理
    if (footerDisplayOffset > MT_FOOTER_WIDTH) {
        if ([self.delegate respondsToSelector:@selector(mt_bannerFooterDidEnter:)]) {
            [self.delegate mt_bannerFooterDidEnter:self];
        }
    }
}

#pragma mark - private method
- (void)commonInit{
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
}

- (void)updateSubviewsFrame{
    // collectionView
    self.flowLayout.itemSize = self.bounds.size;
    self.flowLayout.footerReferenceSize = CGSizeMake(MT_FOOTER_WIDTH, self.frame.size.height);
    self.collectionView.frame = self.bounds;
    [self.collectionView reloadData];
    
    // pageControl
    if (CGRectEqualToRect(self.pageControlFrame, CGRectZero)) {
        // 若未对pageControl设置过frame, 则使用以下默认frame
        CGFloat w = self.frame.size.width;
        CGFloat h = MT_PAGE_CONTROL_HEIGHT;
        CGFloat x = 0;
        CGFloat y = self.frame.size.height - h;
        self.pageControl.frame = CGRectMake(x, y, w, h);
    }
    [self fixDefaultPosition];
}

/**
 配置默认起始位置
 */
- (void)fixDefaultPosition{
    if (self.itemCount == 0) {
        return;
    }
    
    if (self.isCycle) {
        // 总item数的中间
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:(MT_TOTAL_ITEMS / 2) inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        [self didScrollItemAtIndex:0];
    } else {
        // 第0个item
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        [self didScrollItemAtIndex:0];
    }
}

- (void)didScrollItemAtIndex:(NSInteger)index{
    self.pageControl.currentPage = index;
    
    if ([self.delegate respondsToSelector:@selector(mt_bannerView:didScrollToItemAtIndex:)]) {
        [self.delegate mt_bannerView:self didScrollToItemAtIndex:index];
    }
}

// 定时器方法
- (void)autoScrollToNextItem{
    if (self.itemCount == 0 ||
        self.itemCount == 1 ||
        !self.autoScroll) {
        return;
    }
    
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] firstObject];
    NSUInteger currentItem = currentIndexPath.item;
    NSUInteger nextItem = currentItem + 1;
    
    if(nextItem >= MT_TOTAL_ITEMS) {
        return;
    }
    
    if (self.isCycle) {
        // 无限往下翻页
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextItem inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionLeft
                                            animated:YES];
    } else {
        if ((currentItem % self.itemCount) == self.itemCount - 1) {
            // 当前最后一张, 回到第0张
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]
                                        atScrollPosition:UICollectionViewScrollPositionLeft
                                                animated:YES];
        } else {
            // 往下翻页
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextItem inSection:0]
                                        atScrollPosition:UICollectionViewScrollPositionLeft
                                                animated:YES];
        }
    }
}

#pragma mark - NSTimer

- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)starMTimer{
    if (!self.autoScroll) return;
    
    [self stopTimer];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollInterval
                                                  target:self
                                                selector:@selector(autoScrollToNextItem)
                                                userInfo:nil
                                                 repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark - getter and setter
/**
 *  数据源
 */
- (void)setDataSource:(id<MTBannerViewDataSource>)dataSource{
    _dataSource = dataSource;
    
    // 刷新数据
    [self reloadData];
    
    // 配置默认起始位置
    [self fixDefaultPosition];
}

- (void)setDelegate:(id<MTBannerViewDelegate>)delegate {
    _delegate = delegate;
    
    [self reloadData];
}

- (NSInteger)itemCount{
    if ([self.dataSource respondsToSelector:@selector(mt_numberOfItemsInBannerView:)]) {
        return [self.dataSource mt_numberOfItemsInBannerView:self];
    }
    return 0;
}

/**
 *  是否需要循环滚动
 */
- (void)setCycle:(BOOL)cycle {
    _cycle = cycle;
    
    [self reloadData];
    
    // 重置默认起始位置
    [self fixDefaultPosition];
}

- (BOOL)isCycle {
    if (self.showFooter) {
        // 如果footer存在就不应该有循环滚动
        return NO;
    }
    if (self.itemCount == 1) {
        // 只有一个item也不应该有循环滚动
        return NO;
    }
    return _cycle;
}

/**
 *  是否显示footer
 */
- (void)setShowFooter:(BOOL)showFooter {
    _showFooter = showFooter;
    [self reloadData];
}

- (BOOL)isShowFooter {
    return _showFooter;
}

- (void)setAutoScroll:(BOOL)autoScroll {
    _autoScroll = autoScroll;
    if (autoScroll) {
        [self starMTimer];
    } else {
        [self stopTimer];
    }
}

- (BOOL)autoScroll
{
    if (self.itemCount < 2) {
        // itemCount小于2时, 禁用自动滚动
        return NO;
    }
    return _autoScroll;
}

- (void)setScrollInterval:(CGFloat)scrollInterval {
    _scrollInterval = scrollInterval;
    [self starMTimer];
}

- (CGFloat)scrollInterval{
    return _scrollInterval == 0 ? 3 : _scrollInterval;
}

/**
 *  重写设置背景颜色
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    
    self.collectionView.backgroundColor = backgroundColor;
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    [self setCurrentIndex:currentIndex animated:NO];
}

- (NSInteger)currentIndex{
    return self.pageControl.currentPage;
}

/**
 *  collectionView
 */
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.pagingEnabled = YES;
        _collectionView.alwaysBounceHorizontal = YES; // 小于等于一页时, 允许bounce
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollsToTop = NO;
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        // 注册cell
        [_collectionView registerClass:[MTBannerCell class] forCellWithReuseIdentifier:BANNER_ITEM];
        
        // 注册 \ 配置footer
        [_collectionView registerClass:[MTBannerFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:BANNER_FOOTER];
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, - MT_FOOTER_WIDTH);
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.sectionInset = UIEdgeInsetsZero;
        _flowLayout.footerReferenceSize = CGSizeMake(MT_FOOTER_WIDTH, 100);
    }
    return _flowLayout;
}

/**
 *  pageControl
 */
- (void)setPageControl:(UIPageControl *)pageControl{
    // 移除旧oageControl
    [_pageControl removeFromSuperview];
    
    // 赋值
    _pageControl = pageControl;
    
    // 添加新pageControl
    _pageControl.userInteractionEnabled = NO;
    _pageControl.autoresizingMask = UIViewAutoresizingNone;
    _pageControl.backgroundColor = [UIColor redColor];
    [self addSubview:_pageControl];
    
    [self reloadData];
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.autoresizingMask = UIViewAutoresizingNone;
    }
    return _pageControl;
}

- (void)setPageControlFrame:(CGRect)pageControlFrame{
    _pageControlFrame = pageControlFrame;
    
    self.pageControl.frame = pageControlFrame;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
