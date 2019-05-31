//
//  R2LoginWithFbInGame.h
//  R2SDKFramework
//
//  Created by LUXING on 16/3/16.
//  Copyright © 2016年 r2games. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "R2SDKApi.h"


#define LWF_SUCCESS 1
#define LWF_CHANGE_TO_NEW_ACCOUNT 10
#define LWF_CHANGE_TO_OLD_ACCOUNT 20


#define LWF_REFUSE_TO_CHANGE 100
#define LWF_UNKNOWN_ERROR 500
#define LWF_FAILED_TO_LOGIN_ERROR 600



typedef void (^R2LoginWithFbInGameCompletionHandler)(int code,NSString* msg,R2LoginResponse* result);


@interface R2LoginWithFbInGame : NSObject<UIAlertViewDelegate>


@property (nonatomic,assign)UIViewController* gameViewController;
@property int currentErrorCode;
@property NSString* facebookUID;
@property NSString* r2UID;
@property UIAlertView *alert;


+(void)doWithViewController:(UIViewController*)vc facebookUserId:(NSString*)fbUid r2UserId:(NSString*)r2Uid onCompletionHandler:(R2LoginWithFbInGameCompletionHandler)handler;

-(id)initWithViewController:(UIViewController*)vc facebookUserId:(NSString*)fbUid r2UserId:(NSString*)r2Uid onCompletionHandler:(R2LoginWithFbInGameCompletionHandler)handler;
-(void)start;
-(void)handlerErrorCode:(int)errorCode;


@end
