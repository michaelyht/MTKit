//
//  MTQRCode.h
//  MTKit
//
//  Created by Michael on 2018/1/30.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ScanResultBlock)(NSString *result);

@interface MTQRCode : NSObject

- (instancetype)initWithParentView:(UIView *)parentView scanFrame:(CGRect)scanFrame result:(ScanResultBlock)result;

- (void)startScanning;

- (void)stopScanning;

@property (nonatomic, strong) UIColor *lineColor;

- (void)openTorch;

- (void)closeTorch;

@end
