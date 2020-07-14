//
//  ConfigCoreUtil.h
//  CCSkyHourSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConfigCoreUtil : NSObject

+ (ConfigCoreUtil *)share;

-(NSString *)getLocalizedStringForKey:(NSString *)key;

-(void)saveAccountModels:(NSArray *) mAccountModelArray;

-(NSArray *)getAccountModels;

@end

NS_ASSUME_NONNULL_END
