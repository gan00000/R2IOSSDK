//
//  AutoLoginView.m
//  R2DSDK
//
//  Created by ganyuanrong on 2020/7/13.
//  Copyright © 2020 ganyuanrong. All rights reserved.
//

#import "AutoLoginView.h"
#import "CCSkyHourHeader.h"
#import "LoginButton.h"

@implementation AutoLoginView
{
    UILabel *loginTipsLable;
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
        
        
        loginTipsLable = [[UILabel alloc] init];
        loginTipsLable.text = @"FACEBOOK账号登录中...";
        loginTipsLable.font = [UIFont systemFontOfSize:24];
        loginTipsLable.textAlignment = NSTextAlignmentCenter;
        loginTipsLable.backgroundColor = [UIColor clearColor];
        loginTipsLable.numberOfLines = 1;
        loginTipsLable.textColor = [UIColor blackColor];
        
         [self addSubview:loginTipsLable];
         [loginTipsLable mas_makeConstraints:^(MASConstraintMaker *make) {
             make.centerX.mas_equalTo(self);
             make.bottom.mas_equalTo(self.mas_centerY).mas_offset(-20);
             make.height.mas_equalTo(60);
             make.width.mas_equalTo(self).mas_equalTo(-30);
             
         }];
        
        UIButton *changeAccount = [LoginButton initBtnWithType:(BUTTON_TYPE_CHANGE_ACCOUNT) tag:11 selector:@selector(changeLoginAccount:)  target:self];
                  [self addSubview:changeAccount];
                  
                  [changeAccount mas_makeConstraints:^(MASConstraintMaker *make) {
                      make.centerX.equalTo(self);
                      make.top.equalTo(self.mas_centerY).mas_offset(20);
                      make.width.mas_equalTo(self).offset(-30);
                      make.height.mas_equalTo(40);
                  }];
        
  
    }
    return self;
}


- (void)changeLoginAccount:(UIButton *)sender
{
    SDK_LOG(@"changeLoginAccount");
    if (self.delegate) {
        [self.delegate goSelectLoginTypeView];
    }
}

@end
