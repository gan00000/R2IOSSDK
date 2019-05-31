//[zt]
//  R2SDKMgrApi.h
//  R2SDKFramework
//
//  Created by 左细平 on 2016/11/8.
//  Copyright © 2016年 r2games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "R2LoginResponse.h"
#import "R2BindResponse.h"
#import "R2UnwrapResponse.h"
#import "R2SDKPaymentTransactionObserverV2.h"
#import "R2ShareResponse.h"


#define R2_LOGIN_SUCCESS 0

typedef void (^R2LoginHandler) (int code,NSString *msg,R2LoginResponse *result);
typedef void (^R2BindCompletionHandler)(int code,NSString* msg,R2BindResponse* result);
typedef void (^R2UnwrapHandler) (int code,NSString *msg,R2UnwrapResponse *result);
typedef void (^RNShareLinkHandler) (int code,NSString *msg,R2ShareResponse *result);

@interface R2SDKMgrApi : NSObject

@property(nonatomic,strong)R2SDKPaymentTransactionObserverV2 *transactionObserver;

+(id)sharedInstance;

/* SDK initialization */
-(void)sdkInit;


/* SDK uninitialization */
-(void)sdkUninit;

/**
 新游戏统一使用该登录接口（token与游客登录）
 */
-(void)loginWithCompletionHandler:(R2LoginHandler)handler;

-(void)doTokenLogin:(R2LoginHandler)handler;

-(void)loginWithBandNewAccount:(R2LoginHandler)handler;

/**
 登出
 */
-(void)logout;


/**
 当前是否有token

 */
-(BOOL)isHasCurrentToken;
-(BOOL)hasCurrentToken;




/**
 绑定第三方账号的UID接口
 
 @param r2Uid   当前玩家的 R2 UID
 @param account 第三方账号对应的用户 ID
 @param type    第三方账号类型(GameCenter 传入"1"，Facebook 账号传入"2")
 */
-(void)bindAsyncWithR2Uid:(NSString*)r2Uid ThirdPartyAccount:(NSString*)account ThirdPartyType:(NSString*)type completionHandler:(R2BindCompletionHandler)handler;



/**
 解绑
 
 @param muid game center or facebook uid
 @param type game center 传“1”，facebook 传"2"
 */
-(void)unwrap:(NSString *)muid openType:(NSString *)type completionHandler:(R2UnwrapHandler)handler;




-(void)addR2TransactionObserver;
-(void)removeR2TransactionObserver;



/**
 在应用内请求评分，显不显示评分窗口，由苹果控制。
 */
-(void)requestRating;
-(void)setSDKMode:(NSString*)mode;


//share and invite
-(void)shareFromViewController:(UIViewController*)viewController serverId:(NSString *)serverId roleId:(NSString *)roleId roleName:(NSString *)roleName icon:(NSString *)icon  CompletionHandler:(RNShareLinkHandler)handler __attribute__((deprecated("使用shareFromViewController: serverId: roleId: roleName: muid: icon: CompletionHandler:方法传入")));

-(void)shareFromViewController:(UIViewController*)viewController serverId:(NSString *)serverId roleId:(NSString *)roleId roleName:(NSString *)roleName muid:(NSString *)muid icon:(NSString *)icon  CompletionHandler:(RNShareLinkHandler)handler;

//report invation information to server(新注册玩家才使用此接口)
-(void)reportInvitationWithServerId:(NSString *)serverId roleId:(NSString *)roleId roleName:(NSString *)roleName completionHandler:(RNShareLinkHandler)handler __attribute__((deprecated("使用reportInvitationWithServerId: roleId:  roleName: muid:  completionHandler:方法传入")));

-(void)reportInvitationWithServerId:(NSString *)serverId roleId:(NSString *)roleId roleName:(NSString *)roleName muid:(NSString *)muid completionHandler:(RNShareLinkHandler)handler;

-(void)getCurrentWebView:(UIWebView*)webView;

-(UIViewController*)getCurrentVC;
@end
