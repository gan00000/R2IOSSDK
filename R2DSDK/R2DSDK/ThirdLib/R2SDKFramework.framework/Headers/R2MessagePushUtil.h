//
//  R2MessagePushUtil.h
//  R2FacebookDemo
//
//  Created by LUXING on 15/12/24.
//  Copyright © 2015年 LUXING. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface R2MessagePushUtil : NSObject

+(NSString*)getToken;

+(NSString*)getTimeStamp;

+(NSString*)getRequestId;

+(NSDictionary*) getRequestHeadWithRequestId:(NSString*)requestId command:(NSString*)cmd;

+(NSString*) getVerificationJsonStringWithRequestId:(NSString*)requestId appId:(NSString*)appId userId:(NSString*)userId loginToken:(NSString*)token;

+(NSString*) getSubscribeJsonStringWithRequestId:(NSString*)requestId appId:(NSString*)appId userId:(NSString*)userId;

@end
