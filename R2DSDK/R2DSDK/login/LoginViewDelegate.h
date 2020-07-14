//
//  LoginViewDelegate.h
//  CCSkyHourSDK
//
//  Created by ganyuanrong on 2019/5/30.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCSkyHourHeader.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LoginViewDelegate <NSObject>

-(void)clickFbLogin;
-(void)clickGoogleLogin;
-(void)clickGuestLogin;

-(void)goPageView:(CURRENT_PAGE_TYPE) pageType;

-(void)goBackBtn:(UIView *)backView backCount:(NSUInteger) count;

-(void)logout;
-(void)loginSuccess;

-(void)clickBindFacebook;
-(void)clickBindGoogle;


@end

NS_ASSUME_NONNULL_END
