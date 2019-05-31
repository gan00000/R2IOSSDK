//
//  R2LoginResponse.h
//  R2SDK
//
//  Created by luxing on 7/27/15.
//  Copyright (c) 2015 luxing. All rights reserved.
//

#import "R2SDKBaseResponse.h"


#define _R2_LOGIN_RESP_R2_UID_ @"muid"
#define _R2_LOGIN_RESP_TOKEN_ @"token"
#define _R2_LOGIN_RESP_GC_UID_ @"gcid"
#define _R2_LOGIN_RESP_FB_UID_ @"fbid"

#define _R2_LOGIN_RESP_R2_ @"r2"
#define _R2_LOGIN_RESP_USERNAME_ @"username"
#define _R2_LOGIN_RESP_BOUND_R2_ACCOUNT_ @"boundR2Account"

#define _R2_LOGIN_RESP_TIMESTAMP_ @"time"
#define _R2_LOGIN_RESP_SIGN_FOR_DATA_ @"sign"

#define _R2_LOGIN_RESP_DATA_FOR_TOKEN_ @"token"
#define _R2_LOGIN_RESP_DATA_FOR_TUID_ @"openid"

#define _R2_LOGIN_RESP_TWITTERID @"twitterid"
#define _R2_LOGIN_RESP_ISNEW @"is_new"


@interface R2LoginResponse : R2SDKBaseResponse

@property NSString* r2Uid;
@property NSString* token;

@property BOOL isBoundToGameCenter;
@property NSString* gameCenterUid;

@property BOOL isBoundToGoogleAccount;
@property NSString* googleAccountUid;

@property BOOL isBoundToFacebook;
@property NSString* facebookUid;

@property NSString* r2;
@property BOOL isBoundToR2Account;
@property NSString* boundR2Account;
@property NSString* username;

@property NSString* timestamp;
@property NSString* sign;
@property NSDictionary* dataForToken;
@property NSDictionary* dataForThirdPartyAccount;

@property(nonatomic,strong)NSString *twitterid;
@property(nonatomic,assign)BOOL isBoundToTwitter;

/**
 是否是新生成的账号
 */
@property(nonatomic,assign) BOOL isNew;

-(void)initWithData:(NSData*)serverData;
-(void)clear;

@end
