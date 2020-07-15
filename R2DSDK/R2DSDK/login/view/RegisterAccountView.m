//
//  RegisterAccountView.m
//  R2DSDK
//
//  Created by ganyuanrong on 2020/7/12.
//  Copyright © 2020 ganyuanrong. All rights reserved.
//

#import "RegisterAccountView.h"
#import "CCSkyHourHeader.h"
#import "LoginTitleView.h"
#import "SDKTextFiledView.h"
#import "PhoneView.h"
#import "LoginButton.h"

@implementation RegisterAccountView
{
    SDKTextFiledView *accountSDKTextFiledView;
    SDKTextFiledView *passwordSDKTextFiledView;
    SDKTextFiledView *passwordAgainSDKTextFiledView;
    LoginTitleView   *mLoginTitleView;
}

- (instancetype)initView
{
    self = [super init];
    if (self) {
        
        UIColor *color = [UIColor colorWithHexString:ContentViewBgColor];
        self.backgroundColor = color;// 底图透明，控件不透明
        self.layer.cornerRadius = 10; //设置圆角
//        self.layer.backgroundColor = [UIColor blackColor].CGColor;
//        self.layer.borderWidth = 2;
        self.layer.masksToBounds = YES; //不设置这里会不生成圆角，原因查找中
        
        int rowMargin = 6;
        
        //title
        mLoginTitleView = [[LoginTitleView alloc] initViewWithTitle:@"註冊會員"];
        mLoginTitleView.delegate = self.delegate;
        
        [self addSubview:mLoginTitleView];
       [mLoginTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.mas_equalTo(self.mas_top).mas_offset(10);
           make.centerX.mas_equalTo(self);
          make.width.mas_equalTo(self).mas_offset(-12);
           make.height.mas_equalTo(40);
       }];
          
        
        //账号
        accountSDKTextFiledView = [[SDKTextFiledView alloc] initViewWithType:(SDKTextFiledView_Type_Account)];
        [self addSubview:accountSDKTextFiledView];
             
        [accountSDKTextFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.equalTo(mLoginTitleView.mas_bottom).mas_offset(rowMargin);
            make.width.mas_equalTo(self).offset(-30);
            make.height.mas_equalTo(kInputTextFiledWidth - 10);
         }];
        
        
        //密碼
        passwordSDKTextFiledView = [[SDKTextFiledView alloc] initViewWithType:(SDKTextFiledView_Type_Password)];
       [self addSubview:passwordSDKTextFiledView];
            
       [passwordSDKTextFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
           
           make.top.equalTo(accountSDKTextFiledView.mas_bottom).mas_offset(rowMargin);
           make.leading.mas_equalTo(accountSDKTextFiledView.mas_leading);
           make.trailing.mas_equalTo(accountSDKTextFiledView.mas_trailing);
           make.height.mas_equalTo(accountSDKTextFiledView.mas_height);
        }];
        
        
        //再次輸入密碼
         passwordAgainSDKTextFiledView = [[SDKTextFiledView alloc] initViewWithType:(SDKTextFiledView_Type_Password)];
        [self addSubview:passwordAgainSDKTextFiledView];
             
        [passwordAgainSDKTextFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(passwordSDKTextFiledView.mas_bottom).mas_offset(rowMargin);
            make.leading.mas_equalTo(accountSDKTextFiledView.mas_leading);
            make.trailing.mas_equalTo(accountSDKTextFiledView.mas_trailing);
            make.height.mas_equalTo(accountSDKTextFiledView.mas_height);
         }];

        
        PhoneView *mPhoneView = [[PhoneView alloc] initView];
           
           [self addSubview:mPhoneView];
           [mPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(passwordAgainSDKTextFiledView.mas_bottom).mas_offset(rowMargin);
                 make.leading.mas_equalTo(accountSDKTextFiledView.mas_leading);
                 make.trailing.mas_equalTo(accountSDKTextFiledView.mas_trailing);
                 make.height.mas_equalTo(accountSDKTextFiledView.mas_height);
           }];
          
         SDKTextFiledView *vfCodeFiledView = [[SDKTextFiledView alloc] initViewWithType:(SDKTextFiledView_Type_VfCode)];
          
          [self addSubview:vfCodeFiledView];
          [vfCodeFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.equalTo(mPhoneView.mas_bottom).mas_offset(rowMargin);
                make.leading.mas_equalTo(accountSDKTextFiledView.mas_leading);
                make.width.mas_equalTo(accountSDKTextFiledView.mas_width).multipliedBy(0.6);
                make.height.mas_equalTo(accountSDKTextFiledView.mas_height);
          }];
         
        UIButton *getVfCodeBtn = [UIUtil initBtnWithTitle2:@"獲取驗證碼" tag:kGetVfCodeActTag selector:@selector(registerViewBtnAction:) target:self];
        
        getVfCodeBtn.layer.borderColor = [UIColor grayColor].CGColor;
        getVfCodeBtn.layer.borderWidth = 1;
        getVfCodeBtn.layer.cornerRadius = 10;
        getVfCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
           [getVfCodeBtn setTitleColor:[UIColor blackColor] forState:0];
        [self addSubview:getVfCodeBtn];
        [getVfCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(vfCodeFiledView);
            make.leading.mas_equalTo(vfCodeFiledView.mas_trailing).offset(6);
            make.trailing.mas_equalTo(accountSDKTextFiledView.mas_trailing);
             
        }];
        [getVfCodeBtn setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
         //账号登入
      UIButton *registorAccountBtn = [LoginButton initBtnWithType:(BUTTON_TYPE_ACCOUNT_LOGIN) tag:kAccountLoginActTag selector:@selector(registerViewBtnAction:)  target:self];
      [self addSubview:registorAccountBtn];
      
      [registorAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerX.equalTo(self);
          make.top.equalTo(vfCodeFiledView.mas_bottom).mas_offset(10);
          make.width.mas_equalTo(self).offset(-30);
          make.height.mas_equalTo(40);
      }];
        
        UILabel *loginTipsLable = [[UILabel alloc] init];
       loginTipsLable.text = @"同一手機當日不得收取驗證碼超過五次";
       loginTipsLable.font = [UIFont systemFontOfSize:10];
       loginTipsLable.textAlignment = NSTextAlignmentCenter;
       loginTipsLable.backgroundColor = [UIColor clearColor];
       loginTipsLable.numberOfLines = 1;
       loginTipsLable.textColor = [UIColor colorWithHexString:@"#FF3E37"];
       
        [self addSubview:loginTipsLable];
        [loginTipsLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(registorAccountBtn.mas_bottom).mas_offset(4);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(self).mas_offset(-10);
            
        }];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    mLoginTitleView.delegate = self.delegate;
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
        break;
            
        case kRegisterAccountActTag:
            SDK_LOG(@"kRegisterAccountActTag");
        break;
            
        case kChangePwdActTag:
            SDK_LOG(@"kChangePwdActTag");
        break;
            
        case kBackBtnActTag:
            SDK_LOG(@"kBackBtnActTag");
        break;
            
        case kAccountLoginActTag:
            SDK_LOG(@"kAccountLoginActTag");
        break;
            
            
        default:
            break;
    }
}
@end
