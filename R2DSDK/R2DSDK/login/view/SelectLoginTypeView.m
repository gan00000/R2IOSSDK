//
//  LoginMainView.m
//  CCSkyHourSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "SelectLoginTypeView.h"
#import "CCSkyHourHeader.h"
#import "LoginTitleView.h"
#import "../LoginApi/LoginImp.h"
#import "LoginButton.h"


#define fbLoginActTag       2000
#define googleLoginActTag   2001
#define guestLoginActTag    2002
#define accountLoginActTag    2003
#define appleLoginActTag    2004

@implementation SelectLoginTypeView{
 
    UIView *bgView;
    
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
    self.backgroundColor = color;//UIColor.lightGrayColor;// 底图透明，控件不透明
    self.layer.cornerRadius = 10; //设置圆角
    self.layer.masksToBounds = YES;
    
    
    UITextView *titleView = [[UITextView alloc]init];
    titleView.backgroundColor = UIColor.clearColor;
    titleView.textColor = [UIColor colorWithHexString:@"ff3e37"];
    titleView.font = [UIFont fontWithName:LABEL_FONT_NAME_BOLD size:36];
    titleView.textAlignment = NSTextAlignmentCenter;
       titleView.text = @"選擇登入方式";
       [self addSubview:titleView];
       [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self).mas_offset(16);
//           make.bottom.mas_equalTo(self);
           make.left.mas_equalTo(self);
           make.right.mas_equalTo(self);
           
//            make.width.equalTo(@(kBgWidth));
            make.height.mas_equalTo(@(kBgHeight / 5));
       }];

    int leftOffset = -30;
    int topOffset = 16;
    
    bgView = [[UIView alloc] init];
    //    contentView.backgroundColor = [UIColor redColor];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(titleView.mas_bottom);
        make.left.bottom.right.mas_equalTo(self);
        
    }];
    
    //账号
    UIButton *accountLoginBtn = [LoginButton initBtnWithType:(BUTTON_TYPE_ACCOUNT) tag:accountLoginActTag selector:@selector(loginBtnsAction:)  target:self];
       [bgView addSubview:accountLoginBtn];
       
       [accountLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerX.equalTo(bgView);
           make.top.equalTo(bgView).mas_offset(20);
           make.width.mas_equalTo(bgView).offset(leftOffset);
           make.height.mas_equalTo(40);
       }];
    
   
    //游客
    UIButton *guestLoginBtn = [LoginButton initBtnWithType:(BUTTON_TYPE_GEUST) tag:LoginTypeGuest selector:@selector(loginBtnsAction:)  target:self];
    
    [bgView addSubview:guestLoginBtn];
    
    [guestLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.height.equalTo(accountLoginBtn);
        make.top.equalTo(accountLoginBtn.mas_bottom).mas_offset(topOffset);
    }];
    
    
    //fb
    UIButton *fbLoginBtn = [LoginButton initBtnWithType:(BUTTON_TYPE_FB) tag:fbLoginActTag selector:@selector(loginBtnsAction:)  target:self];
    [bgView addSubview:fbLoginBtn];
    
    [fbLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.height.equalTo(accountLoginBtn);
        make.top.equalTo(guestLoginBtn.mas_bottom).mas_offset(topOffset);
    }];
    
    //apple
    UIButton *appleLoginBtn = [LoginButton initBtnWithType:(BUTTON_TYPE_APPLE) tag:appleLoginActTag selector:@selector(loginBtnsAction:)  target:self];
    [bgView addSubview:appleLoginBtn];
    
    [appleLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fbLoginBtn.mas_bottom).mas_offset(topOffset);
        make.leading.trailing.height.equalTo(accountLoginBtn);
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
            
         case accountLoginActTag:
        {
            if (self.delegate) {
                [self.delegate goAccountLoginView];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
