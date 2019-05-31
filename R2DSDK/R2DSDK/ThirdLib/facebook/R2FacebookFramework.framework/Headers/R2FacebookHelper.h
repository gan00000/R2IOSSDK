//
//  R2FacebookHelper.h
//  Created by luxing on 9/9/15.
//  Copyright (c) 2015 luxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <R2SDKFramework/R2SDKFramework.h>
#import "R2FacebookLoginResult.h"
#import "R2FacebookGameRequestResult.h"
#import "R2FacebookGameRequestEntity.h"



/*
 * download url: https://developers.facebook.com/docs/ios/downloads
 * Developed based on R2SDKFramework v4.38.0
 */
#define R2_FACEBOOK_SDK_VERSION_CODE @"v2.2.6"

//the constant code and message for success
#define R2_FACEBOOK_SUCCESS_CODE 0
#define R2_FACEBOOK_SUCCESS_DESCRIPTION @"success"

#define R2_FACEBOOKUIDLOGIN_SUCCESS_CODE 0

#define R2_FACEBOOK_SHARE_LINK_CONTENT 1001
#define R2_FACEBOOK_SHARE_OPEN_GRAPH_STORY 1002
#define R2_FACEBOOK_SHARE_IMAGE 1003

typedef void (^R2FacebookCompletionHanlder)(int code,NSString *msg,NSDictionary *result);

typedef void (^R2FacebookLoginCompletionHanlder)(int code,NSString *msg,R2FacebookLoginResult *result);

typedef void (^R2FacebookLoginEnableSwitchingAccountCompletionHanlder)(int code,NSString *msg,R2FacebookLoginResult *facebookLoginResult,R2LoginResponse *r2LoginResult);

typedef void (^R2FacebookGetGameFriendsCompletionHanlder)(int code,NSString *msg,NSArray *result);

typedef void (^R2FacebookGameRequestCompletionHanlder)(int code,NSString *msg,R2FacebookGameRequestResult *result);

typedef void (^R2FacebookGetGameRequestsCompletionHanlder)(int code,NSString *msg,NSArray *result);

typedef void (^R2FacebookGetUserInvitableFriendsCompletionHandler)(int code,NSString *msg,NSArray *result);


typedef void (^R2FacebookUidLoginCompletionHandler)(int code,NSString *msg,R2LoginResponse *result);
typedef void (^R2FacebookUIDLoginCompletionHandler)(int code,NSString *msg,R2FacebookLoginResult *facebookLoginResult,R2LoginResponse *r2LoginResult);

typedef void (^R2FacebookLikeCompletionHandler) (BOOL isDone,NSString *msg);


@interface R2FacebookHelper : NSObject<FBSDKSharingDelegate,FBSDKAppInviteDialogDelegate,FBSDKGameRequestDialogDelegate>

@property (copy) R2FacebookLoginCompletionHanlder loginCompletionHandler;
@property (copy) R2FacebookCompletionHanlder shareCompletionHandler;
@property (copy) R2FacebookCompletionHanlder shareOpenGraphStoryCompletionHandler;
@property (copy) R2FacebookCompletionHanlder shareImageCompletionHandler;
@property (copy) R2FacebookCompletionHanlder inviteCompletionHandler;
@property (copy) R2FacebookGetGameFriendsCompletionHanlder getGameFriendsCompletionHandler;
@property (copy) R2FacebookGameRequestCompletionHanlder gameRequestCompletionHandler;
@property (copy) R2FacebookGetGameRequestsCompletionHanlder getGameRequestsCompletionHandler;
@property (copy) R2FacebookCompletionHanlder deleteGameRequestCompletionHandler;
@property (copy) R2FacebookGetUserInvitableFriendsCompletionHandler getUserInvitableFriendsCompletionHandler;
@property (copy) R2FacebookUidLoginCompletionHandler facebookUidLoginCompletionHandler;
@property (copy) R2FacebookUIDLoginCompletionHandler facebookUIDLoginCompletionHandler;
@property (nonatomic,copy) R2FacebookLikeCompletionHandler likeCompletionHandler;

@property int SHARE_WHAT;

@property FBSDKLoginManager* fbLoginManager;

+(R2FacebookHelper*)sharedInstance;

-(FBSDKLoginManager*)sharedFBSDKLoginManager;

//login with read permissions (public_profiles are granted if successful)
/**
 单纯facebook登录 UI必现，未检测当前Facebook token，故每次都会展示登录界面（默认权限 public_profiles）
 */
-(void)loginFromViewController:(UIViewController*)viewController completionHandler:(R2FacebookLoginCompletionHanlder)handler;


/**
 单纯facebook登录 带有免登陆功能，检测当前Facebook token,有token则免界面登录 （默认权限 public_profiles）
 */
-(void)loginFastFromViewController:(UIViewController *)viewController completionHandler:(R2FacebookLoginCompletionHanlder)handler;

/**
 facebook登录完，再做第三方uid登录,只回调uid登录数据，未检测当前Facebook token。（默认权限 public_profiles）
 */
-(void)uidLoginWithViewController:(UIViewController *)viewController completionHandler:(R2FacebookUidLoginCompletionHandler)handler; //RAC使用


/**
 facebook登录完，再做第三方uid登录, 回调数据较全，包括Facebook基本登录数据以及uid登录数据，未检测当前Facebook token。（默认权限 public_profiles）
 */
-(void)UIDLoginWithViewController:(UIViewController *)viewController completionHandler:(R2FacebookUIDLoginCompletionHandler)handler;

/**
 先判断有没有accesstoken ,有的话免界面 登录facebook，登录完，再做第三方uid 登录。回调数据包括R2 login result 和Facebook login result（默认权限 public_profiles）
 */
-(void)loginFastWithViewController:(UIViewController *)viewController completionHandler:(R2FacebookUIDLoginCompletionHandler)handler;//Heroes evolved token登录回调数据较全


//登录Facebook时需要申请读写权限 请用一下接口
-(void)loginFromViewController:(UIViewController*)viewController withReadPermissions:(NSArray *)permissions completionHandler:(R2FacebookLoginCompletionHanlder)handler;
-(void)loginFromViewController:(UIViewController*)viewController withReadPermissions:(NSArray *)permissions andR2UidToBeBound:(NSString*)r2Uid completionHandler:(R2FacebookLoginCompletionHanlder)handler;
-(void)loginFromViewController:(UIViewController*)viewController withReadPermissions:(NSArray *)permissions andR2UidToBeBound:(NSString*)r2Uid enableSwitchingAccount:(BOOL)enable completionHandler:(R2FacebookLoginEnableSwitchingAccountCompletionHanlder)handler;


//login with publish permissions (publish_actions is used if permissions is set nil or empty)
-(void)loginFromViewController:(UIViewController*)viewController withPublishPermissions:(NSArray *)permissions completionHandler:(R2FacebookLoginCompletionHanlder)handler;

//check whether a given permission has been granted or not
-(BOOL)isPermissionGranted:(NSString*)permission;

//check whether the publish_actions permission has been granted or not
-(BOOL)isPublishActionsPermissionGranted;

-(BOOL)hasLoggedInFacebook;

-(BOOL)isFacebookAppInstalled;

-(void)logOut;

-(void)activate;


//share link content
-(void)shareLinkContentFromViewController:(UIViewController*)viewController withShareMode:(FBSDKShareDialogMode)mode contentURL:(NSString*)contentUrl  peopleIDs:(NSArray*)ids placeID:(NSString*)place completionHandler:(R2FacebookCompletionHanlder)handler;

-(void)shareLinkContentFromViewController:(UIViewController*)viewController contentURL:(NSString*)contentUrl  peopleIDs:(NSArray*)ids placeID:(NSString*)place completionHandler:(R2FacebookCompletionHanlder)handler;

//share open graph stories

-(void)shareOpenGraphStoryFromViewControllerWithGrantedPublishPermission:(UIViewController*)viewController actionType:(NSString*)actionType objectType:(NSString*)objectType objectId:(NSString*)objectId objectProperties:(NSDictionary*)objectProperties usingShareDialog:(BOOL)yesOrNo completionHandler:(R2FacebookCompletionHanlder)handler;

-(void)shareOpenGraphStoryFromViewController:(UIViewController*)viewController actionType:(NSString*)actionType objectType:(NSString*)objectType objectId:(NSString*)objectId objectProperties:(NSDictionary*)objectProperties usingShareDialog:(BOOL)yesOrNo completionHandler:(R2FacebookCompletionHanlder)handler;

#pragma mark -<share Image>
//use native app share mode
-(void)shareImageFromViewController:(UIViewController *)viewController withShareImage:(UIImage *)image completionHandler:(R2FacebookCompletionHanlder)handler;


// app invite
// the app for facebook must be installed on the current device
-(void)inviteFromViewController:(UIViewController*)viewController appLinkURL:(NSString*)appLinkUrl previewImageURL:(NSString*)imgUrl completionHandler:(R2FacebookCompletionHanlder)handler;


-(void)getAllGameFriendsWithCompletionHander:(R2FacebookGetGameFriendsCompletionHanlder)handler;


//facebook game requests methods
-(void)sendGameRequestWithType:(FBSDKGameRequestActionType)actionType
                      objectID:(NSString*)objectID
                         title:(NSString*)title
                       message:(NSString*)message
                     extraData:(NSString*)extraData
                    recipients:(NSArray*)recipients
          recipientSuggestions:(NSArray*)recipientSuggestions
                       filters:(FBSDKGameRequestFilter)filters
             completionHandler:(R2FacebookGameRequestCompletionHanlder)handler;

-(void)sendGameRequestWithType:(FBSDKGameRequestActionType)actionType
                      objectID:(NSString*)objectID
                         title:(NSString*)title
                       message:(NSString*)message
                     extraData:(NSString*)extraData
                    recipients:(NSArray*)recipients
          recipientSuggestions:(NSArray*)recipientSuggestions
                       filters:(FBSDKGameRequestFilter)filters
         usingInvitableFriends:(BOOL)isUsing
completionHandler:(R2FacebookGameRequestCompletionHanlder)handler;

-(void)getAllGameRequestsWithCompletionHander:(R2FacebookGetGameRequestsCompletionHanlder)handler;


-(void)deleteGameRequestWithUniqueId:(NSString*)uniqueRequestId completionHandler:(R2FacebookCompletionHanlder)handler;

-(void)getUserInvitableFriendsWithCompletionHandler:(R2FacebookGetUserInvitableFriendsCompletionHandler)handler;


//该功能不再只是 since FacebookSDKs-iOS-4.33.0
-(void)addFBLikeFromViewController:(UIViewController*)viewController withRect:(CGRect )rect  isHidden:(BOOL)isHidden showCount:(BOOL)yesOrNo  likeUrl:(NSString*)url completionHandler:(R2FacebookLikeCompletionHandler)handler DEPRECATED_ATTRIBUTE;


//track purchase event
/**
 * purchaseAmount is double.
 * currency is (NSString *) from http://en.wikipedia.org/wiki/ISO_4217.
 * parameters is (NSDictionary *).
 */
-(void)trackPurchase:(NSString*)purchaseAmount currency:(NSString*)currency parameters:(NSDictionary*)paremeters;

//track normal event
-(void)trackEvent:(NSString*)eventName valueToSum:(double)value parameters:(NSDictionary*)paremeters;

//track achieved level event
-(void)trackAchievedLevel:(NSString*)level extraData:(NSDictionary*)extraData;

//track completed tutorial event
-(void)trackCompletedTutorial:(NSString*)contentData contentId:(NSString*)contentId success:(BOOL)success extraData:(NSDictionary*)extraData;


//Insert this piece of code in your app delegate's applicationDidBecomeActive method
-(void)activateApp;

//Developers can enable debug logs so they can easily verify App Event usages from client sides. The debug logs contain detailed request and response in JSON. You can enable debug logs by adding this code.This is only for debugging purpose. Please make sure to disable debug logs before deploying app in production.
-(void)enableDebug:(BOOL)enable;

@end
