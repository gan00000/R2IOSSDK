//
//  LoginImp.h
//  CCSkyHourSDK
//
//  Created by ganyuanrong on 2019/5/30.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CCSkyHourHeader.h"
#import "CCSkyHourSDKPlat.h"
#import "CCSDKResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginImp : NSObject

+(void) loginGuestAccount:(UIViewController *)viewController isFormAutoLogin:(BOOL)isFormAutoLogin;

+(void) loginFBAccount:(UIViewController *)viewController isFormAutoLogin:(BOOL)isFormAutoLogin;


+(void) loginGoogleAccount:(UIViewController *)viewController isFormAutoLogin:(BOOL)isFormAutoLogin;

+(void) bindGoogle:(UIViewController *)viewController;


+(void)bindFacebook:(UIViewController *)viewController;

+(void) logoutAccount:(UIViewController *) mController;

+(void)loginSuccess:(CCSDKResponse *) r2LoginResult mController:(UIViewController *) mController;

+(void)unbindFacebook:(UIViewController *)viewController;

+(void) unbindGoogle:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
