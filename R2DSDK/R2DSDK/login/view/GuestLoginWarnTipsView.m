//
//  GuestLoginWarnTips.m
//  CCSkyHourSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "GuestLoginWarnTipsView.h"
#import "../LoginApi/LoginImp.h"

@implementation GuestLoginWarnTipsView

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
    
    self.backgroundColor = [UIColor colorWithHexString:ContentViewBgColor];
    
    UIImageView *warnImageView = [[UIImageView alloc] initWithImage:[UIImage gama_imageNamed:@"r2d_guest_warning.png"]];
    warnImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:warnImageView];
    [warnImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(0));
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.top.mas_equalTo(self).offset(10);
      
    }];
    
    UILabel *warnTipsUILabel = [[UILabel alloc] init];
    warnTipsUILabel.font = [UIFont systemFontOfSize:15];
    warnTipsUILabel.text = GET_SDK_LOCALIZED(@"R2SDK_GUEST_LOGIN_TIPS");
    warnTipsUILabel.textAlignment = NSTextAlignmentCenter;
    warnTipsUILabel.backgroundColor = [UIColor clearColor];
    warnTipsUILabel.numberOfLines = 0;
    
    [self addSubview:warnTipsUILabel];
    [warnTipsUILabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(0));
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(warnImageView.mas_bottom).offset(10);
        
    }];
    
    
//    //粗体
//    [btn setFont :[ UIFont fontWithName : @”Helvetica-Bold” size : 15 ]];
//    [self.view addSubview:btn];
//
//    //边框线
//    btn.layer.borderWidth = 1;
//    btn.layer.borderColor = [[UIColor grayColor] CGColor];

    
    UIButton *okButtion = [UIUtil initBtnWithTitle:GET_SDK_LOCALIZED(@"R2SDK_OK") tag:123 selector:@selector(clickBtnsAction:) target:self];
    okButtion.backgroundColor = [UIColor whiteColor];
    [okButtion setFont:[ UIFont fontWithName:LABEL_FONT_NAME_BOLD size : 16 ]];
    
    [self addSubview:okButtion];
    [okButtion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(0));
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(warnTipsUILabel.mas_bottom).offset(10);
        
    }];
    
    return self;
}

- (void)clickBtnsAction:(UIButton *) button
{
    SDK_LOG(@"clickBtnsAction");
    
    if (SDK_DATA.loginResult) {
        [LoginImp loginSuccess:SDK_DATA.loginResult mController:self.theViewUIViewController];
    }
}

@end
