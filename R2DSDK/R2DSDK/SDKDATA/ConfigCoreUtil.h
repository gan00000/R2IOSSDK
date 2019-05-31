//
//  ConfigCoreUtil.h
//  R2DSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConfigCoreUtil : NSObject

+ (ConfigCoreUtil *)reader;

-(NSString *)getLocalizedStringForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
