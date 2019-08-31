//
//  R2SDKPlat.m
//  CCSkyHourSDK
//
//  Created by ganyuanrong on 2019/5/30.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "CCSkyHourSDKPlat.h"
#import "CCSkyHourHeader.h"
#import "CCSkyHourFunction.h"
#import "CCSkyHourLoginViewController.h"
#import "CCSkyHourHeader.h"

@implementation CCSkyHourSDKPlat


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
    static CCSkyHourSDKPlat *_shareSP = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareSP = [[CCSkyHourSDKPlat alloc] init];
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
    
//     [[FBSDKApplicationDelegate sharedInstance] application:app
//                                                    openURL:url
//                                    sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
//                                                 annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
 
    //google
    
//    [[R2GoogleHelper sharedInstance] handleURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [[R2SDKMgrApi sharedInstance]sdkInit];
    
    //facebook
//    [[FBSDKApplicationDelegate sharedInstance] application:application
//                             didFinishLaunchingWithOptions:launchOptions];
    
    //google 113678359411-jnvdc3e59persg70227kkunqqedtqv9g.apps.googleusercontent.com
//    NSString *googleClientId = @"9825068096-ama8dc07lj0vp7bo052l5muv142a2qas.apps.googleusercontent.com";
//    NSString *googleClientId = @"113678359411-jnvdc3e59persg70227kkunqqedtqv9g.apps.googleusercontent.com";
//    [[R2GoogleHelper sharedInstance] initWithGoogleSignInClientId:googleClientId];
    
    SDK_DATA;
    return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
//    [[R2SDKMgrApi sharedInstance]sdkUninit];
}


/**
    登录界面，会根据上一次登录的方式进行自动登录，如果没有登录方式则显示登录界面
 */
- (void)loginWithViewController:(UIViewController *)gameUIViewController loginHandler:(R2SDKLoginCompletionHandler)loginHandler
{
    self.loginCompletionHandler = loginHandler;

    if (!gameUIViewController) {
        return;
    }
    SDK_DATA.isNeedAutoLogin = YES;
    self.gameUIViewController = gameUIViewController;
     CCSkyHourLoginViewController *sdkPresentedVC = [[CCSkyHourLoginViewController alloc] initWithPageType:(SDKPage_Login)];

//    self.sdkPresentedVC.definesPresentationContext = YES;
//    self.sdkPresentedVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;//关键语句，必须有
//    [self.gameUIViewController presentViewController: self.sdkPresentedVC animated:NO completion:nil];
    
    [self showController:sdkPresentedVC];
}

- (void)loginWithViewController:(UIViewController *)gameUIViewController isAutoLogin:(BOOL)isNeedAutoLogin loginHandler:(R2SDKLoginCompletionHandler)loginHandler
{
    self.loginCompletionHandler = loginHandler;
   
    if (!gameUIViewController) {
        return;
    }
    SDK_DATA.isNeedAutoLogin = isNeedAutoLogin;
    
    self.gameUIViewController = gameUIViewController;
    CCSkyHourLoginViewController *sdkPresentedVC = [[CCSkyHourLoginViewController alloc] initWithPageType:(SDKPage_Login)];
   [self showController:sdkPresentedVC];
}

- (void)showCurrentLoginTypeWithViewController:(UIViewController *)gameUIViewController logoutHandler:(R2SDKLogoutHandler)logoutHandler
{
    
    self.gameUIViewController = gameUIViewController;
    self.logoutHandler = logoutHandler;
    if (SDK_DATA.gameLoginType < 1 || !SDK_DATA.isLogin) {
        [UIUtil showAlertTips:gameUIViewController msg:GET_SDK_LOCALIZED(@"R2SDK_LOGIN_FIRST")];
        return;
    }
    
    self.gameUIViewController = gameUIViewController;
    CCSkyHourLoginViewController *sdkPresentedVC = [[CCSkyHourLoginViewController alloc] initWithPageType:(SDKPage_LoginType)];
    //    presentedVC.view.backgroundColor = [UIColor clearColor];
    
//    self.sdkPresentedVC.definesPresentationContext = YES;
//    self.sdkPresentedVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;//关键语句，必须有
//    [self.gameUIViewController presentViewController: self.sdkPresentedVC animated:NO completion:nil];
    
    [self showController:sdkPresentedVC];
}


- (void)showUnbindWithViewController:(UIViewController *)gameUIViewController logoutHandler:(R2SDKLogoutHandler)logoutHandler
{
    self.gameUIViewController = gameUIViewController;
    self.logoutHandler = logoutHandler;
    if (SDK_DATA.gameLoginType < 1 || !SDK_DATA.isLogin) {
        [UIUtil showAlertTips:gameUIViewController msg:GET_SDK_LOCALIZED(@"R2SDK_LOGIN_FIRST")];
        return;
    }
    
    self.gameUIViewController = gameUIViewController;
    CCSkyHourLoginViewController *sdkPresentedVC = [[CCSkyHourLoginViewController alloc] initWithPageType:(SDKPage_UnBind)];
    //    presentedVC.view.backgroundColor = [UIColor clearColor];
    
    [self showController:sdkPresentedVC];
    
}

-(void)showController:(CCSkyHourLoginViewController *)controller
{
    controller.definesPresentationContext = YES;
    controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;//关键语句，必须有
    [self.gameUIViewController presentViewController: controller animated:NO completion:^{
        
    }];
   
}


- (void)initWithLanguage:(NSString *)language
{
    SDK_DATA;
    SDK_DATA.gameLanguage = @"zh-Hans";//简体
}


@end
