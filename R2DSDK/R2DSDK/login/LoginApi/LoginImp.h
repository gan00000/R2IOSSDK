//
//  LoginImp.h
//  R2DSDK
//
//  Created by ganyuanrong on 2019/5/30.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "R2DHeader.h"
#import "R2SDKPlat.h"
#import "../view/UIViewUtil.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginImp : NSObject

+(void) loginGuestAccount:(UIViewController *)viewController isFormAutoLogin:(BOOL)isFormAutoLogin;

+(void) loginFBAccount:(UIViewController *)viewController isFormAutoLogin:(BOOL)isFormAutoLogin;


+(void) loginGoogleAccount:(UIViewController *)viewController isFormAutoLogin:(BOOL)isFormAutoLogin;

+(void) bindGoogle:(UIViewController *)viewController;


+(void)bindFacebook:(UIViewController *)viewController;

+(void) logoutAccount:(UIViewController *) mController;

+(void)loginSuccess:(R2LoginResponse *) r2LoginResult mController:(UIViewController *) mController;

+(void)unbindFacebook:(UIViewController *)viewController;

+(void) unbindGoogle:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
