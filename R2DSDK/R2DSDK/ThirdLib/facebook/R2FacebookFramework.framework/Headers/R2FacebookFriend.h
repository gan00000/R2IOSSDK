//
//  R2FacebookFriend.h
//  R2FacebookFramework
//
//  Created by luxing on 9/17/15.
//  Copyright (c) 2015 r2games. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface R2FacebookFriend : NSObject

@property NSString* fbUserId;
@property NSString* fbUsername;
@property NSString* fbImageUrl;

-(id)initWithDictionary:(NSDictionary*)data;
@end
