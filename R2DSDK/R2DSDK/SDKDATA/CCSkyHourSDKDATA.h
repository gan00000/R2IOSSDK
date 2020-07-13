//
//  R2SDKDATA.h
//  CCSkyHourSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <R2SDKFramework/R2SDKFramework.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCSkyHourSDKDATA : NSObject

@property (nonatomic, copy)NSString * gameLoginToken;
@property (nonatomic, copy)NSString * gameLoginTimeStamp;

//当前登入方式
@property (nonatomic, assign)NSInteger gameLoginType;

@property (nonatomic, copy)NSString * gameUserId;


@property (nonatomic, copy)NSString * gameLanguage;

@property (nonatomic)BOOL isLogin;

@property  (nonatomic, copy)NSString * loginResult;

@property(nonatomic,assign) BOOL isBindFb;
@property(nonatomic,assign) BOOL isBindGoogle;
@property(nonatomic,assign) BOOL isNeedAutoLogin;

+ (instancetype)sharedSdkData;

-(void)saveLoginType:(NSInteger)loginType;

//- (void)initData;

- (void)releaseData;

@end

NS_ASSUME_NONNULL_END
