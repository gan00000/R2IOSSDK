//
//  SDKTextFiledView.h
//  R2DSDK
//
//  Created by ganyuanrong on 2020/7/9.
//  Copyright © 2020 ganyuanrong. All rights reserved.
//

#import "SDKBaseView.h"

typedef NS_OPTIONS(NSUInteger, SDKTextFiledView_Type)
{
    SDKTextFiledView_Type_Account,
    SDKTextFiledView_Type_Password,
    SDKTextFiledView_Type_Password_New,
    SDKTextFiledView_Type_Password_Old,
    SDKTextFiledView_Type_VfCode,
};


NS_ASSUME_NONNULL_BEGIN

@interface SDKTextFiledView : SDKBaseView

- (instancetype)initViewWithType:(SDKTextFiledView_Type) type;
@end

NS_ASSUME_NONNULL_END
