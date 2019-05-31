//
//  Created by LUXING on 2017/4/5.
//  Copyright © 2017年 r2games. All rights reserved.
//

#import <Foundation/Foundation.h>

#define R2_NOT_RESPONSE_CDOE -404

@interface R2SDKBasePayResponse : NSObject

@property(nonatomic) int code;
@property(nonatomic,copy) NSString *msg;
@property(nonatomic) NSDictionary *data;

-(id)init;
-(id)initWithResponseDictionary:(NSDictionary*)responseData;

@end
