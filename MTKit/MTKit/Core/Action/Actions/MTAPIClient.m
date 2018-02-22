//
//  MTAPIClient.m
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "MTAPIClient.h"

@interface MTAPIClient ()

@property (nonatomic, strong) MT_Reachability *reach;

@property (nonatomic, strong) MT_Reachability *internetReachability;

@end

static NSString * const AFAppDotNetAPIBaseURLString = @"www.baidu.com";

@implementation MTAPIClient
+ (instancetype)sharedClient {
    static MTAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[MTAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    // [self.requestSerializer setAuthorizationHeaderFieldWithUsername:@"XYZ" password:@"xyzzzz"];
    self.requestSerializer                         = [AFHTTPRequestSerializer serializer];
    //    self.responseSerializer                        = [AFJSONResponseSerializer serializer];
    self.requestSerializer.timeoutInterval         = 20.0;
    self.reach = [MT_Reachability reachabilityWithHostName:AFAppDotNetAPIBaseURLString];
    //    self.securityPolicy = [self customSecurityPolicy];
    return self;
}

#pragma mark - custom

- (BOOL)isReachable {
    MTNetworkStatus status = [_reach currentReachabilityStatus];
    BOOL isReachable = NO;
    switch (status)
    {
        case MTNotReachable:
            isReachable = NO;
            _netWorkStatus = MTNotReachable;
            break;
        case MTReachableViaWWAN:
            isReachable = YES;
            _netWorkStatus = MTReachableViaWWAN;
            break;
        case MTReachableViaWiFi:
            isReachable = YES;
            _netWorkStatus = MTReachableViaWiFi;
            break;
        default:
            break;
    }
    return isReachable;
}

- (void)reachabilityChanged:(NSNotification *)notification {
    MT_Reachability* curReach = [notification object];
    NSParameterAssert([curReach isKindOfClass:[MT_Reachability class]]);
    [self reachability:curReach];
}

#pragma mark - private
- (void)reachability:(MT_Reachability *)reachability
{
    MTNetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];
    NSString* statusString = @"";
    switch (netStatus)
    {
        case MTNotReachable:        {
            statusString = @"网络连接不可用";
            connectionRequired = NO;
            break;
        }
            
        case MTReachableViaWWAN:        {
            connectionRequired = YES;
            statusString = @"蜂窝移动网络";
            break;
        }
        case MTReachableViaWiFi:        {
            connectionRequired = YES;
            statusString= @"WIFI网络";
            break;
        }
    }
    if (connectionRequired)
    {
        NSString *connectionRequiredFormatString = NSLocalizedString(@"%@, Connection Required", @"Concatenation of status string with connection requirement");
        statusString= [NSString stringWithFormat:connectionRequiredFormatString, statusString];
    }
    
}

- (AFSecurityPolicy*)customSecurityPolicy {
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"ziyouzhao" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
    
    return securityPolicy;
}

#pragma mark - seMTers, geMTers
- (void)setIsDetectNetwork:(BOOL)isDetectNetwork {
    _isDetectNetwork = isDetectNetwork;
    if (isDetectNetwork) {
        if (_internetReachability == nil) {
            _internetReachability = [MT_Reachability reachabilityForInternetConnection];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(reachabilityChanged:)
                                                         name:kmt_ReachabilityChangedNotification
                                                       object:nil];
        }
        [_internetReachability startNotifier];
    } else {
        [_internetReachability stopNotifier];
    }
}

- (MTNetworkStatus)netWorkStatus {
    BOOL b = [self isReachable];
    if (b) {
        return _netWorkStatus;
    }
    return MTNotReachable;
}
@end
