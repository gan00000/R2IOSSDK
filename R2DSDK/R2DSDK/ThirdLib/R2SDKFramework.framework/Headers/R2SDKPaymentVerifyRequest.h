//
//  R2CNPaymentVerifyRequest.h
//  R2CNSDKFramework
//
//  Created by LUXING on 2017/4/5.
//  Copyright © 2017年 r2games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "R2SDKAppleOrder.h"

@interface R2SDKPaymentVerifyRequest : NSObject

@property(atomic,copy)NSString *cno;
@property(atomic,copy)NSString *base64EncodedReceiptData;
@property(atomic,copy)NSString *missed;

-(id)initWithCno:(NSString*)sdkCno receiptDataInBase64EncodedFormat:(NSString*)receipt;
-(id)initWithAppleOrder:(R2SDKAppleOrder*)order;

-(int)doSyncRequest;
-(void)doAsyncRequest;

@end
