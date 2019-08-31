//
//  R2SDKPlat.h
//  R2DSDK
//
//  Created by ganyuanrong on 2019/5/30.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


typedef void (^R2SDKLoginCompletionHandler)(NSString* loginResponse);

typedef void (^R2SDKLogoutHandler)(NSInteger logout);

//#define GAME_LANGUAGE_

@interface R2SDKPlat : NSObject

@property (nonatomic)R2SDKLoginCompletionHandler loginCompletionHandler;


@property (nonatomic)R2SDKLogoutHandler logoutHandler;

//@property (nonatomic,nullable)UIViewController * sdkPresentedVC;
@property (nonatomic)UIViewController * gameUIViewController;

/**
 应用跳转回调（适用于 iOS 8 及以下）
 
 */
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation;

/**
 应用跳转回调（适用于 iOS 9 及以上）
 */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;


- (void)applicationWillTerminate:(UIApplication *)application;

/**
 单例
 
 @return  单例对象
 */
+ (instancetype)shareR2SDK;

/**
 登录
 */
- (void)loginWithViewController:(UIViewController *)gameUIViewController loginHandler:(R2SDKLoginCompletionHandler)loginHandler;


- (void)loginWithViewController:(UIViewController *)gameUIViewController isAutoLogin:(BOOL)isNeedAutoLogin loginHandler:(R2SDKLoginCompletionHandler)loginHandler ;

- (void)showCurrentLoginTypeWithViewController:(UIViewController *)gameUIViewController logoutHandler:(R2SDKLogoutHandler)logoutHandler;

- (void)showUnbindWithViewController:(UIViewController *)gameUIViewController logoutHandler:(R2SDKLogoutHandler)logoutHandler;

- (void)initWithLanguage:(NSString *)language;


@end

NS_ASSUME_NONNULL_END
