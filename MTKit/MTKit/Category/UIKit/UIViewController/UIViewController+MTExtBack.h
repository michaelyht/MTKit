//
//  UIViewController+MTExtBack.h
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIViewController (MTExtBack)

#pragma mark - UINavigationController

- (void)mt_pop;

- (void)mt_popToAnimated:(BOOL)animated;

- (void)mt_popToViewController:(NSString *)vcName;

- (void)mt_popToViewController:(NSString *)vcName animated:(BOOL)animated;

- (void)mt_pushViewController:(UIViewController *)viewController;

- (void)mt_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
