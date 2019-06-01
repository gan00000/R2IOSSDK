//
//  CurrentLoginInfoView.m
//  R2DSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "CurrentLoginInfoView.h"

#import "R2DHeader.h"
#import "LoginTitleView.h"
#import "../LoginApi/LoginImp.h"

@implementation CurrentLoginInfoView
{
    UIImageView *currentLogoImageView;
    NSInteger loginType;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithLoginType:(NSInteger)mLoginType{
 
    self = [super init];
    loginType = mLoginType;
    
    self.backgroundColor = [UIColor colorWithHexString:ContentViewBgColor];
    
    //title
    LoginTitleView *loginTitleView = [[LoginTitleView alloc] initView];
    
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
    
    UILabel *currentTipsLabel = [[UILabel alloc] init];
    
    currentTipsLabel.font = [UIFont systemFontOfSize:15];
    currentTipsLabel.text = GET_SDK_LOCALIZED(@"R2SDK_CURRENT_LOGIN_TYPE");
    currentTipsLabel.textAlignment = NSTextAlignmentCenter;
    currentTipsLabel.backgroundColor = [UIColor clearColor];

    [contentView addSubview:currentTipsLabel];
    [currentTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(kBgWidth / 2);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(contentView).offset(15);
        make.left.mas_equalTo(contentView).offset(10);
    }];
    

    
    currentLogoImageView = [[UIImageView alloc] initWithImage:[UIImage gama_imageNamed:@"r2d_fb_current.png"]];
    currentLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [contentView addSubview:currentLogoImageView];
    [currentLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
        make.top.mas_equalTo(currentTipsLabel.mas_bottom).offset(10);
        make.centerX.mas_equalTo(currentTipsLabel);
    }];
    
    UIButton *logoutBtn = [UIUtil initBtnWithTitle:GET_SDK_LOCALIZED(@"R2SDK_LOGOUT") tag:123 selector:@selector(clickBtnsAction:) target:self];
    logoutBtn.backgroundColor = [UIColor whiteColor];
    [logoutBtn setFont:[ UIFont fontWithName:LABEL_FONT_NAME_BOLD size : 16 ]];
    
    [contentView addSubview:logoutBtn];
    [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(34);
        make.top.mas_equalTo(currentTipsLabel.mas_bottom).offset(10);
        make.centerY.mas_equalTo(contentView);
        make.left.mas_equalTo(currentLogoImageView.mas_right).offset(60);
    }];
    
    

    UIButton *guestBindBtn = [UIUtil initBtnWithTitle:GET_SDK_LOCALIZED(@"R2SDK_BIND_ACCOUNT") tag:124 selector:@selector(clickBtnsAction:) target:self];
    guestBindBtn.backgroundColor = [UIColor whiteColor];
    [guestBindBtn setFont:[ UIFont fontWithName:LABEL_FONT_NAME_BOLD size : 16 ]];

    [contentView addSubview:guestBindBtn];
    [guestBindBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.width.mas_equalTo(100);
        make.height.mas_equalTo(34);
        make.top.mas_equalTo(logoutBtn.mas_bottom).offset(20);
        make.centerX.mas_equalTo(logoutBtn);
    
    }];
    
    if (loginType == LoginTypeGuest) {
        [logoutBtn setTitle:GET_SDK_LOCALIZED(@"R2SDK_Guest_Logout") forState: UIControlStateNormal];
        
        currentLogoImageView.image = [UIImage gama_imageNamed:@"r2d_guest_current.png"];
        
    }else{
        [logoutBtn setTitle:GET_SDK_LOCALIZED(@"R2SDK_LOGOUT") forState: UIControlStateNormal];
        guestBindBtn.hidden = YES;
        if (loginType == LoginTypeFacebook) {
            currentLogoImageView.image = [UIImage gama_imageNamed:@"r2d_fb_current.png"];
        }else if (loginType == LoginTypeGoogle){
            currentLogoImageView.image = [UIImage gama_imageNamed:@"r2d_google_current.png"];
        }
        
    }
    
    return self;
}

- (void)clickBtnsAction:(UIButton *) button
{
    SDK_LOG(@"clickBtnsAction");
    switch (button.tag) {
            
        case 123:

            if (loginType == LoginTypeGuest) {
                if (self.delegate) {
                    [self.delegate goGuestLoginoutTipsView];
                }
            }else
            {
                [LoginImp logoutAccount:self.theViewUIViewController];
            }
            
            
            break;
            
        case 124:
//            [SDK_DATA.r2dLoginVC showLoginBind];
            if (self.delegate) {
                [self.delegate goBindView];
            }
            break;
            
       
  
            
        default:
            break;
    }
    
}

@end
