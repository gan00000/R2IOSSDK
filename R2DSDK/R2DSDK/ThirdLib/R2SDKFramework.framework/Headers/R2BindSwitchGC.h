//
//  R2BindSwitchGC.h
//  R2SDKFramework
//
//  Created by LUXING on 2016/11/7.
//  Copyright © 2016年 r2games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "R2LoginResponse.h"


#define BSGC_BOUND_SUCCESS 1

#define BSGC_SWITCH_TO_NEW_ACCOUNT 2

#define BSGC_CHANGE_TO_OLD_ACCOUNT 3

#define BSGC_UNKNOWN_ERR 500

#define BSGC_FAILED_LOGIN_GC_ERR 501

#define BSGC_FAILED_TO_LOGIN_WITH_GC_UID_ERROR 502

#define BSGC_REFUSE_TO_SWITCH_ACCOUNT_ERR 503



typedef void (^R2BindSwitchGCCompletionHandler)(int code,NSString* msg,R2LoginResponse* result);

@interface R2BindSwitchGC : NSObject

@property(weak) UIViewController *topVC;

@property(copy) NSString *r2Uid;

@property(copy) NSString *playerID;

@property int currentErrorCode;

@property R2BindSwitchGCCompletionHandler completionHandler;

+(void)doWithViewController:(UIViewController*)vc r2UserId:(NSString*)r2UserId onCompletionHandler:(R2BindSwitchGCCompletionHandler)handler;

-(void)exe;

@end
