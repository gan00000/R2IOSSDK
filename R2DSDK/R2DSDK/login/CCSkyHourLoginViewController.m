//
//  CCSkyHourLoginViewController.m
//  CCSkyHourSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "CCSkyHourLoginViewController.h"
#import "view/SelectLoginTypeView.h"
#import "view/GuestLoginWarnTipsView.h"
#import "view/BindAccountView.h"
#import "LoginImp.h"
#import "view/GuestLogoutWarnTipsView.h"
#import "CCSkyHourSDKPlat.h"
#import "AccountLoginView.h"
#import "RegisterAccountView.h"
#import "ChangePasswordView.h"
#import "SelectBindTypeView.h"


@implementation CCSkyHourLoginViewController{
    SelectLoginTypeView *mSelectLoginTypeView;
    SDKPage sdkPageType;
   
    BindAccountView *mBindAccountView;
    AccountLoginView *mAccountLoginView;
    BOOL autoLoginDone;
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
    autoLoginDone = NO;
    
    switch (sdkPageType) {
        case SDKPage_Login:
        {
            [self showLoginPageOrAutoLogin];
        }
            break;
            
        case SDKPage_LoginType:
        {
            
            
        }
            break;
            
        case SDKPage_UnBind:
        {
            
        }
            break;
        default:
            break;
    }

}

- (void)viewDidAppear:(BOOL)animated
{
    SDK_LOG(@"viewDidAppear");
    
    switch (sdkPageType) {
        case SDKPage_Login:
        {
            if (SDK_DATA.isNeedAutoLogin && !autoLoginDone) {
                
                autoLoginDone = YES;
                
                if (SDK_DATA.gameLoginType == LoginTypeGoogle) {//自动登录
                    
                    [LoginImp loginGoogleAccount:self isFormAutoLogin:YES];
                    
                }else if (SDK_DATA.gameLoginType == LoginTypeFacebook){//自动登录
                    
                    [LoginImp loginFBAccount:self isFormAutoLogin:YES];
                    
                }else if (SDK_DATA.gameLoginType == LoginTypeGuest){//自动登录
                    
                    [LoginImp loginGuestAccount:self isFormAutoLogin:YES];
                    
                }else{//弹出登录界面
                    [self showLoginPage];
                }
                
            }
        }
            break;
        default:
            break;
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    SDK_LOG(@"viewWillAppear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    SDK_LOG(@"viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    SDK_LOG(@"viewDidDisappear");
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
        
      
//        if (SDK_DATA.gameLoginType == LoginTypeGoogle) {//自动登录
//            [self addAutoLoginTipsView];
//             [LoginImp loginGoogleAccount:self isFormAutoLogin:YES];
//
//        }else if (SDK_DATA.gameLoginType == LoginTypeFacebook){//自动登录
//            [self addAutoLoginTipsView];
//             [LoginImp loginFBAccount:self isFormAutoLogin:YES];
//
//        }else if (SDK_DATA.gameLoginType == LoginTypeGuest){//自动登录
//            [self addAutoLoginTipsView];
//
//            [LoginImp loginGuestAccount:self isFormAutoLogin:YES];
//
//        }else{//弹出登录界面
//            [self showLoginPage];
//        }
    }else{
         [self showLoginPage];
    }
    
  
}

-(void)showLoginPage
{
    //移除所有子视图
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    [self addSelectLoginTypeView];
//    [self addAccountLoginView];
//    [self addRegisterAccountView];
}

-(void)addSelectLoginTypeView
{
    
    mSelectLoginTypeView = [[SelectLoginTypeView alloc] initView];
    [self addSubSdkLoginView:mSelectLoginTypeView];
}

-(void)addAccountLoginView
{
    
    mAccountLoginView = [[AccountLoginView alloc] initView];
    [self addSubSdkLoginView:mAccountLoginView];
}

-(void)addRegisterAccountView
{
    
    RegisterAccountView *mRegisterAccountView = [[RegisterAccountView alloc] initView];
    [self addSubSdkLoginView:mRegisterAccountView];
}

-(void)addChangePasswordView
{
    
    ChangePasswordView *view = [[ChangePasswordView alloc] initView];
    [self addSubSdkLoginView:view];
}

-(void)addSelectBindTypeView
{
    
    SelectBindTypeView *view = [[SelectBindTypeView alloc] initView];
    [self addSubSdkLoginView:view];
}

-(void)addSubSdkLoginView:(SDKBaseView *)mSDKBaseView
{
    
    mSDKBaseView.delegate = self;
    mSDKBaseView.theViewUIViewController = self;
    mSDKBaseView.layer.cornerRadius = 10;
    [self.view addSubview:mSDKBaseView];
    
    [mSDKBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
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

- (void)goAccountLoginView{
    [self addAccountLoginView];
}

- (void)goSelelctBindTypeView
{
    [self addSelectBindTypeView];
}

-(void)goRegisterAccountView{
    [self addRegisterAccountView];
}

- (void)goChangePasswordView{
    [self addChangePasswordView];
}

- (void)goBackBtn:(UIButton *)backBtn backCount:(NSUInteger) count{
    if (count == 1) {
        [[backBtn superview] removeFromSuperview];
    }else if (count == 2){
        [[[backBtn superview] superview] removeFromSuperview];
    }
    
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
