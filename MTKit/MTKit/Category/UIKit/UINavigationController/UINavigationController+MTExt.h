//
//  UINavigationController+MTExt.h
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (MTExt)

/**
 *  @brief  寻找Navigation中的某个viewcontroler对象
 *
 *  @param className viewcontroler名称
 *
 *  @return viewcontroler对象
 */
- (id)mt_findViewController:(NSString*)className;

/**
 *  @brief  返回指定的viewcontroler
 *
 *  @param className 指定viewcontroler类名
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)mt_popToViewControllerWithClassName:(NSString*)className animated:(BOOL)animated;
/**
 *  @brief  pop n层
 *
 *  @param level  n层
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)mt_popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated;
/**
 *  push 一个不包含TabBar的控制器
 *
 *  @param viewController 控制器
 *  @param animated       动画
 */
-(void)mt_pushViewControllerHideTabBar:(UIViewController *)viewController animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END

