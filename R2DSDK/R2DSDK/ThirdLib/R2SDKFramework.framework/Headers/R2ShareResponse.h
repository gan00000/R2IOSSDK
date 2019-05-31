
#import "R2SDKBaseResponse.h"

@interface R2ShareResponse : R2SDKBaseResponse

@property(nonatomic,strong) NSString* shareLink;

-(void)initWithData:(NSData *)serverData;
@end
