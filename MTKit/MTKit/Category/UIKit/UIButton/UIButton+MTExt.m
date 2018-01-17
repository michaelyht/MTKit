//
//  UIButton+MTExt.m
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "UIButton+MTExt.h"
#import <objc/runtime.h>

static const NSString *kTouchUpInsideEvent;

@implementation UIButton (MTExt)

/**
 创建Button
 
 @param frame frame
 @param title 标题 - Normal
 @param touchUpInsideEvent 点击事件
 @return 创建好的Button
 */
+ (UIButton *)mt_createWithFrame:(CGRect)frame
                           title:(NSString *)title
              touchUpInsideEvent:(TouchUpInsideEvent)touchUpInsideEvent {
    return [self mt_createWithFrame:frame title:title image:nil touchUpInsideEvent:touchUpInsideEvent];
}

/**
 创建Button
 
 @param frame frame
 @param title 标题 - Normal
 @param image 图片
 @param touchUpInsideEvent 点击事件
 @return 创建好的Button
 */
+ (UIButton *)mt_createWithFrame:(CGRect)frame
                           title:(NSString *)title
                           image:(nullable UIImage *)image
              touchUpInsideEvent:(TouchUpInsideEvent)touchUpInsideEvent {
    return [self mt_createWithFrame:frame title:title image:image tag:0 touchUpInsideEvent:touchUpInsideEvent];
}

/**
 创建button
 
 @param frame frame
 @param title 标题 - Normal
 @param image 图片
 @param touchUpInsideEvent 点击事件
 @return 创建好的Button
 */
+ (UIButton *)mt_createWithFrame:(CGRect)frame
                           title:(NSString *)title
                           image:(nullable UIImage *)image
                             tag:(NSInteger)tag
              touchUpInsideEvent:(TouchUpInsideEvent)touchUpInsideEvent {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.frame = frame;
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    if (image != nil) {
        [button setImage:image forState:UIControlStateNormal];
    }
    [button addTarget:button action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.touchUpInsideEvent = touchUpInsideEvent;
    return button;
}

/**
 *  设置高亮图片
 *
 *  @param image 高亮图片
 */
- (void)mt_setHighlightedImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateHighlighted];
}

/**
 *  返回高亮图片
 *
 *  @return 高亮图片
 */
- (UIImage *)mt_highlightedImage {
    return [self imageForState:UIControlStateHighlighted];
}

/**
 *  设置普通图片
 *
 *  @param image 普通图片
 */
- (void)mt_setNormalImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
}

/**
 *  返回普通图片
 *
 *  @return 普通图片
 */
- (UIImage *)mt_normalImage {
    return [self imageForState:UIControlStateNormal];
}

/**
 *  设置选中的图片
 *
 *  @param image 选中的图片
 */
- (void)mt_setSelectedImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateSelected];
}

/**
 *  返回选中的图片
 *
 *  @return 选中的图片
 */
- (UIImage *)mt_selectedImage {
    return [self imageForState:UIControlStateSelected];
}


/**
 *  @brief  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)mt_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}

/**
 设置下划线,颜色跟按钮颜色一致
 */
- (void)mt_setUnderLine {
    NSString *btnTitle = [self titleForState:UIControlStateNormal];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:btnTitle];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    [title addAttribute:NSForegroundColorAttributeName value:[self titleColorForState:UIControlStateNormal] range:titleRange];
    [self setAttributedTitle:title
                    forState:UIControlStateNormal];
}

#pragma mark - 点击热区
- (UIEdgeInsets)mt_touchAreaInsets{
    return [objc_getAssociatedObject(self, @selector(mt_touchAreaInsets)) UIEdgeInsetsValue];
}

/**
 *  @brief  设置按钮额外热区
 */
- (void)setMt_touchAreaInsets:(UIEdgeInsets)touchAreaInsets{
    NSValue *value = [NSValue valueWithUIEdgeInsets:touchAreaInsets];
    objc_setAssociatedObject(self, @selector(mt_touchAreaInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    UIEdgeInsets touchAreaInsets = self.mt_touchAreaInsets;
    CGRect bounds = self.bounds;
    bounds = CGRectMake(bounds.origin.x - touchAreaInsets.left,
                        bounds.origin.y - touchAreaInsets.top,
                        bounds.size.width + touchAreaInsets.left + touchAreaInsets.right,
                        bounds.size.height + touchAreaInsets.top + touchAreaInsets.bottom);
    return CGRectContainsPoint(bounds, point);
}

#pragma mark - private
+ (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (TouchUpInsideEvent)touchUpInsideEvent {
    TouchUpInsideEvent touchUpInsideEvent = objc_getAssociatedObject(self, &kTouchUpInsideEvent);
    return touchUpInsideEvent;
}

- (void)setTouchUpInsideEvent:(TouchUpInsideEvent)touchUpInsideEvent {
    objc_setAssociatedObject(self, &kTouchUpInsideEvent, touchUpInsideEvent, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)buttonPressed:(UIButton *)button {
    if (self.touchUpInsideEvent) {
        self.touchUpInsideEvent(button);
    }
}

@end

