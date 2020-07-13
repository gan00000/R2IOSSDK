//
//  LoginButton.h
//  R2DSDK
//
//  Created by ganyuanrong on 2020/7/8.
//  Copyright © 2020 ganyuanrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "CCSkyHourHeader.h"
#import "SDKBaseView.h"

typedef NS_OPTIONS(NSUInteger, BUTTON_TYPE)
{
    BUTTON_TYPE_FB,
    BUTTON_TYPE_APPLE,
    BUTTON_TYPE_GEUST,
    BUTTON_TYPE_ACCOUNT,
    BUTTON_TYPE_ACCOUNT_LOGIN,
    BUTTON_TYPE_OK,//确认OK
    BUTTON_TYPE_BIND_FB,
    BUTTON_TYPE_BIND_GEUST,
    BUTTON_TYPE_BIND_APPLE,
    BUTTON_TYPE_CHANGE_ACCOUNT,
};

NS_ASSUME_NONNULL_BEGIN

@interface LoginButton : NSObject

+ (UIButton *)initBtnWithType:(BUTTON_TYPE)type tag:(NSUInteger)tag selector:(SEL)selector target:(id)target;

@end

NS_ASSUME_NONNULL_END
