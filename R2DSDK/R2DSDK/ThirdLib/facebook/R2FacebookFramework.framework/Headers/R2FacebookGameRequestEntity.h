//
//  R2FacebookGameRequestEntity.h
//  R2GMDemo
//
//  Created by luxing on 9/11/15.
//  Copyright (c) 2015 luxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface R2FacebookGameRequestEntity : NSObject


@property NSString *uniqueRequestId;
@property NSString *requestId;

@property NSString *message;

@property NSString *senderFbName;
@property NSString *senderFbId;

@property NSString *receiverFbName;
@property NSString *receiverFbId;

@property NSString *extraData;
@property NSString *createTime;

-(id)initWithGameRequestData:(NSDictionary*)data;

-(NSString*)toString;


@end
