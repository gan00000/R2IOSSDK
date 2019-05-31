//
//  R2GlobalData.h
//  R2SDKFramework
//
//  Created by LUXING on 16/6/24.
//  Copyright © 2016年 r2games. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface R2GlobalData : NSObject

@property(copy) NSString *r2GameId;
@property(copy) NSString *releasePlatform;
@property(copy) NSString *currentLoginR2Uid;


-(id)init;

-(void)setValueToR2GameId:(NSString*)gameId;

-(void)setValueToReleasePlatform:(NSString*)platform;

-(void)setValueToCurrentLoginR2Uid:(NSString*)r2uid;

+(R2GlobalData*)sharedInstance;

@end
