//
//  UIViewController+MTExtBack.m
//  MTKit
//
//  Created by Michael on 2018/1/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "UIViewController+MTExtBack.h"

@implementation UIViewController (MTExtBack)

#pragma mark - UINavigationController

- (void)mt_pop {
    [self mt_popToAnimated:YES];
}

- (void)mt_popToAnimated:(BOOL)animated {
    [self.navigationController popViewControllerAnimated:animated];
}

- (void)mt_popToViewController:(NSString *)vcName {
    [self.navigationController popToViewController:[self findViewController:vcName] animated:YES];
}

- (void)mt_popToViewController:(NSString *)vcName animated:(BOOL)animated {
    [self.navigationController popToViewController:[self findViewController:vcName] animated:animated];
}

- (void)mt_pushViewController:(UIViewController *)viewController {
    [self mt_pushViewController:viewController animated:YES];
}

- (void)mt_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.navigationController pushViewController:viewController animated:animated];
}

#pragma mark - private
- (id)findViewController:(NSString*)className {
    for (UIViewController *viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:NSClassFromString(className)]) {
            return viewController;
        }
    }
    return nil;
}

@end
