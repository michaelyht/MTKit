//
//  MTAlertUtil.m
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "MTAlertUtil.h"
#import <objc/runtime.h>
#import "NSString+MTExt.h"

//#define IOS8Later [[[UIDevice currentDevice] systemVersion] doubleValue] > 8.0
//
//const char *MTAlertSheet_Block = "MTAlertSheet_Block";
//
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//@interface UIAlertView (MTAlertView)
//
//- (void)setClickBlock:(ClickAtIndexBlock)block;
//- (ClickAtIndexBlock)clickBlock;
//
//@end
//
//@implementation UIAlertView (MTAlertView)
//
//- (void)setClickBlock:(ClickAtIndexBlock)block {
//    objc_setAssociatedObject(self, MTAlertSheet_Block, block, OBJC_ASSOCIATION_COPY);
//}
//- (ClickAtIndexBlock)clickBlock {
//    return objc_getAssociatedObject(self, MTAlertSheet_Block);
//}
//
//@end
//
//
//@interface UIActionSheet (MTActionSheet)
//
//- (void)setClickBlock:(ClickAtIndexBlock)block;
//- (ClickAtIndexBlock)clickBlock;
//
//@end
//
//@implementation UIActionSheet (MTActionSheet)
//-(void)setClickBlock:(ClickAtIndexBlock)block {
//    objc_setAssociatedObject(self, MTAlertSheet_Block, block, OBJC_ASSOCIATION_COPY);
//}
//-(ClickAtIndexBlock)clickBlock {
//    return objc_getAssociatedObject(self, MTAlertSheet_Block);
//}
//@end

@implementation MTAlertUtil
#pragma mark - alert
+ (void)showAlertWithTitle:(NSString*)title message:(NSString *)messge cancleButtonTitle:(NSString *)cancleButtonTitle OtherButtonsArray:(NSArray*)otherButtons showInController:(UIViewController *)controller clickAtIndex:(ClickAtIndexBlock) clickAtIndex {
    //add at 2018.5.31
    if (!controller) {
        return;
    }
//    if (IOS8Later && controller != nil) {
    int index = 0;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:messge preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancleButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        clickAtIndex(index);
    }];
    [alert addAction:cancel];
    for (NSString *otherTitle in otherButtons) {
        index ++;
        UIAlertAction *action = [UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            clickAtIndex(index);
        }];
        [alert addAction:action];
    }
    [controller presentViewController:alert animated:YES completion:nil];
//    } else {
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//        UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:title message:messge delegate:self cancelButtonTitle:cancleButtonTitle otherButtonTitles: nil];
//#pragma clang diagnostic pop
//        alert.clickBlock = clickAtIndex;
//        for (NSString *otherTitle in otherButtons) {
//            [alert addButtonWithTitle:otherTitle];
//        }
//        [alert show];
//    }
}

//#pragma mark UIAlertViewDelegate
//
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//+(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    if (alertView.clickBlock) {
//        alertView.clickBlock(buttonIndex);
//    }
//}
//#pragma clang diagnostic pop


#pragma mark - actionSheet
+ (UIAlertController *)showActionSheetWithTitle:(NSString*)title message:(NSString *)messge cancleButtonTitle:(NSString *)cancleButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle OtherButtonsArray:(NSArray*)otherButtons showInController:(UIViewController *)controller clickAtIndex:(ClickAtIndexBlock) clickAtIndex {
    //add at 2018.5.31
    if (!controller) {
        return nil;
    }
//    if (IOS8Later && controller != nil) {
    int index = 0;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:messge preferredStyle:UIAlertControllerStyleActionSheet];
    if ([destructiveButtonTitle mt_isNotEmpty]) {
        UIAlertAction *destructive = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            clickAtIndex(index);
        }];
        [alert addAction:destructive];
    }
    index++;
    if ([cancleButtonTitle mt_isNotEmpty]) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancleButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            clickAtIndex(index);
        }];
        [alert addAction:cancel];
    }
    for (NSString *otherTitle in otherButtons) {
        index ++;
        UIAlertAction *action = [UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            clickAtIndex(index);
        }];
        [alert addAction:action];
    }
    [controller presentViewController:alert animated:YES completion:nil];
    return alert;
//    } else {
//        UIActionSheet *alert = [[UIActionSheet alloc] initWithTitle:title delegate:[self self] cancelButtonTitle:cancleButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
//        alert.clickBlock = clickAtIndex;
//        for (NSString *otherTitle in otherButtons) {
//            [alert addButtonWithTitle:otherTitle];
//        }
//        if (controller != nil) {
//            [alert showInView:controller.view];
//        } else {
//            [alert showInView:[UIApplication sharedApplication].keyWindow];
//        }
//        return nil;
//    }
}

//+ (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
//    actionSheet.clickBlock(buttonIndex);
//}
@end

//#pragma clang diagnostic pop
