//
//  R2JSInterface.h
//  JSSDKDemo
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 Maycici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol sdkExports <JSExport>
-(void)login;
JSExportAs(pay,-(void)pay:(NSString*)productId rtuid:(NSString*)rtuid serverId:(NSString*)serverId roleId:(NSString*)roleId extraData:(NSString*)extraData );


@end


@interface R2JSInterface : NSObject

-(instancetype)init;

+(id)sharedInstance;

@end
