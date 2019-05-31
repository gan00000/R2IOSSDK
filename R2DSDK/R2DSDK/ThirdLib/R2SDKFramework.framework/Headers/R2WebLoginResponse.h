
#import "R2SDKBaseResponse.h"

@interface R2WebLoginResponse : R2SDKBaseResponse
@property(nonatomic,strong)NSString *token;

-(void)initWithData:(NSData*)responseData;
@end
