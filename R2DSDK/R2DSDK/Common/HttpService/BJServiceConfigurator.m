//
//  BJServiceConfigurator.m
//  BenjiaPro
//
//  Created by Marco on 2017/6/1.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#define BJ_DEBUG NO

#import "BJServiceConfigurator.h"

static NSString * const kServerProductURL = @"http://app.ballgametime.com/";
static NSString * const kServerTestURL = @"http://app.ballgametime.com/"; //测试环境地址
static NSString * const kServerDevURL = @"http://app.ballgametime.com/"; //开发环境地址

static NSString * const kServiceUrlTypeKey = @"kServiceUrlTypeKey"; //正式环境0 测试环境为1,开发环境为2

@implementation BJServiceConfigurator

+ (instancetype)sharedInstance {
    static BJServiceConfigurator *instance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[BJServiceConfigurator alloc] init];
        
        if (BJ_DEBUG) {
            [[NSUserDefaults standardUserDefaults] registerDefaults:@{kServiceUrlTypeKey:@1}];
        } else {
            [[NSUserDefaults standardUserDefaults] registerDefaults:@{kServiceUrlTypeKey:@0}];
        }
        
    });
    return instance;
}

- (void)connectToServer {
    
}

- (NSString *)serverBaseUrl {
    NSInteger serverType = [[NSUserDefaults standardUserDefaults] integerForKey:kServiceUrlTypeKey];
    if (serverType == 0) {
        return kServerProductURL;
    } else if (serverType == 1) {
        return kServerTestURL;
    } else if (serverType == 2) {
        return kServerDevURL;
    }
    return kServerProductURL;
}

-(NSInteger)currentServerType{
    return [[NSUserDefaults standardUserDefaults] integerForKey:kServiceUrlTypeKey];
}

@end
