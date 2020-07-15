//
//  LoginButton.m
//  R2DSDK
//
//  Created by ganyuanrong on 2020/7/8.
//  Copyright © 2020 ganyuanrong. All rights reserved.
//

#import "LoginButton.h"
#import "UIUtil.h"

@implementation LoginButton

+ (UIButton *)initBtnWithType:(BUTTON_TYPE)type
                          tag:(NSUInteger)tag
                     selector:(SEL)selector
                       target:(id)target
{
    
    NSString *normalImage = @"btn_hy.png";
    NSString *highlightedImage = @"btn_hy.png";
    
    switch (type) {
        case BUTTON_TYPE_ACCOUNT:
            normalImage = @"btn_hy.png";
            highlightedImage = @"btn_hy.png";
            break;
            
        case BUTTON_TYPE_FB:
            normalImage = @"btn_fb.png";
            highlightedImage = @"btn_fb.png";
            break;
            
        case BUTTON_TYPE_GEUST:
            normalImage = @"btn_yk.png";
            highlightedImage = @"btn_yk.png";
            break;
            
        case BUTTON_TYPE_APPLE:
            normalImage = @"btn_ios.png";
            highlightedImage = @"btn_ios.png";
            break;
        case BUTTON_TYPE_ACCOUNT_LOGIN:
            normalImage = @"fl_sdk_account_login_bg.png";
            highlightedImage = @"fl_sdk_account_login_bg.png";
            break;
            
        case BUTTON_TYPE_OK:
            normalImage = @"fl_sdk_ok.png";
            highlightedImage = @"fl_sdk_ok.png";
            break;
        case BUTTON_TYPE_BIND_FB:
            normalImage = @"sdk_btn_bdfb.png";
            highlightedImage = @"sdk_btn_bdfb.png";
            break;
            
        case BUTTON_TYPE_BIND_APPLE:
            normalImage = @"sdk_btn_bdios.png";
            highlightedImage = @"sdk_btn_bdios.png";
            break;
            
        case BUTTON_TYPE_BIND_GEUST:
            normalImage = @"sdk_btn_bdyk.png";
            highlightedImage = @"sdk_btn_bdyk.png";
            break;
            
        case BUTTON_TYPE_CHANGE_ACCOUNT:
            normalImage = @"btn_change_account.png";
            highlightedImage = @"btn_change_account.png";
            break;
        case BUTTON_TYPE_BIND_ACCOUNT:
            normalImage = @"btn_bind_account.png";
            highlightedImage = @"btn_bind_account.png";
            break;
            
        default:
            break;
    }
    
    UIButton *mButton = [UIUtil initBtnWithNormalImage:normalImage highlightedImage:highlightedImage tag:tag selector:selector target:target];
    
    //closeImageView.backgroundColor = [UIColor clearColor];
    [mButton.layer setCornerRadius:kR2BtnCornerRadius];
    mButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return mButton;
}


@end
