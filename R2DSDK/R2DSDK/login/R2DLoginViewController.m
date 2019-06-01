//
//  R2DLoginViewController.m
//  R2DSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "R2DLoginViewController.h"
#import "view/LoginMainView.h"
#import "view/GuestLoginWarnTipsView.h"
#import "view/CurrentLoginInfoView.h"
#import "view/BindAccountView.h"
#import "LoginImp.h"
#import "view/GuestLogoutWarnTipsView.h"
#import "view/FBGGUnbindView.h"
#import "R2SDKPlat.h"


@implementation R2DLoginViewController{
    LoginMainView *loginMainView;
    SDKPage sdkPageType;
    CurrentLoginInfoView *mCurrentLoginInfoView;
    BindAccountView *mBindAccountView;
    FBGGUnbindView *mFBGGUnbindView;
}

-(instancetype)initWithPageType:(SDKPage) pageType
{
    self = [super init];
    if (self) {
        sdkPageType = pageType;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_noteLisetner:) name:Guest_Login_Tipe_OK object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_noteLisetner:) name:SDK_AUTO_LOGIN_FAIL object:nil];
        
        
    }
    
    return self;
}

// 视图被销毁
- (void)dealloc
{
//    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    SDK_LOG(@"dealloc视图被销毁");
//    [R2SDKPlat shareR2SDK].sdkPresentedVC = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SDK_LOG(@"viewDidLoad");
    self.view.backgroundColor = [UIColor clearColor];

}

- (void)viewDidAppear:(BOOL)animated
{
    SDK_LOG(@"viewDidAppear");
    switch (sdkPageType) {
        case SDKPage_Login:
        {
            [self showLoginPageOrAutoLogin];
        }
            break;
            
        case SDKPage_LoginType:
        {
            [self showLoginCurrentTypePage];
            
        }
            break;
            
        case SDKPage_UnBind:
        {
            [self showLoginUnbindPage];
        }
            break;
        default:
            break;
    }
}

-(void)showGuestLoginWarnTipsView
{
    //移除所有子视图
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

        GuestLoginWarnTipsView *mGuestLoginWarnTipsView = [[GuestLoginWarnTipsView alloc]initView];
        mGuestLoginWarnTipsView.theViewUIViewController = self;
        [self.view addSubview:mGuestLoginWarnTipsView];
        [mGuestLoginWarnTipsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@(0));
            make.centerY.equalTo(@(0));
            make.width.equalTo(@(kBgWidth));
            make.height.equalTo(@(kBgHeight - 40));
        }];
}

-(void)showLoginPageOrAutoLogin
{
 
    if (SDK_DATA.isNeedAutoLogin) {//是否需要自动登录
        
        if (SDK_DATA.gameLoginType == LoginTypeGoogle) {//自动登录
            [self addAutoLoginTipsView];
             [LoginImp loginGoogleAccount:self isFormAutoLogin:YES];
            
        }else if (SDK_DATA.gameLoginType == LoginTypeFacebook){//自动登录
            [self addAutoLoginTipsView];
             [LoginImp loginFBAccount:self isFormAutoLogin:YES];
            
        }else if (SDK_DATA.gameLoginType == LoginTypeGuest){//自动登录
            [self addAutoLoginTipsView];
            
            [LoginImp loginGuestAccount:self isFormAutoLogin:YES];
            
        }else{//弹出登录界面
            [self showLoginPage];
        }
    }else{
         [self showLoginPage];
    }
    
  
}

-(void)showLoginPage
{
    //移除所有子视图
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    loginMainView = [[LoginMainView alloc] initView];
    loginMainView.delegate = self;
    loginMainView.theViewUIViewController = self;
    [self.view addSubview:loginMainView];
    
    [loginMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(0));
        make.centerY.equalTo(@(0));
        make.width.equalTo(@(kBgWidth));
        make.height.equalTo(@(kBgHeight));
    }];
}

-(void)addAutoLoginTipsView
{
    UILabel *autoLabe = [[UILabel alloc]init];
    autoLabe.font = [UIFont systemFontOfSize:15];
    autoLabe.text = GET_SDK_LOCALIZED(@"R2SDK_AUTO_LOGINING");
    autoLabe.textAlignment = NSTextAlignmentCenter;
    autoLabe.backgroundColor = [UIColor clearColor];
    autoLabe.numberOfLines = 0;
    
    [self.view addSubview:autoLabe];
    [autoLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(0));
        make.centerY.equalTo(@(0)).offset(40);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(160);
        
    }];
    
}

-(void)showLoginCurrentTypePage
{
    //gameLoginType为登录方式
    mCurrentLoginInfoView = [[CurrentLoginInfoView alloc]initWithLoginType:SDK_DATA.gameLoginType];
    mCurrentLoginInfoView.delegate = self;
    mCurrentLoginInfoView.theViewUIViewController = self;
    [self.view addSubview:mCurrentLoginInfoView];
    
    [mCurrentLoginInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(0));
        make.centerY.equalTo(@(0));
        make.width.equalTo(@(kBgWidth));
        make.height.equalTo(@(kBgHeight));
    }];
}

-(void)showFBGGUnbindView
{
    //gameLoginType为登录方式
    mFBGGUnbindView = [[FBGGUnbindView alloc]initWithLoginType:SDK_DATA.gameLoginType];
    mFBGGUnbindView.delegate = self;
    mFBGGUnbindView.theViewUIViewController = self;
    [self.view addSubview:mFBGGUnbindView];
    
    [mFBGGUnbindView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(0));
        make.centerY.equalTo(@(0));
        make.width.equalTo(@(kBgWidth));
        make.height.equalTo(@(kBgHeight));
    }];
}


-(void)showLoginUnbindPage
{
    if (SDK_DATA.gameLoginType == LoginTypeGuest) {
        [self showLoginCurrentTypePage];
    }else
    {
        [self showFBGGUnbindView];
    }
}


-(void)showLoginBind
{
        mBindAccountView = [[BindAccountView alloc]initView];
    
        mBindAccountView.delegate = self;
        mBindAccountView.theViewUIViewController = self;
        [self.view addSubview:mBindAccountView];
    
        [mBindAccountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@(0));
            make.centerY.equalTo(@(0));
            make.width.equalTo(@(kBgWidth));
            make.height.equalTo(@(kBgHeight));
        }];
}

#pragma mark - 通知方法
- (void)_noteLisetner:(NSNotification *)note
{
    NSString *noteName = note.name;
    if ([noteName isEqualToString: Guest_Login_Tipe_OK]) {
        
        [self showGuestLoginWarnTipsView];
    }else if ([noteName isEqualToString:SDK_AUTO_LOGIN_FAIL]){
        [self showLoginPage];
    }
}

#pragma mark - 代理

- (void)goBindView
{
    [self showLoginBind];
}

-(void)goGuestLoginoutTipsView
{
    GuestLogoutWarnTipsView *mGuestLogoutWarnTipsView = [[GuestLogoutWarnTipsView alloc]initView];
    mGuestLogoutWarnTipsView.theViewUIViewController = self;
    [self.view addSubview:mGuestLogoutWarnTipsView];
    
    [mGuestLogoutWarnTipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(0));
        make.centerY.equalTo(@(0));
        make.width.equalTo(@(kBgWidth));
        make.height.equalTo(@(kBgHeight));
    }];
}

- (void)logout
{
    
}

-(void)clickBindFacebook
{
    SDK_LOG(@"bindFacebook");
    [LoginImp bindFacebook:self];
}
-(void)clickBindGoogle
{
    SDK_LOG(@"bindGoogle");
    [LoginImp bindGoogle:self];
}

-(void)unBindGoogle
{
    SDK_LOG(@"unBindGoogle");
    [LoginImp unbindGoogle:self];
}
-(void)unBindFacebook
{
    SDK_LOG(@"unBindFacebook");
    [LoginImp unbindFacebook:self];
}

-(void)clickFbLogin
{   SDK_LOG(@"clickFbLogin");
     [LoginImp loginFBAccount:self isFormAutoLogin:NO];
}
-(void)clickGoogleLogin
{
    SDK_LOG(@"clickGoogleLogin");
    [LoginImp loginGoogleAccount:self isFormAutoLogin:NO];
}

-(void)clickGuestLogin
{
    SDK_LOG(@"clickGuestLogin");
    [LoginImp loginGuestAccount:self isFormAutoLogin:NO];
}

@end
