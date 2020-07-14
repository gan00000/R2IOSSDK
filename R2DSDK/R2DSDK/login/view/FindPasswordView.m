//
//  FindPasswordView.m
//  R2DSDK
//
//  Created by ganyuanrong on 2020/7/14.
//  Copyright © 2020 ganyuanrong. All rights reserved.
//

#import "FindPasswordView.h"
#import "CCSkyHourHeader.h"
#import "SDKTextFiledView.h"
#import "LoginTitleView.h"
#import "PhoneView.h"
#import "LoginButton.h"

@implementation FindPasswordView

{
    SDKTextFiledView *accountSDKTextFiledView;
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
        
         //title
          mLoginTitleView = [[LoginTitleView alloc] initViewWithTitle:@"找回密碼"];
          mLoginTitleView.delegate = self.delegate;//此处不起作用
          
          [self addSubview:mLoginTitleView];
         [mLoginTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(8);
             make.centerX.mas_equalTo(self);
            make.width.mas_equalTo(self).mas_offset(-12);
             make.height.mas_equalTo(40);
         }];
            
          
        
        //账号
        accountSDKTextFiledView = [[SDKTextFiledView alloc] initViewWithType:(SDKTextFiledView_Type_Account)];
        [self addSubview:accountSDKTextFiledView];
             
        [accountSDKTextFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.equalTo(mLoginTitleView.mas_bottom).mas_offset(10);
            make.width.mas_equalTo(self).offset(-30);
            make.height.mas_equalTo(kInputTextFiledWidth);
         }];
        
        
        //電話號碼
        PhoneView *mPhoneView = [[PhoneView alloc] initView];
           
           [self addSubview:mPhoneView];
           [mPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(accountSDKTextFiledView.mas_bottom).mas_offset(10);
                 make.leading.mas_equalTo(accountSDKTextFiledView.mas_leading);
                 make.trailing.mas_equalTo(accountSDKTextFiledView.mas_trailing);
                 make.height.mas_equalTo(accountSDKTextFiledView.mas_height);
           }];
        
        //驗證碼
         SDKTextFiledView *vfCodeFiledView = [[SDKTextFiledView alloc] initViewWithType:(SDKTextFiledView_Type_VfCode)];
          
          [self addSubview:vfCodeFiledView];
          [vfCodeFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.equalTo(mPhoneView.mas_bottom).mas_offset(10);
                make.leading.mas_equalTo(accountSDKTextFiledView.mas_leading);
                make.width.mas_equalTo(accountSDKTextFiledView.mas_width).multipliedBy(0.6);
                make.height.mas_equalTo(accountSDKTextFiledView.mas_height);
          }];
         //獲取驗證碼
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
        
         //確認
      UIButton *okBtn = [LoginButton initBtnWithType:(BUTTON_TYPE_OK) tag:kAccountLoginActTag selector:@selector(registerViewBtnAction:)  target:self];
      [self addSubview:okBtn];
      
      [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerX.equalTo(self);
          make.top.equalTo(vfCodeFiledView.mas_bottom).mas_offset(40);
          make.width.mas_equalTo(self).offset(-30);
          make.height.mas_equalTo(40);
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
