//
//
//  Created by LUXING on 2017/4/5.
//  Copyright © 2017年 r2games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "R2SDKBasePayResponse.h"

@interface R2SDKBasePayRequest : NSObject

@property(nonatomic,copy)NSString *httpUrl;
@property(nonatomic)NSMutableDictionary *postData;


-(id)init;
-(id)initWithRequestUrl:(NSString*)requestUrl;
-(id)initWithRequestUrl:(NSString*)requestUrl data:(NSDictionary*)requestData;
-(void)addPostData:(id)object forKey:(NSString*)key;

-(R2SDKBasePayResponse*)exeSync;


@end
