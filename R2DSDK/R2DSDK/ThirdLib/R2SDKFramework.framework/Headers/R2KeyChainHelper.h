//
//  R2KeyChainHelper.h
//  R2SDKFramework
//
//  Created by LUXING on 16/6/14.
//  Copyright © 2016年 r2games. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface R2KeyChainHelper : NSObject

+(NSMutableDictionary *)keychainQuery:(NSString *)key;

//save a data item identified with the specified key in the key chain (this data item remains even the app is unintalled)
+(void)save:(NSString *)key data:(id)data;


//get a data item identified with the specified key
+(id)load:(NSString *)key;


//delete a data item identified with the specified key
+(void)remove:(NSString *)key;


+(NSString*)getKeyForCustomizedDeviceID;
+(void)saveCustomizedDeviceID:(NSString *)did;
+(NSString*)getCustomizedDeviceID;


+(NSString *)makeFixedUniqueLoginID;
+(NSString *)remakeFixedUniqueLoginID;

@end
