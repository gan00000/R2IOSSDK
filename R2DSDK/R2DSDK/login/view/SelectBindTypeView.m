//
//  SelectBindTypeView.m
//  R2DSDK
//
//  Created by ganyuanrong on 2020/7/13.
//  Copyright © 2020 ganyuanrong. All rights reserved.
//

#import "SelectBindTypeView.h"
#import "CCSkyHourHeader.h"
#import "LoginTitleView.h"
#import "LoginButton.h"

@implementation SelectBindTypeView{
     LoginTitleView *mLoginTitleView;
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
        
        //登入頁logo
        mLoginTitleView = [[LoginTitleView alloc] initViewWithTitle:@"註冊會員"];
        mLoginTitleView.delegate = self.delegate;//此处不起作用
        
        [self addSubview:mLoginTitleView];
       [mLoginTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.mas_equalTo(self.mas_top).mas_offset(8);
           make.centerX.mas_equalTo(self);
          make.width.mas_equalTo(self).mas_offset(-12);
           make.height.mas_equalTo(40);
       }];
          
        
        UIButton *guestBindBtn = [LoginButton initBtnWithType:(BUTTON_TYPE_BIND_GEUST) tag:kChangePwdActTag selector:@selector(registerViewBtnAction:)  target:self];
           [self addSubview:guestBindBtn];
           
           [guestBindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
               make.centerX.equalTo(self);
               make.top.equalTo(mLoginTitleView.mas_bottom).mas_offset(30);
               make.width.mas_equalTo(self).offset(-30);
               make.height.mas_equalTo(40);
           }];
             
        UIButton *appleBindBtn = [LoginButton initBtnWithType:(BUTTON_TYPE_BIND_APPLE) tag:kChangePwdActTag selector:@selector(registerViewBtnAction:)  target:self];
                  [self addSubview:appleBindBtn];
                  
                  [appleBindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                      make.centerX.equalTo(self);
                      make.top.equalTo(guestBindBtn.mas_bottom).mas_offset(30);
                      make.width.mas_equalTo(self).offset(-30);
                      make.height.mas_equalTo(40);
                  }];
        
        
        UIButton *fbBindBtn = [LoginButton initBtnWithType:(BUTTON_TYPE_BIND_FB) tag:kChangePwdActTag selector:@selector(registerViewBtnAction:)  target:self];
                  [self addSubview:fbBindBtn];
                  
                  [fbBindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                      make.centerX.equalTo(self);
                      make.top.equalTo(appleBindBtn.mas_bottom).mas_offset(30);
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
            NSLog(@"kCheckBoxBtnTag");
            break;
            
        case kFindPwdActTag:
            NSLog(@"kFindPwdActTag");
        break;
            
        case kBindAccountActTag:
            NSLog(@"kBindAccountActTag");
        break;
            
        case kRegisterAccountActTag:
            NSLog(@"kRegisterAccountActTag");
        break;
            
        case kChangePwdActTag:
            NSLog(@"kChangePwdActTag");
        break;
            
        case kBackBtnActTag:
            NSLog(@"kBackBtnActTag");
        break;
            
        case kAccountLoginActTag:
            NSLog(@"kAccountLoginActTag");
        break;
            
            
        default:
            break;
    }
}
@end
