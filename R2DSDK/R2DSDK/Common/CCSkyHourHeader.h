//
//  CCSkyHourHeader.h
//  CCSkyHourSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "UIImage+GamaBundleImage.h"
#import "Masonry.h"
#import "UIImage+GamaBundleImage.h"
#import "UIColor+HexStringToColorTW.h"
#import "UIUtil.h"
#import "CCSkyHourSDKDATA.h"
#import "ConfigCoreUtil.h"
#import "CCSkyHourSDKPlat.h"
#import "CCSDKResponse.h"


#import "CCSkyHourFunction.h"


#ifndef CCSkyHourHeader_h
#define CCSkyHourHeader_h

// cornerRadius
#define kR2BtnCornerRadius                 8.0f
#define kBgAlpha                         0.9f

#define kBgWidth                        350.0
#define kBgHeight                       350.0

#define kInputTextFiledWidth                       48.0

#define LoginTypeFacebook                 2
#define LoginTypeGoogle                   8
#define LoginTypeGuest                    1

#define ContentViewBgColor                    @"#f4f4f5"

#define SDK_DEFAULT_BUNDLE_NAME  @"CCSkyHourSDKResources"


#define SDK_DATA                           [CCSkyHourSDKDATA sharedSdkData]

#define LABEL_FONT_NAME_BOLD                 @"Helvetica-Bold"
#define LABEL_FONT_NAME_Helvetica           @"Helvetica"

#define GetImage(imageName)     [UIImage gama_imageNamed:imageName]
#define SDK_LOG(format, ...) (NSLog)((format), ##__VA_ARGS__)
#define GET_SDK_LOCALIZED(key) [[ConfigCoreUtil reader] getLocalizedStringForKey:key]

#define hillTopViewController    [UIUtil getSDKController]

#define Guest_Login_Tipe_OK  @"Guest_Login_Tipe_OK" //游客登录成功通知
#define SDK_AUTO_LOGIN_FAIL @"SDK_AUTO_LOGIN_FAIL"  //自动登录失败通知

typedef NS_OPTIONS(NSUInteger, CURRENT_PAGE_TYPE)
{
    CURRENT_PAGE_TYPE_REG_ACCOUNT,
    CURRENT_PAGE_TYPE_LOGIN_ACCOUNT,
    CURRENT_PAGE_TYPE_BIND,
};

//页面按钮button点击tag
#define kCheckBoxBtnTag     20
#define kAccountLoginActTag     21
#define kChangePwdActTag     22
#define kFindPwdActTag     23
#define kRegisterAccountActTag     24
#define kBindAccountActTag     25
#define kBackBtnActTag     26
#define kGetVfCodeActTag    27
#define kChangePwdActTag    28

typedef void (^ViewClickHandler)(NSString* msg, NSInteger m);

#endif /* CCSkyHourHeader_h */

