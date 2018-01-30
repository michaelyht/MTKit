//
//  MTQRCode.m
//  MTKit
//
//  Created by Michael on 2018/1/30.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "MTQRCode.h"
#import <AVFoundation/AVFoundation.h>
#import "MTScanBoxLine.h"

@interface MTQRCode ()<AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate, CAAnimationDelegate>
{
    BOOL _isScaning;
}
@property (nonatomic, assign) CGRect scanFrame;

@property (nonatomic, strong) ScanResultBlock resultBlock;

@property (nonatomic, weak) UIView *parentView;

//捕捉会话
@property (nonatomic, strong) AVCaptureSession *captureSession;

//展示的layer
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@property (nonatomic, strong) UIView *scanView;

@property (nonatomic, strong) CALayer *scanLineLayer;

@end



@implementation MTQRCode

- (instancetype)initWithParentView:(UIView *)parentView scanFrame:(CGRect)scanFrame result:(ScanResultBlock)result {
    self = [super init];
    if (self) {
        self.parentView = parentView;
        self.scanFrame = scanFrame;
        self.resultBlock = result;
        [self authorization];
    }
    return self;
}

- (void)authorization {
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        NSString *errorStr = @"应用相机权限受限,请在设置中启用";
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errorStr
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"去打开", nil];
#pragma clang diagnostic pop
        alert.tag = 10000;
        [alert show];
    } else {
        [self initCapture];
    }
}

- (void)initCapture {
    _scanView = [[UIView alloc] initWithFrame:self.parentView.bounds];
    [self.parentView insertSubview:_scanView atIndex:0];
    
    NSError *error;
    //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input    = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    //2.用captureDevice创建输入流
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return;
    }
    //3.创建媒体数据输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    //4.实例化捕捉会话
    _captureSession = [[AVCaptureSession alloc] init];
    _captureSession.sessionPreset = AVCaptureSessionPreset1920x1080;
    //4.1将输入流添加到会话
    [_captureSession addInput:input];
    //4.2 将媒体输出流添加到会话
    [_captureSession addOutput:captureMetadataOutput];
    //5.创建串行队列，并加媒体输出流添加到队列中
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    //5.1设置代理
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    //5.2设置输出媒体数据类型为QRCode
    [captureMetadataOutput setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    //6实例化预览图层
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    //7.设置预览图层填充方式
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //8.设置图层的frame
    [_videoPreviewLayer setFrame:_scanView.bounds];
    
    CGSize size = self.scanView.bounds.size;
    CGFloat p1 = size.height/size.width;
    CGFloat p2 = 1920./1080.;  //使用了1080p的图像输出
    if (p1 < p2) {
        CGFloat fixHeight = self.scanView.bounds.size.width * 1920. / 1080.;
        CGFloat fixPadding = (fixHeight - size.height)/2;
        captureMetadataOutput.rectOfInterest = CGRectMake((_scanFrame.origin.y + fixPadding)/fixHeight,
                                                          _scanFrame.origin.x/size.width,
                                                          _scanFrame.size.height/fixHeight,
                                                          _scanFrame.size.width/size.width);
    } else {
        CGFloat fixWidth = self.scanView.bounds.size.height * 1080. / 1920.;
        CGFloat fixPadding = (fixWidth - size.width)/2;
        CGRect rect = CGRectMake(_scanFrame.origin.y/size.height,
                                 (_scanFrame.origin.x + fixPadding)/fixWidth,
                                 _scanFrame.size.height/size.height,
                                 _scanFrame.size.width/fixWidth);
        captureMetadataOutput.rectOfInterest = rect;
    }
    //填充矩形区域，挖空扫描区域
    [self fillRect];
    [_scanView.layer addSublayer:_videoPreviewLayer];
    [self showScanBox];
}

- (void)fillRect {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0,0, _scanView.bounds.size.width, _scanView.bounds.size.height) cornerRadius:0];
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:_scanFrame];
    [path appendPath:rectPath];
    [path setUsesEvenOddFillRule:YES];
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule =kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor blackColor].CGColor;
    fillLayer.opacity =0.7;
    [_videoPreviewLayer addSublayer:fillLayer];
}

- (void)showScanBox {
    MTScanBoxLine *line1 = [MTScanBoxLine createLine2Color:self.lineColor
                                                 lineWidth:4
                                                lineLength:20
                                               cornerPoint:_scanFrame.origin
                                            cornerLocation:MTScanBoxLineLocationTopLeft];
    [self.scanView addSubview:line1];
    
    MTScanBoxLine *line2 = [MTScanBoxLine createLine2Color:self.lineColor
                                                 lineWidth:2
                                                lineLength:20
                                               cornerPoint:CGPointMake(_scanFrame.origin.x + _scanFrame.size.width, _scanFrame.origin.y)
                                            cornerLocation:MTScanBoxLineLocationTopRight];
     [self.scanView addSubview:line2];
    
    MTScanBoxLine *line3 = [MTScanBoxLine createLine2Color:self.lineColor
                                                 lineWidth:2
                                                lineLength:20
                                               cornerPoint:CGPointMake(_scanFrame.origin.x, _scanFrame.origin.y + _scanFrame.size.height)
                                            cornerLocation:MTScanBoxLineLocationBottomLeft];
    [self.scanView addSubview:line3];
    
    MTScanBoxLine *line4 = [MTScanBoxLine createLine2Color:self.lineColor
                                                 lineWidth:2
                                                lineLength:20
                                               cornerPoint:CGPointMake(_scanFrame.origin.x + _scanFrame.size.width, _scanFrame.origin.y + _scanFrame.size.height)
                                            cornerLocation:MTScanBoxLineLocationBottomRight];
    [self.scanView addSubview:line4];
    
    _scanLineLayer = [CALayer layer];
    _scanLineLayer.frame = CGRectMake(_scanFrame.origin.x, _scanFrame.origin.y, _scanFrame.size.width, 2);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, _scanFrame.size.width, 2)];
    /** 3. 设置imageView的阴影, 制造立体效果. */
    _scanLineLayer.shadowPath = path.CGPath; /**< 指定path对象. */
    _scanLineLayer.shadowOpacity = 0.5; /**< 阴影透明度.*/
    _scanLineLayer.shadowRadius = 0; /**< 阴影模糊效果的半径. */
    _scanLineLayer.shadowColor = self.lineColor.CGColor; /**< 阴影颜色.*/
    [self.scanView.layer addSublayer:_scanLineLayer];
}

- (void)startScanning {
    _isScaning = YES;
    [_captureSession startRunning];
    [self beginAnimation];
}

- (void)stopScanning {
    _isScaning = NO;
    [_captureSession stopRunning];
    [_scanLineLayer removeAnimationForKey:@"ScanAnimation"];
}

- (void)beginAnimation {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath =@"transform.translation.y";
    animation.byValue = @(self.scanFrame.size.height);
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.duration = 2.0;
    animation.repeatCount = MAXFLOAT;
    [_scanLineLayer addAnimation:animation forKey:@"ScanAnimation"];
}

- (void)openTorch {
    [self turnTorchOn:YES];
}

- (void)closeTorch {
    [self turnTorchOn:NO];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects firstObject];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            [self stopScanning];
            NSString *result = [metadataObj stringValue];
            if (self.resultBlock) {
                self.resultBlock(result);
            }
        }
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10000 && buttonIndex == 1) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

#pragma mark -
- (void)turnTorchOn:(BOOL)on
{
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}
#pragma clang diagnostic pop

#pragma mark - getter and setter
- (UIColor *)lineColor {
    if (_lineColor == nil) {
        _lineColor = [UIColor blueColor];
    }
    return _lineColor;
}

#pragma mark -
- (void)dealloc {
    [_scanLineLayer removeFromSuperlayer];
    [_videoPreviewLayer removeFromSuperlayer];
    _captureSession = nil;
    [self stopScanning];
}

@end
