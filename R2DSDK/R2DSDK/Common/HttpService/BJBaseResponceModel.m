
#import "BJBaseResponceModel.h"

@implementation BJBaseResponceModel

-(BOOL) isSuccess
{
    
    if (self.code == 1000) {
        return YES;
    }
    return NO;
}
@end
