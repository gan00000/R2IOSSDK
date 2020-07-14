
#import "YYModel.h"


typedef NS_ENUM(NSInteger, BJResponseCode) {
    BJResponseCodeTokenExpired = -1,
    BJResponseCodeAccountKickOut = -2,
    BJResponseCodeError1 = -100,
    BJResponseCodeOK = 0
};


/**
 *  数据返回解析基类
 */
@interface BJBaseResponceModel : NSObject

/**
 *	@brief	数据状态号
 */
@property (nonatomic, assign) NSInteger code;

/**
 *	@brief	提示信息
 */
@property (nonatomic, copy) NSString *message;

-(BOOL) isSuccess;
@end

