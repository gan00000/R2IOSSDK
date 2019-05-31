//
//  LoginViewDelegate.h
//  R2DSDK
//
//  Created by ganyuanrong on 2019/5/30.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoginViewDelegate <NSObject>

-(void)clickFbLogin;
-(void)clickGoogleLogin;
-(void)clickGuestLogin;

-(void)goBindView;
-(void)goGuestLoginoutTipsView;
-(void)logout;
-(void)clickBindFacebook;
-(void)clickBindGoogle;
-(void)unBindGoogle;
-(void)unBindFacebook;

@end

NS_ASSUME_NONNULL_END
