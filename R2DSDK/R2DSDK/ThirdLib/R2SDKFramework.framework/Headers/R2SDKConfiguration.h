//
//  R2SDKConfig.h
//  R2SDK
//
//  Created by luxing on 7/24/15.
//  Copyright (c) 2015 luxing. All rights reserved.
//

#import <Foundation/Foundation.h>

//current version code
#define R2_SDK_VERSION_CODE @"v4.4.0"

@interface R2SDKConfiguration : NSObject
+(NSString*)getKey;
+(NSString*)getServerSideEncryptKey;
+(NSString*)getRegisterRequestUrl;
+(NSString*)getLoginRequestUrl;
+(NSString*)getGameRoleLoginRequestUrl;
+(NSString*)getNewGameRoleCreateRequestUrl;
+(NSString*)getOldLoginRequestUrl;
+(NSString*)getBindR2AccountRequestUrl;
+(NSString*)getBindNewR2AccountRequestUrl;
+(NSString*)getBindThirdPartyAccountRequestUrl;
+(NSString*)getSingleQueryRequestUrl;
+(NSString*)getBatchQueryRequestUrl;
+(NSString*)getActivationRequestUrl;
+(NSString*)getUnwrapRequestUrl;
+(NSString*)getWebLoginRequestUrl;
+(NSString*)getShareLinkRequestUrl;
+(NSString*)getreportInvationRequestUrl;

@end
