//
//  FacebookLoginResult.h
//  R2GMDemo
//
//  Created by luxing on 9/9/15.
//  Copyright (c) 2015 luxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface R2FacebookLoginResult : NSObject

@property NSString* fbUserId;
@property NSString* fbUsername;
@property NSString* fbImageUrl;

-(id)initWithDictionary:(NSDictionary*)data;

@end
