//
//  R2SDKPlat.m
//  R2DSDK
//
//  Created by ganyuanrong on 2019/5/30.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "R2SDKPlat.h"
#import "R2DHeader.h"
#import "GamaFunction.h"
#import <R2SDKFramework/R2SDKFramework.h>
#import "R2DLoginViewController.h"

@implementation R2SDKPlat


- (instancetype)init
{
    
    self = [super init];
    if (self) {
        //init something
    }
    
    return self;
}

/**
 单例
 
 @return  单例对象
 */
+ (instancetype)shareR2SDK
{
    static R2SDKPlat *_shareSP = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareSP = [[R2SDKPlat alloc] init];
    });
    
    return _shareSP;
}


/**
 应用跳转回调（适用于 iOS 8 及以下）
 
 */
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation{
    
    return YES;
}

/**
 应用跳转回调（适用于 iOS 9 及以上）
 */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options
{
    //Facebook
    
     [[FBSDKApplicationDelegate sharedInstance] application:app
                                                    openURL:url
                                    sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                 annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
 
    //google
//    [[R2GoogleHelper sharedInstance] application:app
//                                         openURL:url
//                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
//    [[R2GoogleHelper sharedInstance] application:app openURL:url options:options];
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[R2SDKMgrApi sharedInstance]sdkInit];
    
    //facebook
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    //google 113678359411-jnvdc3e59persg70227kkunqqedtqv9g.apps.googleusercontent.com
//    NSString *googleClientId = @"9825068096-ama8dc07lj0vp7bo052l5muv142a2qas.apps.googleusercontent.com";
//    NSString *googleClientId = @"113678359411-jnvdc3e59persg70227kkunqqedtqv9g.apps.googleusercontent.com";
//    [[R2GoogleHelper sharedInstance] initWithGoogleSignInClientId:googleClientId];
//    
    SDK_DATA;
    return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [[R2SDKMgrApi sharedInstance]sdkUninit];
}


/**
 登录
 */
- (void)loginWithViewController:(UIViewController *)gameUIViewController loginHandler:(R2SDKLoginCompletionHandler)loginHandler
{
    SDK_DATA.initData;
    self.loginCompletionHandler = loginHandler;

    if (!gameUIViewController) {
        return;
    }
    self.gameUIViewController = gameUIViewController;
    self.sdkPresentedVC = [[R2DLoginViewController alloc] initWithPageType:(SDKPage_Login)];

//    self.sdkPresentedVC.definesPresentationContext = YES;
//    self.sdkPresentedVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;//关键语句，必须有
//    [self.gameUIViewController presentViewController: self.sdkPresentedVC animated:NO completion:nil];
    
     [self showController];
}

- (void)showCurrentLoginTypeWithViewController:(UIViewController *)gameUIViewController logoutHandler:(R2SDKLogoutHandler)logoutHandler
{
    
    self.gameUIViewController = gameUIViewController;
    self.logoutHandler = logoutHandler;
    if (SDK_DATA.gameLoginType < 0 || !SDK_DATA.isLogin) {
        [UIUtil showAlertTips:GET_SDK_LOCALIZED(@"R2SDK_LOGIN_FIRST")];
        return;
    }
    
    self.gameUIViewController = gameUIViewController;
    self.sdkPresentedVC = [[R2DLoginViewController alloc] initWithPageType:(SDKPage_LoginType)];
    //    presentedVC.view.backgroundColor = [UIColor clearColor];
    
//    self.sdkPresentedVC.definesPresentationContext = YES;
//    self.sdkPresentedVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;//关键语句，必须有
//    [self.gameUIViewController presentViewController: self.sdkPresentedVC animated:NO completion:nil];
    
     [self showController];
}


- (void)showUnbindWithViewController:(UIViewController *)gameUIViewController logoutHandler:(R2SDKLogoutHandler)logoutHandler
{
    self.gameUIViewController = gameUIViewController;
    self.logoutHandler = logoutHandler;
    if (SDK_DATA.gameLoginType < 0 || !SDK_DATA.isLogin) {
        [UIUtil showAlertTips:GET_SDK_LOCALIZED(@"R2SDK_LOGIN_FIRST")];
        return;
    }
    
    self.gameUIViewController = gameUIViewController;
    self.sdkPresentedVC = [[R2DLoginViewController alloc] initWithPageType:(SDKPage_UnBind)];
    //    presentedVC.view.backgroundColor = [UIColor clearColor];
    
    [self showController];
    
}

-(void)showController
{
    self.sdkPresentedVC.definesPresentationContext = YES;
    self.sdkPresentedVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;//关键语句，必须有
    [self.gameUIViewController presentViewController: self.sdkPresentedVC animated:NO completion:^{
        
    }];
   
}


- (void)initWithLanguage:(NSString *)language
{
    SDK_DATA;
    SDK_DATA.gameLanguage = @"zh-Hant";
}


@end
