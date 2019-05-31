//
//  LoginImp.m
//  R2DSDK
//
//  Created by ganyuanrong on 2019/5/30.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "LoginImp.h"


@implementation LoginImp


+(void) loginGuestAccount:(UIViewController *)viewController 
{
    [R2SDKApi loginAsyncWithFixedGuestAccount:^(int code, NSString *msg, R2LoginResponse *result) {
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
                [self loginSuccess:result];
                
            }else if(isBindGoogle)
            {
                 [SDK_DATA saveLoginType:LoginTypeGoogle];
                 [self loginSuccess:result];
            }else
            {
                [SDK_DATA saveLoginType:LoginTypeGuest];
                [[NSNotificationCenter defaultCenter] postNotificationName:Guest_Login_Tipe_OK object:nil];
            }
            
          
           
//            [SDK_DATA saveLoginType:LoginTypeGuest];
            
        }else{
            SDK_LOG(@"failed to login，code:%d,error:%@",code,msg);
        }
        
    }];
}

+(void) loginFBAccount:(UIViewController *)viewController
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
    
    
    [[R2FacebookHelper sharedInstance]UIDLoginWithViewController:viewController
                                               completionHandler:^(int code,
                                                                   NSString *msg,
                                             R2FacebookLoginResult *facebookLoginResult,
                                             R2LoginResponse *r2LoginResult) {
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
            [self loginSuccess:r2LoginResult];
            
        }else{
            NSLog(@"Facebook login failed,code -> %d,msg -> %@",code,msg);
        }
    }];
}


+(void) loginGoogleAccount:(UIViewController *)viewController
{
  
    [[R2GoogleHelper sharedInstance] loginFromViewController:viewController
                                         onCompletionHandler:^(int code,
                                                               NSString *msg,
                                                               R2LoginResponse  * r2LoginResult,
                                                               NSDictionary *result) {
        if (code == 0) {
            [SDK_DATA saveLoginType:LoginTypeGoogle];
            [self loginSuccess:r2LoginResult];
        } else{
            NSLog(@"login failed,code -> %d,msg -> %@",code,msg);
        }
    }];
    
}

+(void)loginSuccess:(R2LoginResponse *) r2LoginResult
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
    
    [hillTopViewController dismissViewControllerAnimated:NO completion:nil];
    
    if ([R2SDKPlat shareR2SDK].loginCompletionHandler) {
    
        [R2SDKPlat shareR2SDK].loginCompletionHandler(r2LoginResult);
    }
}

+(void) logoutAccount
{
    [SDK_DATA releaseData];
    [hillTopViewController dismissViewControllerAnimated:NO completion:nil];
    if ([R2SDKPlat shareR2SDK].logoutHandler) {
        
        [R2SDKPlat shareR2SDK].logoutHandler(SDK_DATA.gameLoginType);
    }
    [SDK_DATA releaseData];
}


+(void)bindFacebook:(UIViewController *)viewController
{

    [[R2FacebookMgrHelper sharedHelper]bindFBWithViewController:viewController
                                            withReadPermissions:@[@"public_profile"]
                                              andR2UidToBeBound:SDK_DATA.gameUserId
                                              completionHandler:^(int code, NSString *msg, R2FacebookLoginResult *result) {
                                                  
                                                  if (code == 1009) {
                                                      [UIUtil showAlertTips:GET_SDK_LOCALIZED(@"FB_HAS_BIND")];
                                                  }else  if (code == FACEBOOK_BIND_SUCCESS) {
                                                      NSLog(@"facebook login and bind r2 account successfully,[%@%@%@]",result.fbUserId,result.fbUsername,result.fbImageUrl);
                                                            [SDK_DATA saveLoginType:LoginTypeFacebook];
                                                      [viewController dismissViewControllerAnimated:NO completion:nil];
                                                  }else {
                                                       [UIUtil showAlertTips:GET_SDK_LOCALIZED(@"BIND_FAIL")];
                                                              NSLog(@"facebook login and bind r2 account failed,code = %d,msg = %@",code,msg);
                                                    }
                                              }
     
     
     ];
                                                          
}

+(void) bindGoogle:(UIViewController *)viewController
{
    [[R2GoogleHelper sharedInstance] switchFromViewController:viewController enableCreateNewAccount:YES
                                          onCompletionHandler:^(int code, NSString *msg, R2LoginResponse * r2LoginResult, NSDictionary *result) {
                                              
                                              if (code == 0) {
                                                  NSString *r2UserId = r2LoginResult.r2Uid;
                                                  NSString *loginTimestamp = r2LoginResult.timestamp;
                                                  NSString *sign = r2LoginResult.sign;
                                                  NSLog(@"current r2 uid = %@",r2UserId);
                                              } else{
                                                  NSLog(@"switch failed,code -> %d,msg -> %@",code,msg);
                                              }
                                          }];
}

                  
@end
