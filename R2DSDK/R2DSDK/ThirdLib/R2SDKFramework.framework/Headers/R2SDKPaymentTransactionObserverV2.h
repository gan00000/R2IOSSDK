//
//  R2SDKPaymentTransactionObserverV2.h
//  R2SDKFramework
//
//  Created by LUXING on 2018/12/10.
//  Copyright © 2018 r2games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import <UIKit/UIKit.h>

@interface R2SDKPaymentTransactionObserverV2 : NSObject<SKPaymentTransactionObserver>

-(id)init;

+(R2SDKPaymentTransactionObserverV2*)sharedInstance;

@end
