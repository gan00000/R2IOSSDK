//
//  R2AppleProduct.h
//  R2SDKFramework
//
//  Created by LUXING on 16/7/1.
//  Copyright © 2016年 r2games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@interface R2SDKAppleProduct : NSObject

@property(nonatomic) NSString *productIdentifier;
@property(nonatomic) NSString *localizedTitle;
@property(nonatomic) NSString *localizedDescription;

@property(nonatomic) NSDecimalNumber *price;
@property(nonatomic) double doublePrice;
@property(nonatomic) NSString *stringPrice;

@property(nonatomic) NSLocale *priceLocale;
@property(nonatomic) NSString *priceCurrencyCode;

-(id)init;
-(id)initWithSKProduct:(SKProduct*)skProduct;
-(NSString*)description;

@end
