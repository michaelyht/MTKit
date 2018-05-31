//
//  MTHttpAction.m
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "MTHttpAction.h"
#import "MTAPIClient.h"
#import "MTProgressHUD.h"
#import "MT_CategoryHeader.h"
#import "YYCache.h"
#import <math.h>

#define ErrorCode -9999
#define ErrorCodeMsg @"ErrorCode配置错误"

typedef enum : NSUInteger {
    Http_Post,
    Http_Get,
} HttpMethodType;

@interface MTHttpAction()

@property (nonatomic, strong) NSMutableArray *arr_sessionTask;

@property (nonatomic, strong) YYCache *cache;

@property (nonatomic, strong) MTConstants *mtConstants;

@property (nonatomic, assign) NSInteger apiReturnCodeSuccess;

@property (nonatomic, strong) NSString *apiReturnCodeKey;

@property (nonatomic, strong) NSString *apiReturnDataKey;

@property (nonatomic, strong) NSString *apiReturnMsgKey;

@end

static NSString *MTCacheName = @"MTAPICache";


@implementation MTHttpAction

+ (instancetype)sharedHttpAction {
    static MTHttpAction *_sharedAction = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedAction = [[MTHttpAction alloc] init];
    });
    return _sharedAction;
}

/**
 2.0新增初始化
 
 @param apiCodeSuccess 服务器正确的返回码
 @param apiReturnCodeKey 返回码的Key
 @param apiReturnDataKey 返回内容的Key
 @param apiReturnMsgKey 返回提示信息的Key
 @return 回调
 */
+ (instancetype)sharedHttpActionByApiReturnCodeSuccess:(NSInteger)apiCodeSuccess
                                               codeKey:(NSString *)apiReturnCodeKey
                                               dataKey:(NSString *)apiReturnDataKey
                                                msgKey:(NSString *)apiReturnMsgKey {
    MTHttpAction *httpAction = [[MTHttpAction alloc] init];
    httpAction.apiReturnCodeSuccess = apiCodeSuccess;
    httpAction.apiReturnCodeKey = [apiReturnCodeKey mt_isNotEmpty] ? apiReturnCodeKey : [MTConstants sharedInstance].apiReturnCode;
    httpAction.apiReturnDataKey = [apiReturnDataKey mt_isNotEmpty] ? apiReturnDataKey : [MTConstants sharedInstance].apiReturnData;
    httpAction.apiReturnMsgKey = [apiReturnMsgKey mt_isNotEmpty] ? apiReturnMsgKey : [MTConstants sharedInstance].apiReturnMsg;
    return httpAction;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _apiClient = [MTAPIClient sharedClient];
        _cache = [YYCache cacheWithName:MTCacheName];
        _mtConstants = [MTConstants sharedInstance];
    }
    return self;
}

- (BOOL)isReachable {
    return _apiClient.isReachable;
}


#pragma mark - 网络请求方法

/**
 *  普通的访问请求(有提示，带判断网络状态, 带loading..)
 *
 *  @param URLString    接口地址
 *  @param requestBlock 回调函数
 */
- (void)POSTHUDByUrlString:(NSString *)URLString result:(ResultBlock)requestBlock {
    [self POSTHUDByUrlString:URLString parameters:nil result:requestBlock];
}

/**
 *  普通的访问请求(有提示，带判断网络状态)
 *
 *  @param URLString    接口地址
 *  @param requestBlock 回调函数
 */
- (void)POSTByUrlString:(NSString *)URLString result:(ResultBlock)requestBlock {
    [self POSTByUrlString:URLString parameters:nil result:requestBlock];
}

/**
 *  普通的访问请求(有提示，带判断网络状态, 带loading..)
 *
 *  @param URLString    接口地址
 *  @param parameters   字典参数
 *  @param requestBlock 回调函数
 */
- (void)POSTHUDByUrlString:(NSString *)URLString parameters:(id)parameters result:(ResultBlock)requestBlock {
    [self httpByUrlString:URLString methodType:Http_Post parameters:parameters isShowHUD:YES result:requestBlock];
}

/**
 *  普通的访问请求(有提示，带判断网络状态)
 *
 *  @param URLString    接口地址
 *  @param parameters   字典参数
 *  @param requestBlock 回调函数
 */
- (void)POSTByUrlString:(NSString *)URLString parameters:(id)parameters result:(ResultBlock)requestBlock {
    [self httpByUrlString:URLString methodType:Http_Post parameters:parameters isShowHUD:NO result:requestBlock];
}

/**
 *  普通的访问请求(有提示，带判断网络状态, 带loading)
 *
 *  @param URLString    接口地址
 *  @param parameters   字典参数
 *  @param requestBlock 回调函数
 */
- (void)GETHUDByUrlString:(NSString *)URLString parameters:(id)parameters result:(ResultBlock)requestBlock {
    [self httpByUrlString:URLString methodType:Http_Get parameters:parameters isShowHUD:YES result:requestBlock];
}

/**
 *  普通的访问请求(有提示，带判断网络状态)
 *
 *  @param URLString    接口地址
 *  @param parameters   字典参数
 *  @param requestBlock 回调函数
 */
- (void)GETByUrlString:(NSString *)URLString parameters:(id)parameters result:(ResultBlock)requestBlock {
    [self httpByUrlString:URLString methodType:Http_Get parameters:parameters isShowHUD:NO result:requestBlock];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wimplicit-retain-self"
/**
 获取html代码
 
 @param URLString html连接
 @param requestBlock 回调函数
 */
- (void)getHtmlStringOfURLString:(NSString *)URLString result:(ResultBlock)requestBlock {
    [MTProgressHUD showFlatLoading];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (requestBlock) {
            NSString *dataString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            requestBlock(_apiReturnCodeSuccess, dataString, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failResponseError:error result:requestBlock isShowHUD:NO];
    }];
}
#pragma clang diagnostic pop

#pragma mark - 新增访问三方接口，直接返回所有返回值。

/**
 访问三方接口，直接返回所有返回值。不作Code判断，只做Http访问结果判断
 GET请求
 @param URLString 接口地址
 @param parameters 字典参数
 @param result 回调函数
 */
- (void)GET3rdByUrlString:(NSString *)URLString parameters:(id)parameters result:(Result3rdBlock)result {
    [_apiClient GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (result) {
            result(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (result) {
            result(nil, error);
        }
    }];
}

/**
 访问三方接口，直接返回所有返回值。不作Code判断，只做Http访问结果判断
 POST请求
 @param URLString 接口地址
 @param parameters 字典参数
 @param result 回调函数
 */
- (void)POST3rdByUrlString:(NSString *)URLString parameters:(id)parameters result:(Result3rdBlock)result {
    [_apiClient POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (result) {
            result(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (result) {
            result(nil, error);
        }
    }];
}

#pragma mark - 设置\获取Http Header 的值
/**
 设置Http Header参数值
 
 @param value value
 @param field key
 */
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [_apiClient.requestSerializer setValue:value forHTTPHeaderField:field];
}

/**
 获取Http header的值
 
 @param field key
 @return value
 */
- (NSString *)valueForHTTPHeaderField:(NSString *)field {
    return [_apiClient.requestSerializer valueForHTTPHeaderField:field];
}

#pragma mark - private
/**
 Http访问请求
 
 @param URLString 接口地址
 @param methodType post get 类型
 @param parameters 参数
 @param isShowHUD 是否显示loading
 @param requestBlock 回调函数
 */
- (void)httpByUrlString:(NSString *)URLString methodType:(HttpMethodType)methodType parameters:(id)parameters isShowHUD:(BOOL)isShowHUD result:(ResultBlock)requestBlock {
    if (self.isReachable){
        if (isShowHUD) {
            [MTProgressHUD showFlatLoading];
        }
#warning 缓存策略，还需更加精细,暂时注释
        //        NSString *cache_key = [self cacheKeyWithUrlString:URLString parameters:parameters];
        //        id data = [_cache objectForKey:cache_key];
        //        if (data) {
        //            requestBlock([data[APIReturnCode] integerValue], data[APIReturnData], nil);
        //        }
        NSURLSessionDataTask *task = nil;
        if (methodType == Http_Post) {
            task = [self postWithUrlString:URLString parameters:parameters result:requestBlock isShowHUD:isShowHUD];
        } else {
            task = [self getWithUrlString:URLString parameters:parameters result:requestBlock isShowHUD:isShowHUD];
        }
        if (task != nil) {
            [self.arr_sessionTask addObject:task];
        }
    }
    else
    {
        [MTProgressHUD showErrorTips:@"当前无网络连接，请检查网络连接!"];
    }
}

- (NSURLSessionDataTask *)postWithUrlString:(NSString *)URLString parameters:(id)parameters result:(ResultBlock)requestBlock isShowHUD:(BOOL)isShow {
    [self setSignture2HeaderForParameter:parameters orUrlString:URLString];
    NSURLSessionDataTask *task = [_apiClient POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.arr_sessionTask removeObject:task];
        NSString *cacheKey = [self cacheKeyWithUrlString:URLString parameters:parameters];
        [self successResponseObject:responseObject result:requestBlock cacheKey:cacheKey isShowHUD:isShow];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.arr_sessionTask removeObject:task];
        [self failResponseError:error result:requestBlock isShowHUD:isShow];
    }];
    return task;
}

- (NSURLSessionDataTask *)getWithUrlString:(NSString *)URLString parameters:(id)parameters result:(ResultBlock)requestBlock isShowHUD:(BOOL)isShow {
    [self setSignture2HeaderForParameter:parameters orUrlString:URLString];
    NSURLSessionDataTask *task = [_apiClient GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.arr_sessionTask removeObject:task];
        NSString *cacheKey = [self cacheKeyWithUrlString:URLString parameters:parameters];
        [self successResponseObject:responseObject result:requestBlock cacheKey:cacheKey isShowHUD:isShow];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.arr_sessionTask removeObject:task];
        [self failResponseError:error result:requestBlock isShowHUD:isShow];
    }];
    return task;
}

- (void)setSignture2HeaderForParameter:(id)parameters orUrlString:(NSString *)urlString {
    NSString *signture = [self getSignatureByParameter:(NSDictionary *)parameters orUrlString:urlString];
    [_apiClient.requestSerializer setValue:signture forHTTPHeaderField:_mtConstants.signatureKey];
}

- (void)successResponseObject:(id  _Nullable)responseObject result:(ResultBlock)requestBlock cacheKey:(NSString *)key isShowHUD:(BOOL)isShow{
    if (isShow) {
        [MTProgressHUD hideProgressHUD];
    }
    [_cache setObject:responseObject forKey:key];
    if (requestBlock) {
        if ([responseObject mt_containsObjectForKey:_apiReturnCodeKey]) {
            requestBlock([responseObject[_apiReturnCodeKey] integerValue], responseObject[_apiReturnDataKey], responseObject[_apiReturnMsgKey]);
        } else {
            requestBlock(ErrorCode, nil, ErrorCodeMsg);
        }
    }
}

- (void)failResponseError:(NSError *)error result:(ResultBlock)requestBlock  isShowHUD:(BOOL)isShow {
    if (isShow) {
        [MTProgressHUD hideProgressHUD];
    }
    if (requestBlock) {
        requestBlock(error.code, nil, error.description);
    }
}

- (NSString *)cacheKeyWithUrlString:(NSString *)URLString parameters:(NSDictionary *)parameters {
    NSString *keyString = URLString;
    if (parameters != nil) {
        keyString = [URLString stringByAppendingString:[parameters mt_urlParamString]];
    }
    return [keyString mt_base64EncodedString];
}


/**
 取得签名字符串
 
 *****生成签名方式—- 有请求参数*****
 根据接口请求参数key值进行ascii排序
 拼接参数的value值为一个新的字符串
 如果用户登录，再拼接用户登录名+用户密码
 对签名字符串进行md5加密
 对加密过后的字符在第m位插入n位随机字符串进行加盐。
 进行url编码，添加参数到header，参数名为TQSignature
 
 *****生成签名方式—- 无请求参数*****
 取接口地址作为基础字符串
 如果用户登录，再拼接用户登录名+用户密码
 对签名字符串进行md5加密
 对加密过后的字符在第m位插入n位随机字符串进行加盐。
 进行url编码，添加参数到header，参数名为TQSignature
 
 @param parameter 参数
 @return 签名
 */
- (NSString *)getSignatureByParameter:(NSDictionary *)parameter orUrlString:(NSString *)urlString {
    NSMutableString *signature = [[NSMutableString alloc] init];
    if (parameter != nil) {
        NSArray *keyArray = [self sortByKeyASCIIOfParameter:parameter];
        for (NSString *key in keyArray) {
            id obj = parameter[key];
            [signature appendFormat:@"%@", obj];
        }
    } else {
        [signature appendString:urlString];
    }
    
    //如果登录 ，加上用户名和密码
    if ([NSUserDefaults mt_objectForKey:_mtConstants.signLoginNameKey] != nil) {
        [signature appendString:[NSUserDefaults mt_objectForKey:_mtConstants.signLoginNameKey]];
        [signature appendString:[NSUserDefaults mt_objectForKey:_mtConstants.signLoginPwdKey]];
    }
    
    NSMutableString *md5Signature = [[NSMutableString alloc] initWithString:[signature mt_md5String]];
    [md5Signature insertString:[self randomStringWithLength:_mtConstants.signSaltLength] atIndex:_mtConstants.signSaltStartIndex];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return [md5Signature stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#pragma clang diagnostic pop
}

- (NSArray *)sortByKeyASCIIOfParameter:(NSDictionary *)parameter {
    NSArray *keyArray = [parameter allKeys];
    NSArray *sortKeyArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        NSRange range = NSMakeRange(0, obj1.length);
        return [obj1 compare:obj2 options:NSCaseInsensitiveSearch | NSNumericSearch | NSWidthInsensitiveSearch | NSForcedOrderingSearch range:range];
    }];
    return sortKeyArray;
}


/**
 生成随机字符串
 
 @param len 长度
 @return 字符串
 */
-(NSString *)randomStringWithLength:(NSInteger)len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (NSInteger i = 0; i < len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((uint32_t)[letters length])]];
    }
    return randomString;
}

//- (NSString *)randomForString {
//    int num = (arc4random() % (int)pow(10.f, (kSignSaltLength)*1.0f));
//    return [NSString stringWithFormat:@"%d", num];
//}

#pragma mark - getters、setters
- (NSMutableArray *)arr_sessionTask {
    if (_arr_sessionTask == nil) {
        _arr_sessionTask = [NSMutableArray arrayWithCapacity:0];
    }
    return _arr_sessionTask;
}

@end
