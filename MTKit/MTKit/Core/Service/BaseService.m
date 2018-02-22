//
//  BaseService.m
//  MTKit
//
//  Created by Michael on 2018/2/22.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "BaseService.h"

@implementation BaseService

#pragma mark - life cycle

+(instancetype)sharedService {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _httpAction = [MTHttpAction sharedHttpActionByApiReturnCodeSuccess:self.apiReturnCodeSuccess codeKey:self.apiReturnCodeKey dataKey:self.apiReturnDataKey msgKey:self.apiReturnMsgKey];
        _fileAction = [MTFileAction sharedFileAction];
    }
    return self;
}

- (NSInteger)apiReturnCodeSuccess {
    return [MTConstants sharedInstance].apiReturnCodeSuccess;
}

- (NSString *)apiReturnCodeKey {
    return [MTConstants sharedInstance].apiReturnCode;
}

- (NSString *)apiReturnDataKey {
    return [MTConstants sharedInstance].apiReturnData;
}

- (NSString *)apiReturnMsgKey {
    return [MTConstants sharedInstance].apiReturnMsg;
}
@end
