//
//  MTLogUtil.m
//  MTKit
//
//  Created by Michael Yu on 2018/8/17.
//  Copyright © 2018年 michaelyu. All rights reserved.
//

#import "MTLogUtil.h"
#import "DDTTYLogger.h"
#import "DDFileLogger.h"

@implementation MTLogUtil

+ (instancetype)logOpen{
    static MTLogUtil *shareLogInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareLogInstance = [[self alloc]init];
    });
    
    return shareLogInstance;
}

-(id)init
{
    self = [super init];
    if (self)
    {
#ifdef CONSOLE_LOG_ON
        
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
#endif
        
#ifdef FILE_LOG_ON
        
        DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
        fileLogger.maximumFileSize = (1024 * 1024 * 2); //  2 MB
        fileLogger.rollingFrequency = 60 * 60 * 24;      //记录24个小时的log(60 * 60 * 24);   // 24 Hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
        
        [DDLog addLogger:fileLogger];
#endif
    }
    return self;
}
@end
