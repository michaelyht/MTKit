//
//  MTConstants.m
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "MTConstants.h"

#define kAPIReturnCode @"APIReturnCode"
#define kAPIReturnData @"APIReturnData"
#define kAPIReturnMsg @"APIReturnMsg"
#define kAPIReturnCodeSuccess @"APIReturnCodeSuccess"

#define APIDefaultReturnCode @"code"
#define APIDefaultReturnData @"data"
#define APIDefaultReturnMsg @"msg"
#define APIDefaultReturnCodeSuccess @"1"

#define kSignSaltStarIndex @"SignSaltStartIndex"
#define kSignSaltLength @"SignSaltLength"
#define kSigntureKey @"SignatureKey"
#define kSignLoginName @"SignLoginName"
#define kSignLoginPwd @"SignLoginPwd"

#define SignDefaultSaltStarIndex @"7"
#define SignDefaultSaltLength @"3"
#define SignDefaultKey @"TQSignature"
#define SignDefaultLoginNameKey @"SignLoginName"
#define SignDefaultLoginPwdKey @"SignLoginPwd"

@implementation MTConstants

static MTConstants *sharedInstance = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MTConstants alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        NSString *apiFilePath = [[NSBundle mainBundle] pathForResource:@"TQ_Config" ofType:@"plist"];
        NSMutableDictionary *apiData = [[NSMutableDictionary alloc] initWithContentsOfFile:apiFilePath];
        [self setApiDataOfDic:apiData[@"APIRetrunInfo"]];
        
        NSString *signFilePath = [[NSBundle mainBundle] pathForResource:@"TQ_Signature" ofType:@"plist"];
        NSMutableDictionary *signData = [[NSMutableDictionary alloc] initWithContentsOfFile:signFilePath];
        [self setSignatureDataOfDic:signData];
    }
    return self;
}


#pragma mark - API_Return_Data
- (void)setApiDataOfDic:(NSDictionary *)apiData {
    if (apiData == nil) {
        [self setApiDataDefault];
        return;
    }
    _apiReturnCode = setData(apiData[kAPIReturnCode], APIDefaultReturnCode);
    _apiReturnData = setData(apiData[kAPIReturnData], APIDefaultReturnData);
    _apiReturnMsg = setData(apiData[kAPIReturnMsg], APIDefaultReturnMsg);
    _apiReturnCodeSuccess = [setData(apiData[kAPIReturnCodeSuccess], APIDefaultReturnCodeSuccess) integerValue];
}

- (void)setApiDataDefault {
    _apiReturnCode = APIDefaultReturnCode;
    _apiReturnMsg = APIDefaultReturnMsg;
    _apiReturnData = APIDefaultReturnData;
    _apiReturnCodeSuccess = [APIDefaultReturnCodeSuccess integerValue];
}

#pragma mark - Signature

- (void)setSignatureDataOfDic:(NSDictionary *)signData {
    if (signData == nil) {
        [self setSignDataDefault];
        return;
    }
    _signatureKey = setData(signData[kSigntureKey], SignDefaultKey);
    _signSaltStartIndex = [setData(signData[kSignSaltStarIndex], SignDefaultSaltStarIndex) integerValue];
    _signSaltLength = [setData(signData[kSignSaltLength], SignDefaultSaltLength) integerValue];
    _signLoginNameKey = setData(signData[kSignLoginName], SignDefaultLoginNameKey);
    _signLoginPwdKey = setData(signData[kSignLoginPwd], SignDefaultLoginPwdKey);
}

- (void)setSignDataDefault {
    _signatureKey = SignDefaultKey;
    _signSaltStartIndex = [SignDefaultSaltStarIndex integerValue];
    _signSaltLength = [SignDefaultSaltLength integerValue];
    _signLoginNameKey = SignDefaultLoginNameKey;
    _signLoginPwdKey = SignDefaultLoginPwdKey;
}

#pragma mark - private
NSString * setData(NSString *obj, NSString *defaultValue) {
    if (obj == nil || [obj isEqualToString:@""]) {
        return defaultValue;
    }
    return obj;
}

@end
