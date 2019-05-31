//
//  R2MessagePush.h
//  R2FacebookDemo
//
//  Created by LUXING on 15/12/4.
//  Copyright © 2015年 LUXING. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "R2MessagePushUtil.h"

#define R2_PUSH_MESSAGE @"R2PushServices"

@interface R2MessagePush : NSObject<NSStreamDelegate>

@property BOOL isUserLogin;
@property NSString* appId;
@property NSString* r2Id;
@property NSString* token;

@property BOOL isServiceRunning;
@property NSMutableString *messages;
@property NSString* requestId;
@property(retain,atomic)NSInputStream *inputStream;
@property(retain,atomic)NSOutputStream *outputStream;

-(void)start;
-(void)end;

-(void)createNSStream;
-(void)closeNSStream;

-(void)connectPushServerWithGameId:(NSString*)gameId userId:(NSString*)userId;


-(void)disconnectPushServer;

-(void)auth;


-(void)subscribe;

-(void)processData;

-(void)processMessages;

-(void)processMessage:(NSString*)message;

+(R2MessagePush*)sharedInstance;

@end
