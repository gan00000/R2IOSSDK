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
        [self releaseData];
    }
    return self;
}

-(void)saveLoginType:(NSInteger)loginType
{
    self.gameLoginType = loginType;
}

#pragma mark -
#pragma mark - Private Action

- (void)initData
{
    
}

- (void)releaseData
{
    self.isLogin = NO;
    self.gameUserId = @"";
    self.gameLoginToken = @"";
    self.gameLoginTimeStamp = @"";
}

@end
