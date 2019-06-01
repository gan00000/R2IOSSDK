//
//  R2SDKDATA.m
//  R2DSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "R2SDKDATA.h"

@implementation R2SDKDATA

+ (instancetype)sharedSdkData
{
    static R2SDKDATA * pfData = nil;
    static dispatch_once_t once_dispatch;
    dispatch_once(&once_dispatch, ^{
        pfData = [[R2SDKDATA alloc] initSDKDATA];
    });
    return pfData;
}

- (instancetype)initSDKDATA
{
    if (self = [super init]) {
//        [self releaseData];
        [self initData];
         
    }
    return self;
}

-(void)saveLoginType:(NSInteger)loginType
{
    
    self.gameLoginType = loginType;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    // 1、写入
    [userDefaults setInteger:self.gameLoginType forKey:@"SDK_LOGIN_TYPE"];
    // 强制写入
    [userDefaults synchronize];
}


#pragma mark -
#pragma mark - Private Action

- (void)initData
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.gameLoginType = [userDefaults integerForKey:@"SDK_LOGIN_TYPE"];
    
    self.isLogin = NO;
    self.gameUserId = @"";
    self.gameLoginToken = @"";
    self.gameLoginTimeStamp = @"";
    self.isLogin = YES;
    self.gameLanguage = @"zh-Hans";
}

- (void)releaseData
{
//    [self saveLoginType:-1];
    self.isLogin = NO;
    self.gameUserId = @"";
    self.gameLoginToken = @"";
    self.gameLoginTimeStamp = @"";
//    self.isLogin = YES;
}

@end
