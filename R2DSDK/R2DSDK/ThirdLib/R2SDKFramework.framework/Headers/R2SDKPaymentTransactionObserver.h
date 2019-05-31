//
//
//  Created by LUXING on 2017/4/7.
//  Copyright © 2017年 shycie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import <UIKit/UIKit.h>


static SKPaymentQueue *mqueue;
static SKPayment *mpayment;
static SKProduct *mproduct;
static NSString *cnoForThisPurchase;

static BOOL isPromotion = NO;

typedef void (^R2PromotionPayCompletionHandler)(BOOL isSuccess,NSString* msg);

#define R2PROMOTIONNOTIFICATION @"R2PromotionPay"
@interface R2SDKPaymentTransactionObserver : NSObject<SKPaymentTransactionObserver>
-(id)init;

+(instancetype)sharedInstance;

-(BOOL)paymentQueue:(SKPaymentQueue *)queue shouldAddStorePayment:(SKPayment *)payment forProduct:(SKProduct *)product;


/**
 是否是从苹果商店促销
 
 @return YES or NO
 */
-(BOOL)isPromotionFromAppStore;


/**
 通过app store 商店购买促销产品时，必须调用此方法进行支付处理
 
 @param gameViewController 当前控制器
 @param yesOrNo 是否显示加载框
 @param productId 支付产品标识符
 @param productPrice 支付产品的价格
 @param uid 用户的r2uid
 @param serverId 服务器标识
 @param roleid 角色标识
 @param extraData 附加数据
 @param handler 回调，支付结果以及消息
 */
-(void)promotionPayWithViewController:(UIViewController *)viewController usingLoadingView:(BOOL)yesOrNo withR2uid:(NSString*)r2uid  roleId:(NSString*)roleId serverId:(NSString*)serverId extraData:(NSString*)extraData completionHandler:(R2PromotionPayCompletionHandler)handler;

@end
