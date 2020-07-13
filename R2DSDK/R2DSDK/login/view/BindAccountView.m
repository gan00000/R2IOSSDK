//
//  BindAccountView.m
//  CCSkyHourSDK
//
//  Created by ganyuanrong on 2019/5/30.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "BindAccountView.h"
#import "CCSkyHourHeader.h"
#import "LoginTitleView.h"


@implementation BindAccountView

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
    
    //title
    LoginTitleView *loginTitleView = [[LoginTitleView alloc] initViewWithTitle:@""];
    
    [self addSubview:loginTitleView];
    
    [loginTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self);
        
        make.width.equalTo(@(kBgWidth));
        make.height.mas_equalTo(@(kBgHeight / 5));
    }];
    
    UIView *contentView = [[UIView alloc] init];
    //    contentView.backgroundColor = [UIColor redColor];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(loginTitleView.mas_bottom);
        make.left.bottom.right.mas_equalTo(self);
        
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    
    titleLabel.text = GET_SDK_LOCALIZED(@"R2SDK_BIND_ACCOUNT");
//    titleLabel.backgroundColor = [UIColor blueColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(contentView).mas_offset(20);
//        make.left.right.mas_equalTo(contentView).mas_offset(20, -20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(contentView);
        make.centerX.mas_equalTo(contentView);
        
    }];
    
    UIButton *fbBindBtn = [UIUtil initBtnWithNormalImage:@"r2d_fb_banner.png" highlightedImage:@"r2d_fb_banner.png" tag:201 selector:@selector(clickBtnsAction:) target:self];
   
    fbBindBtn.backgroundColor = [UIColor colorWithHexString:@"#4669af"];
    fbBindBtn.layer.cornerRadius = kR2BtnCornerRadius;
    fbBindBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    fbBindBtn.imageEdgeInsets = UIEdgeInsetsMake(0,-25, 0, 25);
//    button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, 0, imageSize.width);
    
    [contentView addSubview:fbBindBtn];
    [fbBindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(20);
//        make.left.right.mas_equalTo(contentView).mas_offset(20, -20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(contentView).mas_offset(-40);
        make.centerX.mas_equalTo(contentView);
        
    }];
    
    
    UIButton *googleBindBtn = [UIUtil initBtnWithNormalImage:@"r2d_google_banner.png" highlightedImage:@"r2d_google_banner.png" tag:202 selector:@selector(clickBtnsAction:) target:self];
    
    googleBindBtn.backgroundColor = [UIColor whiteColor];
    googleBindBtn.layer.cornerRadius = kR2BtnCornerRadius;
    googleBindBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    googleBindBtn.imageEdgeInsets = UIEdgeInsetsMake(0,-25, 0, 25);
    [contentView addSubview:googleBindBtn];
    [googleBindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(fbBindBtn.mas_bottom).mas_offset(20);
        //        make.left.right.mas_equalTo(contentView).mas_offset(20, -20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(contentView).mas_offset(-40);
        make.centerX.mas_equalTo(contentView);
        
    }];

    
    
    return self;
}


- (void)clickBtnsAction:(UIButton *) button
{
    SDK_LOG(@"clickBtnsAction");
    switch (button.tag) {
        case 201:  //fb
        {
//            SDK_DATA.isBindFb
//            SDK_DATA.isBindGoogle
            if (SDK_DATA.isBindFb) {
                [UIUtil showAlertTips:self.theViewUIViewController msg:GET_SDK_LOCALIZED(@"R2SDK_ACCOUNT_ARLEADY_BIND")];
                return;
            }
            if (self.delegate) {
                [self.delegate clickBindFacebook];
            }
        }
            break;
        case 202:   //google
        {
            
            if (SDK_DATA.isBindGoogle) {
                [UIUtil showAlertTips:self.theViewUIViewController msg:GET_SDK_LOCALIZED(@"R2SDK_ACCOUNT_ARLEADY_BIND")];
                return;
            }
            if (self.delegate) {
                [self.delegate clickBindGoogle];
            }
        }
            break;
            
        default:
            break;
    }
    
}

@end
