//
//  MTScanBoxLine.h
//  MTKit
//
//  Created by Michael on 2018/1/30.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    MTScanBoxLineLocationTopLeft, //左上角
    MTScanBoxLineLocationTopRight, //右上角
    MTScanBoxLineLocationBottomLeft, //左下角
    MTScanBoxLineLocationBottomRight //右下角
} MTScanBoxLineLocation;

@interface MTScanBoxLine : UIView

/**
 创建扫描框的转角线
 
 @param lineColor 线条颜色
 @param lineWidth 线条宽度
 @param lineLength 线条长度
 @param cornerPoint 转角点的位置
 @param cornerLocation 角度的方向
 @return 转角线的视图
 */
+ (MTScanBoxLine *)createLine2Color:(UIColor *)lineColor
                          lineWidth:(CGFloat)lineWidth
                         lineLength:(CGFloat)lineLength
                        cornerPoint:(CGPoint)cornerPoint
                     cornerLocation:(MTScanBoxLineLocation)cornerLocation;

@end
