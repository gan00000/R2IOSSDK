//
//  R2DHeader.h
//  R2DSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "UIImage+GamaBundleImage.h"
#import "Masonry.h"
#import "UIImage+GamaBundleImage.h"
#import "UIColor+HexStringToColorTW.h"
#import "UIUtil.h"
#import "R2SDKDATA.h"
#import "ConfigCoreUtil.h"
#import "R2SDKPlat.h"


#import "GamaFunction.h"


#ifndef R2DHeader_h
#define R2DHeader_h

// cornerRadius
#define kR2BtnCornerRadius                 8.0f
#define kBgAlpha                         0.9f

#define kBgWidth                        350.0
#define kBgHeight                       240.0

#define LoginTypeFacebook                 2
#define LoginTypeGoogle                   8
#define LoginTypeGuest                    1

#define ContentViewBgColor                    @"#bebebf"

#define SDK_DEFAULT_BUNDLE_NAME  @"R2DSDKResources"


#define SDK_DATA                           [R2SDKDATA sharedSdkData]

#define LABEL_FONT_NAME_BOLD                 @"Helvetica-Bold"
#define LABEL_FONT_NAME_Helvetica           @"Helvetica"

#define GetImage(imageName)     [UIImage gama_imageNamed:imageName]
#define SDK_LOG(format, ...) (NSLog)((format), ##__VA_ARGS__)
#define GET_SDK_LOCALIZED(key) [[ConfigCoreUtil reader] getLocalizedStringForKey:key]

#define hillTopViewController    [UIUtil getSDKController]

#define Guest_Login_Tipe_OK  @"Guest_Login_Tipe_OK" //游客登录成功通知
#define SDK_AUTO_LOGIN_FAIL @"SDK_AUTO_LOGIN_FAIL"  //自动登录失败通知


typedef void (^ViewClickHandler)(NSString* msg, NSInteger m);

#endif /* R2DHeader_h */

