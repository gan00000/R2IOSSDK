//
//  LoginMainView.m
//  R2DSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "LoginMainView.h"
#import "R2DHeader.h"
#import "LoginTitleView.h"
#import "../LoginApi/LoginImp.h"


#define fbLoginActTag       2000
#define googleLoginActTag   2001
#define guestLoginActTag    2002

@implementation LoginMainView{
 
    UIView *bgView;
    UIView *fbBannerView;
    UIView *googleBannerView;
    UIView *guestBannerView;
    
  
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initView{

    self = [super init];

    UIColor *color = [UIColor colorWithHexString:ContentViewBgColor];
    self.backgroundColor = color;// 底图透明，控件不透明

    LoginTitleView *loginTitleView = [[LoginTitleView alloc] initView];
    
    [self addSubview:loginTitleView];
    
    [loginTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self);
        
        make.width.equalTo(@(kBgWidth));
        make.height.mas_equalTo(@(kBgHeight / 5));
    }];
    

    int leftOffset = -40;
    int topOffset = 3;
    
    bgView = [[UIView alloc] init];
    //    contentView.backgroundColor = [UIColor redColor];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(loginTitleView.mas_bottom);
        make.left.bottom.right.mas_equalTo(self);
        
    }];
    
    
    UIButton *fbLoginBtn = [UIUtil initBtnWithNormalImage:@"r2d_fb_signup.png" highlightedImage:nil tag:fbLoginActTag selector:@selector(loginBtnsAction:) target:self];
    fbLoginBtn.backgroundColor = [UIColor colorWithHexString:@"#4669af"];
    fbLoginBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [fbLoginBtn.layer setCornerRadius:kR2BtnCornerRadius];
    [bgView addSubview:fbLoginBtn];
    
    [fbLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.equalTo(bgView).mas_offset(20);
        make.width.mas_equalTo(bgView).offset(leftOffset);
        make.height.mas_equalTo(40);
    }];
    
    
    UIButton *googleLoginBtn = [UIUtil initBtnWithNormalImage:@"r2d_gg_signup.png" highlightedImage:nil tag:googleLoginActTag selector:@selector(loginBtnsAction:) target:self];
    googleLoginBtn.backgroundColor = [UIColor whiteColor];
    googleLoginBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [googleLoginBtn.layer setCornerRadius:kR2BtnCornerRadius];
    [bgView addSubview:googleLoginBtn];
    
    [googleLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.equalTo(fbLoginBtn.mas_bottom).mas_offset(15);
        make.width.mas_equalTo(bgView).offset(leftOffset);
        make.height.mas_equalTo(40);
        
    }];
    
    
    UIButton *guestLoginBtn = [UIUtil initBtnWithNormalImage:@"r2d_guest_login.png" highlightedImage:nil tag:guestLoginActTag selector:@selector(loginBtnsAction:) target:self];
    
    guestLoginBtn.backgroundColor = [UIColor colorWithHexString:@"#e9575f"];
    guestLoginBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [guestLoginBtn.layer setCornerRadius:kR2BtnCornerRadius];
    [bgView addSubview:guestLoginBtn];
    
    [guestLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.equalTo(googleLoginBtn.mas_bottom).mas_offset(15);
        make.width.mas_equalTo(bgView).offset(leftOffset);
        make.height.mas_equalTo(40);
    }];
    
    return self;
}

- (void)loginBtnsAction:(UIButton *) button
{
    SDK_LOG(@"loginBtnsAction");
    
    switch (button.tag) {
        case fbLoginActTag:
        {
            if (self.delegate) {
                [self.delegate clickFbLogin];
            }
        }
            break;
        case googleLoginActTag:
        {
            if (self.delegate) {
                [self.delegate clickGoogleLogin];
            }
        }
            break;
            
        case guestLoginActTag:
        {
            if (self.delegate) {
                [self.delegate clickGuestLogin];
            }
//            [LoginImp loginGuestAccount:nil];
        }
            break;
            
        default:
            break;
    }
}

@end
