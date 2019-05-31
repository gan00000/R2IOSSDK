//
//  R2LoginWithGcInGame.h
//  R2SDKFramework
//
//  Created by LUXING on 16/6/12.
//  Copyright © 2016年 r2games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "R2SDKApi.h"



#define LWGC_SUCCESS 1
#define LWGC_CHANGE_TO_NEW_ACCOUNT 10
#define LWGC_CHANGE_TO_OLD_ACCOUNT 20

#define LWGC_REFUSE_TO_CHANGE 100
#define LWGC_NO_PLAYER_ID_RECEIVED 200
#define LWGC_NO_R2_ID_RECEIVED 300
#define LWGC_CURRENT_ACCOUNT_FROM_FB 400
#define LWGC_UNKNOWN_ERROR 500
#define LWGC_FAILED_TO_LOGIN_ERROR 600
#define LWGC_CANNOT_BOUND_ERROR 700


typedef void (^R2LoginWithGcInGameCompletionHandler)(int code,NSString* msg,R2LoginResponse* result);


@interface R2LoginWithGcInGame : NSObject<UIAlertViewDelegate>

@property (nonatomic,assign)UIViewController* gameViewController;
@property BOOL enableSwitchingAccount;
@property BOOL checkingFacebookToken;
@property NSString* playerID;
@property NSString* currentLoginR2UID;
@property int currentErrorCode;
@property UIAlertView *alert;


+(void)doWithViewController:(UIViewController*)vc r2UserId:(NSString*)r2Uid onCompletionHandler:(R2LoginWithGcInGameCompletionHandler)handler;

+(void)doWithViewController:(UIViewController*)vc r2UserId:(NSString*)r2Uid enableSwitchingAccount:(BOOL)enable onCompletionHandler:(R2LoginWithGcInGameCompletionHandler)handler;

+(void)doWithViewController:(UIViewController*)vc r2UserId:(NSString*)r2Uid enableSwitchingAccount:(BOOL)enable checkingFacebookToken:(BOOL)checking onCompletionHandler:(R2LoginWithGcInGameCompletionHandler)handler;

-(id)initWithViewController:(UIViewController*)vc andR2UID:(NSString*)r2Uid onCompletionHandler:(R2LoginWithGcInGameCompletionHandler)handler;

-(void)start;

-(void)onGameCenterReturnData:(NSDictionary*)playerInfo;

-(void)handlerErrorCode:(int)errorCode;

@end
