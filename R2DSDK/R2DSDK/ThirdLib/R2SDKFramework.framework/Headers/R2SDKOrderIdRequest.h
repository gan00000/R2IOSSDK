//
//  R2CNOrderIdRequest.h
//  R2CNSDKFramework
//
//  Created by LUXING on 2017/4/5.
//  Copyright © 2017年 r2games. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface R2SDKOrderIdRequest : NSObject<NSCoding>

@property (atomic,copy)NSString *productid;//itunes connect管理后台定义的产品id
@property (atomic,copy)NSString *price;//金额
@property (atomic,copy)NSString *uid;//玩家R2 uid
@property (atomic,copy)NSString *roleid;//玩家游戏角色id
@property (atomic,copy)NSString *serverid;//玩家当前所处服务器标示ID
@property (atomic,copy)NSString *extradata;//游戏研发自定义数据,服务器端将会进行透传
@property (atomic,copy)NSString *r2cno;//r2的订单号



-(id)init;
-(id)initWithProductId:(NSString*)iapProductId
                 price:(NSString*)iapProductPrice
                   uid:(NSString*)r2Uid
                roleid:(NSString*)playerRoleId
              serverid:(NSString*)currentGameServerId
             extradata:(NSString*)selfDefinedData;

-(NSString*)doSyncRequest;
-(NSString*)desc;

+(NSString*)getUnfinishedOrderSavePath;
+(BOOL)add:(R2SDKOrderIdRequest*)order;
+(void)removeByProductId:(NSString*)pid;
+(R2SDKOrderIdRequest*)getUnfinishedOrderByProductId:(NSString*)pid;
+(BOOL)areThereUnfinishedOrdersSavedLocally;
+(void)showAllOrders;

@end
