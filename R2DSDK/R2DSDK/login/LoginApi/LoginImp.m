//
//  LoginImp.m
//  R2DSDK
//
//  Created by ganyuanrong on 2019/5/30.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "LoginImp.h"
#import "R2DHeader.h"


@implementation LoginImp


+(void) loginGuestAccount:(UIViewController *)viewController isFormAutoLogin:(BOOL)isFormAutoLogin
{
    [self startLoadingView];
    [R2SDKApi loginAsyncWithFixedGuestAccount:^(int code, NSString *msg, R2LoginResponse *result) {
        
        [self stopLoadingView];
        
        if (code == R2_LOGIN_SUCCESS && result) {
//            //取得帐号的 r2 uid，便于游戏自身定位玩家
//            NSString *r2UserId = result.r2Uid; 
//
//            //取得相关验证登录合法性的数据,若不详请咨询SDK服务器端技术人员
//            NSString *loginTimestamp = result.timestamp; 
//
            SDK_DATA.loginResult = result;
            BOOL isBindFb = result.isBoundToFacebook;
            BOOL isBindGoogle =result.isBoundToGoogleAccount;
            if (isBindFb) {//绑定过就不算游客登录
                [SDK_DATA saveLoginType:LoginTypeFacebook];
                [self loginSuccess:result mController:viewController];
                
            }else if(isBindGoogle)
            {
                 [SDK_DATA saveLoginType:LoginTypeGoogle];
                 [self loginSuccess:result mController:viewController];
            }else
            {
                [SDK_DATA saveLoginType:LoginTypeGuest];
                [[NSNotificationCenter defaultCenter] postNotificationName:Guest_Login_Tipe_OK object:nil];
            }
            
          
           
//            [SDK_DATA saveLoginType:LoginTypeGuest];
            
        }else{
            if (isFormAutoLogin) {
                //自动登录失败回到主登录界面
                [UIUtil showAlertTips:msg okHandler:^(UIAlertAction * _Nonnull action) {
                     [[NSNotificationCenter defaultCenter] postNotificationName:SDK_AUTO_LOGIN_FAIL object:nil];
                }];
                
            }else{
                [UIUtil showAlertTips:msg];
            }
            SDK_LOG(@"failed to login，code:%d,error:%@",code,msg);
        }
        
    }];
}

+(void) loginFBAccount:(UIViewController *)viewController isFormAutoLogin:(BOOL)isFormAutoLogin
{
    
//
//+(void) loginFBAccount:(UIViewController *)viewController
//{
//
//    [[R2FacebookHelper sharedInstance] loginFromViewController:viewController completionHandler:^(int code, NSString *msg, R2FacebookLoginResult *result) {
//        if (code==R2_FACEBOOK_SUCCESS_CODE) {
//            SDK_LOG(@"successfully login with facebook");
//            NSString* fbUserId = result.fbUserId;
//            NSString* fbUserImageUrl = result.fbImageUrl;
//            NSString* fbUserName = result.fbUsername;
//            SDK_LOG(@"[fbUserId=%@,fbUserImageUrl=%@,fbUserName=%@]",fbUserId,fbUserImageUrl,fbUserName)
//            ;
    
    [self startLoadingView];
    [[R2FacebookHelper sharedInstance]UIDLoginWithViewController:viewController
                                               completionHandler:^(int code,
                                                                   NSString *msg,
                                             R2FacebookLoginResult *facebookLoginResult,
                                             R2LoginResponse *r2LoginResult) {
                                                   
                                                   [self stopLoadingView];
        if (code == R2_RESPONSE_SUCCESS_CODE) {
            
//                                             R2FacebookLoginResult *facebookLoginResult,
//                                             R2LoginResponse *r2LoginResult) {
//        if (code == R2_RESPONSE_SUCCESS_CODE) {
//
//             NSLog(@"Facebook login successfully,msg -> %@,fbuid -> %@,fbimageURL -> %@,fbname -> %@",msg,facebookLoginResult.fbUserId,facebookLoginResult.fbImageUrl,facebookLoginResult.fbUsername);
//
//            //取得帐号的 r2 uid，便于游戏自身定位玩家
//            NSString *r2UserId = r2LoginResult.r2Uid; //判断是否绑定 Game center 字段
//            BOOL isBoundToFB = r2LoginResult.isBoundToFacebook;
//            NSLog(@"is bound to game center,%d",isBoundToFB); //取得相关验证登录合法性的数据
//            NSString *loginTimestamp = r2LoginResult.timestamp;
//            NSString *sign = r2LoginResult.sign;
            [SDK_DATA saveLoginType:LoginTypeFacebook];
            [self loginSuccess:r2LoginResult mController:viewController];
            
        }else{
            NSLog(@"Facebook login failed,code -> %d,msg -> %@",code,msg);
            if (isFormAutoLogin) {
                //自动登录失败回到主登录界面
                //[[NSNotificationCenter defaultCenter] postNotificationName:SDK_AUTO_LOGIN_FAIL object:nil];
                [UIUtil showAlertTips:msg okHandler:^(UIAlertAction * _Nonnull action) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:SDK_AUTO_LOGIN_FAIL object:nil];
                }];
            }else{
                 [UIUtil showAlertTips:msg];
            }
           
        }
    }];
}


+(void) loginGoogleAccount:(UIViewController *)viewController isFormAutoLogin:(BOOL)isFormAutoLogin
{
 [self startLoadingView];
    [[R2GoogleHelper sharedInstance] loginFromViewController:viewController
                                         onCompletionHandler:^(int code,
                                                               NSString *msg,
                                                               R2LoginResponse  * r2LoginResult,
                                                               NSDictionary *result) {
                                             
                                             [self stopLoadingView];
        if (code == 0) {
            [SDK_DATA saveLoginType:LoginTypeGoogle];
            [self loginSuccess:r2LoginResult mController:viewController];
        } else{
            NSLog(@"login failed,code -> %d,msg -> %@",code,msg);
            // [UIUtil showAlertTips:msg];
            if (isFormAutoLogin) {
                //自动登录失败回到主登录界面
               // [[NSNotificationCenter defaultCenter] postNotificationName:SDK_AUTO_LOGIN_FAIL object:nil];
                [UIUtil showAlertTips:msg okHandler:^(UIAlertAction * _Nonnull action) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:SDK_AUTO_LOGIN_FAIL object:nil];
                }];
            }else{
                [UIUtil showAlertTips:msg];
            }
        }
    }];
    
}

+(void)loginSuccess:(R2LoginResponse *) r2LoginResult mController:(UIViewController *) mController
{
    SDK_DATA.loginResult = r2LoginResult;
    NSString *r2UserId = r2LoginResult.r2Uid;
    NSString *loginTimestamp = r2LoginResult.timestamp;
    NSString *sign = r2LoginResult.sign;
    
    SDK_LOG(@"login success r2uid=%@,timestamp=%@,sign=%@",r2UserId,loginTimestamp,sign);
    
    SDK_DATA.gameUserId = r2UserId;
    SDK_DATA.gameLoginTimeStamp = loginTimestamp;
    SDK_DATA.gameLoginToken = sign;
    SDK_DATA.isLogin = YES;
    
    SDK_DATA.isBindFb = r2LoginResult.isBoundToFacebook;
    SDK_DATA.isBindGoogle = r2LoginResult.isBoundToGoogleAccount;
    
    [mController dismissViewControllerAnimated:NO completion:nil];
    
    if ([R2SDKPlat shareR2SDK].loginCompletionHandler) {
    
        [R2SDKPlat shareR2SDK].loginCompletionHandler(r2LoginResult);
    }
}

+(void) logoutAccount:(UIViewController *) mController
{
    [[R2SDKMgrApi  sharedInstance] logout];//清楚R2SDK token
    [mController dismissViewControllerAnimated:NO completion:nil];
    if ([R2SDKPlat shareR2SDK].logoutHandler) {
        
        [R2SDKPlat shareR2SDK].logoutHandler(SDK_DATA.gameLoginType);
    }
    [SDK_DATA releaseData];
}


+(void)bindFacebook:(UIViewController *)viewController
{
    [self startLoadingView];
    [[R2FacebookMgrHelper sharedHelper]bindFBWithViewController:viewController
                                            withReadPermissions:@[@"public_profile"]
                                              andR2UidToBeBound:SDK_DATA.gameUserId
                                              completionHandler:^(int code, NSString *msg, R2FacebookLoginResult *result) {
                                                  [self stopLoadingView];
                                                  if (code == 1009) {
                                                      [UIUtil showAlertTips:GET_SDK_LOCALIZED(@"FB_HAS_BIND")];
                                                  }else  if (code == FACEBOOK_BIND_SUCCESS) {
                                                      NSLog(@"facebook login and bind r2 account successfully,[%@%@%@]",result.fbUserId,result.fbUsername,result.fbImageUrl);
                                                            [SDK_DATA saveLoginType:LoginTypeFacebook];
                                                      
                                                      
                                                      [UIUtil showAlertTips:GET_SDK_LOCALIZED(@"R2SDK_BIND_SUCCESS") okHandler:^(UIAlertAction * _Nonnull action) {
                                                          [viewController dismissViewControllerAnimated:NO completion:nil];
                                                      }];
                                                      
                                                     // [viewController dismissViewControllerAnimated:NO completion:nil];
                                                  }else {
                                                      
                                                      if (![msg isEqualToString:@""]) {
                                                          [UIUtil showAlertTips:msg];
                                                      }else
                                                      {
                                                          [UIUtil showAlertTips:GET_SDK_LOCALIZED(@"BIND_FAIL")];
                                                      }
                                                      
                                                              NSLog(@"facebook login and bind r2 account failed,code = %d,msg = %@",code,msg);
                                                    }
                                              }
     
     
     ];
                                                          
}

+(void) bindGoogle:(UIViewController *)viewController
{
    
    [self startLoadingView];
    [[R2GoogleHelper sharedInstance] bindFromViewController:viewController
                                                  withR2Uid:SDK_DATA.gameUserId
                                        onCompletionHandler:^(int code, NSString *msg, R2LoginResponse *loginResponse, NSDictionary *result) {
                                            
                                            [self stopLoadingView];
                                            
                                            if (code == 1009) {
                                                [UIUtil showAlertTips:GET_SDK_LOCALIZED(@"FB_HAS_BIND")];
                                            }else if (code == 0) {
                                                //绑定成功
                                                [SDK_DATA saveLoginType:LoginTypeGoogle];
                                                
                                                [UIUtil showAlertTips:GET_SDK_LOCALIZED(@"R2SDK_BIND_SUCCESS") okHandler:^(UIAlertAction * _Nonnull action) {
                                                    [viewController dismissViewControllerAnimated:NO completion:nil];
                                                }];
                                                
                                                
                                            }else{
                                                
                                                if (![msg isEqualToString:@""]) {
                                                    [UIUtil showAlertTips:msg];
                                                }else
                                                {
                                                    [UIUtil showAlertTips:GET_SDK_LOCALIZED(@"BIND_FAIL")];
                                                }
                                               
                                                NSLog(@"bind failed,code -> %d,msg -> %@",code,msg);
                                            }
                                            
                                        }];
}


+(void)unbindFacebook:(UIViewController *)viewController
{
    
    [self startLoadingView];
    [[R2SDKMgrApi sharedInstance]unwrap:SDK_DATA.gameUserId openType:@"2" completionHandler:^(int code, NSString *msg, R2UnwrapResponse *result) {
        
        [self stopLoadingView];
        if (code == 0) {
            NSLog(@"Unwrap successful,msg:%@",msg);
              [SDK_DATA saveLoginType:LoginTypeGuest];
            SDK_DATA.isBindFb = NO;
            [UIUtil showAlertTips:GET_SDK_LOCALIZED(@"R2SDK_UNBIND_SUCCESS") okHandler:^(UIAlertAction * _Nonnull action) {
                [viewController dismissViewControllerAnimated:NO completion:nil];
            }];
            
        }else{
            NSLog(@"Unwrap failed,msg:%@,code:%d",msg,code);
             [UIUtil showAlertTips:GET_SDK_LOCALIZED(@"R2SDK_UNBIND_FAIL")];
        }
    }];
    
}
//type:第三方账号类型(GameCenter 传入"1"，Facebook 账号传入"2", Google 账 号传入"8")(必须)
+(void) unbindGoogle:(UIViewController *)viewController
{
    [self startLoadingView];
    [[R2SDKMgrApi sharedInstance]unwrap:SDK_DATA.gameUserId openType:@"8" completionHandler:^(int code, NSString *msg, R2UnwrapResponse *result) {
        
        [self stopLoadingView];
        if (code == 0) {
            NSLog(@"Unwrap successful,msg:%@",msg);
            [SDK_DATA saveLoginType:LoginTypeGuest];
            SDK_DATA.isBindGoogle = NO;
            
            [UIUtil showAlertTips:GET_SDK_LOCALIZED(@"R2SDK_UNBIND_SUCCESS") okHandler:^(UIAlertAction * _Nonnull action) {
                [viewController dismissViewControllerAnimated:NO completion:nil];
            }];
            
         //   [viewController dismissViewControllerAnimated:NO completion:nil];
        }else{
            NSLog(@"Unwrap failed,msg:%@,code:%d",msg,code);
             [UIUtil showAlertTips:GET_SDK_LOCALIZED(@"R2SDK_UNBIND_FAIL")];
        }
    }];
}


+ (void)startLoadingView
{

    UIView *v=[[UIView alloc] initWithFrame:CGRectZero];
    v.backgroundColor = [UIColor colorWithHexString:@"#000000" andAlpha:0.6];
    v.tag = 1002;
    v.layer.cornerRadius = 10.0f;
    
    [hillTopViewController.view addSubview:v];
    
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(0));
        make.centerY.equalTo(@(0));
        make.width.equalTo(@(40));
        make.height.equalTo(@(40));
    }];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.tag = 1003;
    [v addSubview:indicator];
    [indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(0));
        make.centerY.equalTo(@(0));
        make.width.equalTo(@(40));
        make.height.equalTo(@(40));
    }];
    [indicator startAnimating];
}


+ (void)stopLoadingView
{
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)[hillTopViewController.view viewWithTag:1003];
    if (indicator) {
        [indicator stopAnimating];
    }
    UIView *loadingView = [hillTopViewController.view viewWithTag:1002];
    [loadingView removeFromSuperview];
}

                  
@end
