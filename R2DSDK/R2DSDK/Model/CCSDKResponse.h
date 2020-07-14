//
//  CCSDKResponse.h
//  R2DLIB
//
//  Created by ganyuanrong on 2019/8/31.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJBaseResponceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCSDKResponse : BJBaseResponceModel

//@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *beLinked;
@property (nonatomic, copy) NSString *gmbPlayerIp;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *accessToken;

@end

NS_ASSUME_NONNULL_END
