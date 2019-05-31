//
//  R2UnwrapResponse.h
//  R2SDKFramework
//
//  Created by 左细平 on 2016/11/14.
//  Copyright © 2016年 r2games. All rights reserved.
//


#import "R2SDKBaseResponse.h"

@interface R2UnwrapResponse : R2SDKBaseResponse

@property NSString* timestamp;
@property NSString* sign;

-(void)initWithData:(NSData*)serverData;

@end
