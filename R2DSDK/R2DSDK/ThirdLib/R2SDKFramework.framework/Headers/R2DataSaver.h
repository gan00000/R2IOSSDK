//
//  R2DataSaver.h
//  R2GMDemo
//
//  Created by luxing on 8/26/15.
//  Copyright (c) 2015 luxing. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DOCUMENT_DIRECTORY_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0]

#define _R2_HAS_PLAYER_LOGIN_WITH_FB_ACCOUNT_ @"r2hasplayerloginwithfbaccount"

#define R2SDKModeSandbox @"r2ModeSandbox"
#define R2SDKModeProduction @"r2ModeProduction"

@interface R2DataSaver : NSObject

+(NSString*)getDocumentsPath;

+(void)saveBoolToStandardUserDefaults:(BOOL)YesOrNo withKeyNamed:(NSString*)key;
+(BOOL)getBoolFromStandardUserDefaults:(NSString*)key;

+(void)saveObjectToStandardUserDefaults:(id)obj withKeyNamed:(NSString*)key;
+(id)getObjectFromStandardUserDefaults:(NSString*)key;

+(BOOL)saveDictionary:(NSDictionary*)data toDocumentsFile:(NSString*)fileName;
+(NSDictionary*)getDictionaryFromDocumentsFile:(NSString*)fileName;

+(void)saveCurrentToken:(NSString *)token;
+(NSString *)getCurrentToken;
+(void)clearCurrentToken;

+(NSString *)getOldAccountUID;

/**保存FACEBOOK 用户名以及用户ID*/
+(void)saveFacebookUserInfo:(NSDictionary *)info;

/**根据FACEBOOK用户ID获取用户名*/
+(NSString*)getFacebookNameWithFBUid:(NSString*)fbuid;

/**保存GAMECENTER 用户名以及用户ID*/
+(void)saveGameCenterUserInfo:(NSDictionary *)info;

/**根据GAMECENTER用户ID获取用户名*/
+(NSString*)getGameCenterNameWithGCUid:(NSString*)gcuid;

/**
 保存r2订单号与苹果订单号的一一对应的字典
 */
+(void)saveR2CnoTransactionId:(NSDictionary *)info;

/**
 根据苹果订单号transaction identifier 来获取r2订单号
 */
+(NSString *)getR2CnoWithTransaction:(NSString *)transid;

/**
 根据苹果订单号transaction identifier 来删除r2订单号
 */
+(NSString *)deleteR2CnoWithTransaction:(NSString *)transid;

+(void)saveSDKMode:(NSString *)mode;

+(NSString *)getSDKMode;


+(void)saveAfAdSourceInfo:(NSString *)sourceInfo;
+(NSString *)getAfAdSourceInfo;
    
    

+(void)saveUid:(NSString *)uid;

+(NSString *)getUid;

+(void)saveIsNew:(BOOL)isNew;

+(BOOL)isNewUser;
   

@end
