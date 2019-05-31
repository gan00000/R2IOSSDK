#import <Foundation/Foundation.h>

@interface R2SDKAppleOrder : NSObject<NSCoding>

@property (atomic,copy)NSString *sdkCno;
@property (atomic,copy)NSString *base64EncodedReceiptData;
@property (atomic,copy)NSString *missed;

-(id)init;
-(id)initWithCno:(NSString*)cno receiptData:(NSString*)data tag:(NSString*)tg;
-(NSString*)desc;


+(NSString*)getUnverifiedPaymentsSavePath;
+(BOOL)add:(R2SDKAppleOrder*)order;
+(void)remove:(R2SDKAppleOrder*)order;
+(void)removeAllInvalidOrders;
+(void)process;
+(void)showAllOrders;

@end
