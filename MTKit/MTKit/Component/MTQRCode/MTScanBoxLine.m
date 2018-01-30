//
//  MTScanBoxLine.m
//  MTKit
//
//  Created by Michael on 2018/1/30.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "MTScanBoxLine.h"

@interface MTScanBoxLine ()

@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign) CGFloat lineLength;

@property (nonatomic, assign) CGPoint cornerPoint;

@property (nonatomic, assign) MTScanBoxLineLocation cornerLocation;

@end

@implementation MTScanBoxLine

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
                     cornerLocation:(MTScanBoxLineLocation)cornerLocation {
    MTScanBoxLine *boxLine = [[MTScanBoxLine alloc] initWithLine2Color:lineColor
                                                             lineWidth:lineWidth
                                                            lineLength:lineLength
                                                           cornerPoint:cornerPoint
                                                        cornerLocation:cornerLocation];
    [boxLine setNeedsDisplay];
    return boxLine;
}

- (instancetype)initWithLine2Color:(UIColor *)lineColor
                         lineWidth:(CGFloat)lineWidth
                        lineLength:(CGFloat)lineLength
                       cornerPoint:(CGPoint)cornerPoint
                    cornerLocation:(MTScanBoxLineLocation)cornerLocation {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = [self frameByCornerLocation:cornerLocation origin:cornerPoint width:lineLength];
        self.lineColor = lineColor;
        self.lineLength = lineLength;
        self.lineWidth = lineWidth;
        self.cornerPoint = cornerPoint;
        self.cornerLocation = cornerLocation;
    }
    return self;
}

- (CGRect)frameByCornerLocation:(MTScanBoxLineLocation)cornerLocation origin:(CGPoint)origin width:(CGFloat)width {
    CGRect frame = CGRectZero;
    switch (cornerLocation) {
        case MTScanBoxLineLocationTopLeft:
            frame = CGRectMake(origin.x, origin.y, width, width);
            break;
        case MTScanBoxLineLocationBottomLeft:
            frame = CGRectMake(origin.x, origin.y - width, width, width);
            break;
        case MTScanBoxLineLocationTopRight:
            frame = CGRectMake(origin.x - width, origin.y, width, width);
            break;
        case MTScanBoxLineLocationBottomRight:
            frame = CGRectMake(origin.x - width, origin.y - width, width, width);
            break;
        default:
            break;
    }
    return frame;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.lineWidth);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor); //线的颜色
    CGContextBeginPath(context);
    
    [self drawLineByContext:context];
}

- (void)drawLineByContext:(CGContextRef)context {
    CGPoint startPoint = CGPointZero;
    CGPoint xEndPoint = CGPointZero;
    CGPoint yEndPoint = CGPointZero;
    switch (self.cornerLocation) {
        case MTScanBoxLineLocationTopLeft:
        {
            startPoint = CGPointZero;
            xEndPoint = CGPointMake(self.lineLength, 0);
            yEndPoint = CGPointMake(0, self.lineLength);
        }
            break;
        case MTScanBoxLineLocationBottomLeft:
        {
            startPoint = CGPointMake(0, self.bounds.size.height);
            xEndPoint = CGPointMake(self.lineLength, self.bounds.size.height);
            yEndPoint = CGPointMake(0, self.bounds.size.height - self.lineLength);
        }
            break;
        case MTScanBoxLineLocationTopRight:
        {
            startPoint = CGPointMake(self.bounds.size.width, 0);
            xEndPoint = CGPointMake(self.bounds.size.width - self.lineLength, 0);
            yEndPoint = CGPointMake(self.bounds.size.width, self.lineLength);
        }
            break;
        case MTScanBoxLineLocationBottomRight:
        {
            startPoint = CGPointMake(self.bounds.size.width, self.bounds.size.height);
            xEndPoint = CGPointMake(self.bounds.size.width - self.lineLength, self.bounds.size.height);
            yEndPoint = CGPointMake(self.bounds.size.width, self.bounds.size.height - self.lineLength);
        }
            break;
        default:
            break;
    }
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);  //起点坐标
    CGContextAddLineToPoint(context, xEndPoint.x, xEndPoint.y); // X 终点坐标
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);  //起点坐标
    CGContextAddLineToPoint(context, yEndPoint.x, yEndPoint.y);   // Y 终点坐标
    CGContextStrokePath(context);
}

@end
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

