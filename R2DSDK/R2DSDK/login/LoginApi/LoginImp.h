//
//  LoginImp.h
//  R2DSDK
//
//  Created by ganyuanrong on 2019/5/30.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <R2SDKFramework/R2SDKFramework.h>
#import <R2FacebookFramework/R2FacebookFramework.h>
#import <R2GoogleFramework/R2GoogleFramework.h>
#import "R2DHeader.h"
#import "R2SDKPlat.h"
#import "../view/UIViewUtil.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginImp : NSObject

+(void) loginGuestAccount:(UIViewController *)viewController;

+(void) loginFBAccount:(UIViewController *)viewController;


+(void) loginGoogleAccount:(UIViewController *)viewController;

+(void) bindGoogle:(UIViewController *)viewController;


+(void)bindFacebook:(UIViewController *)viewController;

+(void) logoutAccount;

+(void)loginSuccess:(R2LoginResponse *) r2LoginResult;

+(void)unbindFacebook:(UIViewController *)viewController;

+(void) unbindGoogle:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
