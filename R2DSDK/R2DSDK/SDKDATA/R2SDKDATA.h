//
//  R2SDKDATA.h
//  R2DSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <R2SDKFramework/R2SDKFramework.h>

NS_ASSUME_NONNULL_BEGIN

@interface R2SDKDATA : NSObject

@property (nonatomic, copy)NSString * gameLoginToken;
@property (nonatomic, copy)NSString * gameLoginTimeStamp;

//登入方式
@property (nonatomic, assign)NSInteger gameLoginType;

@property (nonatomic, copy)NSString * gameUserId;


@property (nonatomic, copy)NSString * gameLanguage;

@property (nonatomic)Boolean isLogin;

@property (nonatomic)R2LoginResponse * loginResult;

+ (instancetype)sharedSdkData;

-(void)saveLoginType:(NSInteger)loginType;

- (void)initData;

- (void)releaseData;

@end

NS_ASSUME_NONNULL_END
