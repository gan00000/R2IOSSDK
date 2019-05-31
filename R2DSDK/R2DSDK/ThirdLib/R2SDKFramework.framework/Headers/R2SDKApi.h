//
//  R2SDK.h
//  R2SDK
//
//  Created by luxing on 7/24/15.
//  Copyright (c) 2015 luxing. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "R2SDKBaseResponse.h"
#import "R2RegisterResponse.h"
#import "R2LoginResponse.h"
#import "R2BindResponse.h"
#import "R2QueryResponse.h"
#import "R2WebLoginResponse.h"

#define R2_OK 0

typedef void (^R2CompletionHandler)(int code,NSString* msg,id<R2SDKResponse> result);
typedef void (^R2BaseCompletionHandler)(int code,NSString* msg,R2SDKBaseResponse* result);

typedef void (^R2RegisterCompletionHandler)(int code,NSString* msg,R2RegisterResponse* result);
typedef void (^R2LoginCompletionHandler)(int code,NSString* msg,R2LoginResponse* result);
typedef void (^R2BindCompletionHandler)(int code,NSString* msg,R2BindResponse* result);
typedef void (^R2QueryCompletionHandler)(int code,NSString* msg,R2QueryResponse* result);

typedef void (^R2WebLoginCompletionHandler)(int code,NSString* msg,R2WebLoginResponse* result);
typedef void (^R2BindR2AccountCompletionHandler)(int code, NSString* msg);


@interface R2SDKApi : NSObject


/* SDK init */
+(void)init;


/* R2 account register */
+(R2RegisterResponse*) registerWithAccount:(NSString*)account andPassword:(NSString*)password;
+(void) registerAsyncWithAccount:(NSString*)account andPassword:(NSString*)password completionHandler:(R2RegisterCompletionHandler)handler;

/* r2 account login */
+(R2LoginResponse*) loginWithAccount:(NSString*)account andPassword:(NSString*)password;
+(void) loginAsyncWithAccount:(NSString*)account andPassword:(NSString*)password completionHandler:(R2LoginCompletionHandler)handler;




/* R2 SDK Login */
//+(void) doGameCenterLoginFromViewController:(UIViewController*)viewController completionHandler:(R2GameCenterLoginCompletionHandler)handler;


/**
 此接口有一定bug，禁止所有新游戏使用
 */
+(void) loginWithGameCenter:(UIViewController*)viewController completionHandler:(R2LoginCompletionHandler)handler;

/*all new games use this method,old games must not use this method*/
+(void) loginWithGameCenterFromViewController:(UIViewController*)viewController completionHandler:(R2LoginCompletionHandler)handler;

+(void) loginWithoutGameCenterOnCompletionHandler:(R2LoginCompletionHandler)handler;

+(void) loginAsyncWithTokenOrGuestAccount:(R2LoginCompletionHandler)handler;

+(void) loginWithGameCenter:(UIViewController*)viewController checkFacebookToken:(BOOL)checking completionHandler:(R2LoginCompletionHandler)handler;


+(void) launchR2LoginUIFromViewController:(UIViewController*)viewController completionHandler:(R2LoginCompletionHandler)handler;




/* third-party account login */
+(R2LoginResponse*) loginWithThirdPartyAccount:(NSString*)account andType:(NSString*)type;
+(void) loginAsyncWithThirdPartyAccount:(NSString*)account andType:(NSString*)type completionHandler:(R2LoginCompletionHandler)handler;



/* token login */
+(R2LoginResponse*) loginWithToken:(NSString*)token ThirdPartyAccount:(NSString*)account ThirdPartyType:(NSString*)type;
+(void) loginAsyncWithToken:(NSString*)token ThirdPartyAccount:(NSString*)account ThirdPartyType:(NSString*)type completionHandler:(R2LoginCompletionHandler)handler;


/* new account login */
//+(R2LoginResponse*) loginWithNewAccount;
//+(void) loginAsyncWithNewAccount:(R2LoginCompletionHandler)handler;

//由于通过IDFA产生的游客账号，存在一定的风险性。建议新游戏不要使用该方法
+(R2LoginResponse*) loginWithGuestAccount;
+(void) loginAsyncWithGuestAccount:(R2LoginCompletionHandler)handler;

//do no fixed guest login ,when app unload produce a new guest accout
+(void)loginAsyncWithNoFixedGuestAccount:(R2LoginCompletionHandler)handler;

+(R2LoginResponse*) loginWithFixedGuestAccount;
+(void) loginAsyncWithFixedGuestAccount:(R2LoginCompletionHandler)handler;


/* bind r2 account */
+(R2BindResponse*) bindWithR2Uid:(NSString*)r2Uid R2Account:(NSString*)account R2Password:(NSString*)password;
+(void) bindAsyncWithR2Uid:(NSString*)r2Uid R2Account:(NSString*)account R2Password:(NSString*)password completionHandler:(R2BindCompletionHandler)handler;


/* bind new r2 account */
+(R2BindResponse*) bindWithR2Uid:(NSString*)r2Uid NewR2Account:(NSString*)account NewR2Password:(NSString*)password;
+(void) bindAsyncWithR2Uid:(NSString*)r2Uid NewR2Account:(NSString*)account NewR2Password:(NSString*)password completionHandler:(R2BindCompletionHandler)handler;

+(void)bindR2AccountWithR2Uid:(NSString *)r2Uid withViewController:(UIViewController *)viewController completionHandler:(R2BindR2AccountCompletionHandler)handler;


/* bind third party account*/
+(R2BindResponse*) bindWithR2Uid:(NSString*)r2Uid ThirdPartyAccount:(NSString*)account ThirdPartyType:(NSString*)type;
+(void) bindAsyncWithR2Uid:(NSString*)r2Uid ThirdPartyAccount:(NSString*)account ThirdPartyType:(NSString*)type completionHandler:(R2BindCompletionHandler)handler;


/* single query third party uid*/
+(R2QueryResponse*) queryThirdPartyAccountWithR2Uid:(NSString*)r2Uid;
+(void) queryAsyncThirdPartyAccountWithR2Uid:(NSString*)r2Uid completionHandler:(R2QueryCompletionHandler)handler;

/* single query r2 uid*/
+(R2QueryResponse*) queryR2UidWithThirdPartyAccount:(NSString*)account ThirdPartyType:(NSString*)type;

+(void) queryAsyncR2UidWithThirdPartyAccount:(NSString*)account ThirdPartyType:(NSString*)type completionHandler:(R2QueryCompletionHandler)handler;

/* batch query r2 uid*/
+(R2QueryResponse*) queryR2UidsWithThirdPartyAccounts:(NSArray*)accounts ThirdPartyType:(NSString*)type;
+(void) queryAsyncR2UidsWithThirdPartyAccounts:(NSArray*)accounts ThirdPartyType:(NSString*)type completionHandler:(R2QueryCompletionHandler)handler;

/* activate */
+(R2SDKBaseResponse*) activate;
+(void) activateAsyncWithCompletionHandler:(R2BaseCompletionHandler)handler;


///* Web login */
+(R2WebLoginResponse *)webLoginWithR2Uid:(NSString *)r2uid;
+(void)webLoginAsyncWithR2Uid:(NSString *)r2uid completionHandler:(R2WebLoginCompletionHandler)handler;


+(void)gameRoleLoginAsyncWithR2Uid:(NSString*)r2uid
                            roleId:(NSString*)rid
                          roleName:(NSString*)rname
                         roleLevel:(NSString*)rlevel
                          serverId:(NSString*)sid
                     isNewGameRole:(BOOL)isnew
                 completionHandler:(R2BaseCompletionHandler)handler;

+(UIViewController *)getCurrentVC;
+(UIViewController *)_topViewController:(UIViewController *)vc;

@end
