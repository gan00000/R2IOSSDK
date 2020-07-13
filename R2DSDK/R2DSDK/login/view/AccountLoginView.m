//
//  AccountLoginView.m
//  R2DSDK
//
//  Created by ganyuanrong on 2020/7/9.
//  Copyright © 2020 ganyuanrong. All rights reserved.
//

#import "AccountLoginView.h"
#import "SDKTextFiledView.h"
#import "CCSkyHourHeader.h"
#import "LoginTitleView.h"
#import "LoginButton.h"
#import "RegisterAccountView.h"

//会员登入view
@implementation AccountLoginView
{
    SDKTextFiledView *passwordSDKTextFiledView;
    SDKTextFiledView *accountSDKTextFiledView;
    UIButton *checkBoxBtn;
    UIButton *accountLoginBtn;
    UIButton *backBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initView
{
    self = [super init];
    if (self) {
        
        UIColor *color = [UIColor colorWithHexString:ContentViewBgColor];
        self.backgroundColor = color;//UIColor.lightGrayColor;// 底图透明，控件不透明
        self.layer.cornerRadius = 10; //设置圆角
        self.layer.masksToBounds = YES;
        
        //登入頁logo
        UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage gama_imageNamed:@"fl_sdk_logo"]];
        logoImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:logoImageView];
       [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.mas_equalTo(self.mas_top).mas_offset(12);
           make.centerX.mas_equalTo(self);
          make.width.mas_equalTo(self).mas_offset(-30);
           make.height.mas_equalTo(50);
       }];
          
        backBtn = [UIUtil initBtnWithNormalImage:@"sdk_btn_back.png" highlightedImage:nil tag:kBackBtnActTag selector:@selector(registerViewBtnAction:) target:self];
            [self addSubview:backBtn];
             [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.leading.mas_equalTo(self).mas_offset(20);
                 make.width.mas_equalTo(23 * 0.6 );
                 make.top.equalTo(self).mas_offset(20);
                 make.height.mas_equalTo(37 * 0.6 );
             }];
        
        //账号
        accountSDKTextFiledView = [[SDKTextFiledView alloc] initViewWithType:(SDKTextFiledView_Type_Account)];
        [self addSubview:accountSDKTextFiledView];
             
        [accountSDKTextFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.equalTo(logoImageView.mas_bottom).mas_offset(10);
            make.width.mas_equalTo(self).offset(-30);
            make.height.mas_equalTo(kInputTextFiledWidth);
         }];
        
        
        //账号
        passwordSDKTextFiledView = [[SDKTextFiledView alloc] initViewWithType:(SDKTextFiledView_Type_Password)];
       [self addSubview:passwordSDKTextFiledView];
            
       [passwordSDKTextFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
           
           make.top.equalTo(accountSDKTextFiledView.mas_bottom).mas_offset(10);
           make.leading.mas_equalTo(accountSDKTextFiledView.mas_leading);
           make.trailing.mas_equalTo(accountSDKTextFiledView.mas_trailing);
           make.height.mas_equalTo(accountSDKTextFiledView.mas_height);
        }];
        
   
        //記住密碼
        UILabel *rememberLable = [[UILabel alloc] init];
        rememberLable.text =  @"記住密碼";
        rememberLable.font = [UIFont systemFontOfSize:12];
        rememberLable.textAlignment = NSTextAlignmentLeft;
        rememberLable.backgroundColor = [UIColor clearColor];
        rememberLable.numberOfLines = 1;
        rememberLable.textColor = [UIColor blackColor];
        
        [self addSubview:rememberLable];
       [rememberLable mas_makeConstraints:^(MASConstraintMaker *make) {
              make.width.mas_equalTo(60);
              make.top.equalTo(passwordSDKTextFiledView.mas_bottom).mas_offset(10);
              make.trailing.mas_equalTo(self.mas_centerX).mas_offset(-40);
              make.height.mas_equalTo(40);
           }];
        
        
        checkBoxBtn = [UIUtil initBtnWithNormalImage:@"btn_checkbox_checked.png" highlightedImage:nil tag:kCheckBoxBtnTag selector:@selector(registerViewBtnAction:) target:self];
           
           [self addSubview:checkBoxBtn];
           [checkBoxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                      make.trailing.mas_equalTo(rememberLable.mas_leading).mas_offset(-4);
               make.centerY.mas_equalTo(rememberLable);
                      make.width.mas_equalTo(20);
                      make.height.mas_equalTo(20);
                   }];
        
        //找回密碼
//        UILabel *findPasswordLable = [[UILabel alloc] init];
//         findPasswordLable.text =  @"找回密碼";
//         findPasswordLable.font = [UIFont systemFontOfSize:12];
//         findPasswordLable.textAlignment = NSTextAlignmentLeft;
//         findPasswordLable.backgroundColor = [UIColor clearColor];
//         findPasswordLable.numberOfLines = 1;
//         findPasswordLable.textColor = [UIColor blackColor];
        
         UIButton *findPasswordBtn = [UIUtil initBtnWithTitle2:@"找回密碼" tag:kFindPwdActTag selector:@selector(registerViewBtnAction:) target:self];
        findPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [findPasswordBtn setTitleColor:[UIColor blackColor] forState:0];
        
        [self addSubview:findPasswordBtn];
        [findPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.mas_centerX).mas_offset(40);
            make.centerY.equalTo(rememberLable);
            make.trailing.mas_equalTo(self.mas_trailing).mas_offset(-30);
            make.height.mas_equalTo(40);
        }];
              
        
         //账号登入
       accountLoginBtn = [LoginButton initBtnWithType:(BUTTON_TYPE_ACCOUNT_LOGIN) tag:kAccountLoginActTag selector:@selector(registerViewBtnAction:)  target:self];
          [self addSubview:accountLoginBtn];
          
          [accountLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerX.equalTo(self);
              make.top.equalTo(rememberLable.mas_bottom).mas_offset(10);
              make.width.mas_equalTo(self).offset(-30);
              make.height.mas_equalTo(40);
          }];
        
        //修改密碼
        UIButton *changePasswordBtn = [UIUtil initBtnWithTitle2:@"修改密碼" tag:kChangePwdActTag selector:@selector(registerViewBtnAction:) target:self];
        [self addSubview:changePasswordBtn];
       [changePasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerX.mas_equalTo(self.mas_centerX);
           make.width.mas_equalTo(90);
           make.top.equalTo(accountLoginBtn.mas_bottom).mas_offset(10);
           make.height.mas_equalTo(40);
       }];
        
        //註冊帳號
       UIButton *registerBtn = [UIUtil initBtnWithTitle2:@"註冊帳號" tag:kRegisterAccountActTag selector:@selector(registerViewBtnAction:) target:self];
       [self addSubview:registerBtn];
      [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
          make.trailing.mas_equalTo(changePasswordBtn.mas_leading).mas_offset(-10);
          make.width.mas_equalTo(changePasswordBtn);
          make.centerY.equalTo(changePasswordBtn);
          make.height.mas_equalTo(changePasswordBtn);
      }];
        
        
        //綁定帳號
       UIButton *bindAccountBtn = [UIUtil initBtnWithTitle2:@"綁定帳號" tag:kBindAccountActTag selector:@selector(registerViewBtnAction:) target:self];
       [self addSubview:bindAccountBtn];
      [bindAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
          make.leading.mas_equalTo(changePasswordBtn.mas_trailing).mas_offset(10);
          make.width.mas_equalTo(changePasswordBtn);
          make.centerY.equalTo(changePasswordBtn);
          make.height.mas_equalTo(changePasswordBtn);
      }];
    }
    return self;
}


- (void)registerViewBtnAction:(UIButton *)sender
{
    switch (sender.tag) {
        case kCheckBoxBtnTag:
            SDK_LOG(@"kCheckBoxBtnTag");
            break;
            
        case kFindPwdActTag:
            SDK_LOG(@"kFindPwdActTag");
        break;
            
        case kBindAccountActTag:
            SDK_LOG(@"kBindAccountActTag");
            if (self.delegate) {
                [self.delegate goSelelctBindTypeView];
            }
        break;
            
        case kRegisterAccountActTag:
            SDK_LOG(@"kRegisterAccountActTag");
            if (self.delegate) {
                [self.delegate goRegisterAccountView];
            }
        break;
            
        case kChangePwdActTag:
            SDK_LOG(@"kChangePwdActTag");
            if (self.delegate) {
                [self.delegate goChangePasswordView];
            }
        break;
            
        case kBackBtnActTag:
            SDK_LOG(@"kBackBtnActTag");
            if (self.delegate) {
                [self.delegate goBackBtn:backBtn backCount:1];
            }
        break;
            
        case kAccountLoginActTag:
            SDK_LOG(@"kAccountLoginActTag");
        break;
            
            
        default:
            break;
    }
    
}
@end
