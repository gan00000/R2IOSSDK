//
//  R2FacebookInvitableFriend.h
//  R2FacebookFramework
//
//  Created by 左细平 on 16/7/14.
//  Copyright © 2016年 r2games. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface R2FacebookInvitableFriend : NSObject

@property NSString* inviteToken;
@property NSString* fbUsername;
@property NSString* fbImageUrl;

-(id)initWithDictionary:(NSDictionary*)data;

@end
