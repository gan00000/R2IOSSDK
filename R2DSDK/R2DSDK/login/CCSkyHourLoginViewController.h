//
//  CCSkyHourLoginViewController.h
//  CCSkyHourSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "CCSkyHourHeader.h"
#import "LoginViewDelegate.h"


typedef NS_OPTIONS(NSUInteger, SDKPage)
{
    SDKPage_Login,
    SDKPage_LoginType,
    SDKPage_UnBind,
};

NS_ASSUME_NONNULL_BEGIN

@interface CCSkyHourLoginViewController : UIViewController <LoginViewDelegate>

-(instancetype)initWithPageType:(SDKPage) pageType;

//-(void)showLoginBind;

@end

NS_ASSUME_NONNULL_END
