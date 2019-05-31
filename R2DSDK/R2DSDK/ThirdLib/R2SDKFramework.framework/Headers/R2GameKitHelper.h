//
//  R2GameKitHelper.h
//  R2SDKFramework
//
//  Created by LUXING on 16/3/2.
//  Copyright © 2016年 r2games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "R2SDKApi.h"

#define GAMECENTER_BIND_SUCCESS 0
#define GAMECENTER_BIND_FAILED 2000
#define GAMECENTER_BIND_MATCH_ERR 2001
#define GAMECENTER_BIND_ERR 1008
#define GAMECENTER_BIND_LOGIN_ERR 2002

#define GAMECENTER_SWITCH_SUCCESS 0
#define GAMECENTER_SWITCH_FAILED 104 //切换的game center账号已经绑定了其他游戏账号
#define GAMECENTER_SWITCH_LOGIN_FAILED 108  //登录game center失败

typedef void (^R2GameKitCompletionHandler)(BOOL isSuccessful,NSString* msg);
typedef void (^R2GameKitLoginCompletionHandler)(BOOL isSuccessful,NSString* msg,NSDictionary* playerData);
typedef void (^R2GameKitLoadAchievementsCompletionHandler)(BOOL isSuccessful,NSString* msg,NSArray<GKAchievement *> *achievements);
typedef void (^R2GameKitLoadLeadboardCompletionHandler)(BOOL isSuccessful,NSString* msg,NSArray<GKScore *> *scores);



typedef void (^R2GCUIDLoginHandler) (int code ,NSString *msg,R2LoginResponse *result,id playerData);

typedef void (^R2GCBindHandler) (int code,NSString *msg,R2BindResponse *result);
typedef void (^R2GCBindResponseHandler)(int code,NSString *msg,R2BindResponse *result,id playerData);

typedef void (^R2GCSwitchHandler) (int code ,NSString *msg,R2LoginResponse *result);


@interface R2GameKitHelper : NSObject<GKGameCenterControllerDelegate>

@property BOOL isPlayerLoggedIn;
@property GKLocalPlayer* localPlayer;

@property BOOL isLoggingWithGC;
@property BOOL hasLoginWithGCFailedBefore;

@property(atomic,copy) NSString *playerID;
@property(atomic) BOOL enableCreateNewAccount;


+(R2GameKitHelper*)sharedInstance;

-(id)init;

/* login */

-(void)doGameCenterLoginFromViewController:(UIViewController*)viewController completionHandler:(R2GameKitLoginCompletionHandler)handler;

/* end */

/* achivements */

-(void)showAchievementsFromViewController:(UIViewController*)viewController;

-(void)reportPercentComplete:(double)percent toAchievementWithIdentifier:(NSString*)identifier showsCompletionBanner:(BOOL)showing withCompletionHandler:(R2GameKitCompletionHandler)completionHandler;
-(void)reportPercentComplete:(double)percent ofCurrentPlayerR2UID:(NSString*)r2Uid toAchievementWithIdentifier:(NSString*)identifier showsCompletionBanner:(BOOL)showing withCompletionHandler:(R2GameKitCompletionHandler)completionHandler;

-(void)loadAchievementsWithCompletionHandler:(R2GameKitLoadAchievementsCompletionHandler)completionHandler;
-(void)loadAchievementsOfCurrentPlayerR2UID:(NSString*)r2Uid WithCompletionHandler:(R2GameKitLoadAchievementsCompletionHandler)completionHandler;

/* end */


/* leaderboards */

-(void)showLeaderboardFromViewController:(UIViewController*)viewController withLeaderboardIdentifier:(NSString*)leaderboardIdentifier;

-(void)reportScoreValue:(long long)value toLeaderboard:(NSString*)leaderboardIdentifier withCompletionHandler:(R2GameKitCompletionHandler)completionHandler;
-(void)reportScoreValue:(long long)value ofCurrentPlayerR2UID:(NSString*)r2Uid toLeaderboard:(NSString*)leaderboardIdentifier withCompletionHandler:(R2GameKitCompletionHandler)completionHandler;

-(void)loadLeaderboardWithIdentifier:(NSString*)leaderboardIdentifier withCompletionHandler:(R2GameKitLoadLeadboardCompletionHandler)completionHandler;
-(void)loadLeaderboardWithIdentifier:(NSString*)leaderboardIdentifier ofCurrentPlayerR2UID:(NSString*)r2Uid withCompletionHandler:(R2GameKitLoadLeadboardCompletionHandler)completionHandler;

/* end */



-(void)UIDLoginWithViewController:(UIViewController *)viewController completionHandler:(R2GCUIDLoginHandler)handler;

-(void)bindWithGameCenterFromViewController:(UIViewController *)viewController r2userId:(NSString*)r2Uid completionHandler:(R2GCBindHandler)handler;
-(void)bindGameCenter:(UIViewController *)viewController r2userId:(NSString*)r2Uid completionHandler:(R2GCBindResponseHandler)handler;


-(void)switchGCWithViewController:(UIViewController *)viewController enableCreateNewAccount:(BOOL)enable completionHandler:(R2GCSwitchHandler)handler;
-(void)switchGCWithViewController:(UIViewController *)viewController completionHandler:(R2GCSwitchHandler)handler;

-(BOOL)gameCenterLoggedIn;

@end
