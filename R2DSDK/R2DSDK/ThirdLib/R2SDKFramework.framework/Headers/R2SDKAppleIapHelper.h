#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "R2SDKAppleOrder.h"
#import "R2SDKOrderIdRequest.h"
#import "R2SDKPaymentVerifyRequest.h"


typedef void (^R2SDKRequestProductsCompletionHandler)(BOOL isSuccess,NSArray* R2AppleProducts);
typedef void (^R2SDKPayCompletionHandler)(BOOL isSuccess,NSString* msg);

static BOOL IS_PURCHASE_GOING_ON = NO;

@interface R2SDKAppleIapHelper : NSObject<SKProductsRequestDelegate,SKPaymentTransactionObserver>

@property(atomic,weak) UIViewController* GVC;
@property(atomic) BOOL usingLoadingView;
@property(atomic) int currentAction;
@property(atomic) NSSet* iapProductIds;
@property(atomic) R2SDKAppleOrder *appleOrder;
@property(atomic) R2SDKOrderIdRequest* orderIdRequest;
@property(atomic) R2SDKPaymentVerifyRequest* paymentVerifyRequest;
@property(atomic) BOOL isPurchasingCalled;



-(id)init;

-(id)initWithViewController:(UIViewController*)gameViewController
           usingLoadingView:(BOOL)yesOrNo
                  productId:(NSString*)productId
               productPrice:(NSString*)productPrice
                   r2UserId:(NSString*)uid
                   serverId:(NSString*)serverId
               playerRoleId:(NSString*)roleid
                  extraData:(NSString*)extraData;
-(void)payWithHandler:(R2SDKPayCompletionHandler)handler;





+(BOOL)canStartPurchase;
+(void)initIap;

+(void)getLocalDetailsOfProductWithIDs:(NSArray*)productIDs onCompletionHandler:(R2SDKRequestProductsCompletionHandler)handler;
+(void)payFromViewController:(UIViewController*)gameViewController
            usingLoadingView:(BOOL)yesOrNo
                   productId:(NSString*)productId
                productPrice:(NSString*)productPrice
                    r2UserId:(NSString*)uid
                    serverId:(NSString*)serverId
                playerRoleId:(NSString*)roleid
                   extraData:(NSString*)extraData
         onCompletionHandler:(R2SDKPayCompletionHandler)handler;

@end
