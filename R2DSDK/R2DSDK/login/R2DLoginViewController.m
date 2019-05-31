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


@implementation R2DLoginViewController{
    LoginMainView *loginMainView;
    SDKPage sdkPageType;
    CurrentLoginInfoView *mCurrentLoginInfoView;
    BindAccountView *mBindAccountView;
}

-(instancetype)initWithPageType:(SDKPage) pageType
{
    self = [super init];
    if (self) {
        sdkPageType = pageType;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_noteLisetner:) name:Guest_Login_Tipe_OK object:nil];
        
    }
    
    return self;
}

- (void)dealloc
{
//    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    switch (sdkPageType) {
        case SDKPage_Login:
            {
               [self showLoginPage];
            }
            break;
            
        case SDKPage_LoginType:
        {
            [self showLoginCurrentTypePage];
            
        }
            break;
            
        case SDKPage_UnBind:
        {
            [self showLoginCurrentTypePage];
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
    
        [self.view addSubview:mGuestLoginWarnTipsView];
        [mGuestLoginWarnTipsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@(0));
            make.centerY.equalTo(@(0));
            make.width.equalTo(@(kBgWidth));
            make.height.equalTo(@(kBgHeight - 40));
        }];
}

-(void)showLoginPage
{
    loginMainView = [[LoginMainView alloc] initView];
    [self.view addSubview:loginMainView];
    
    [loginMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(0));
        make.centerY.equalTo(@(0));
        make.width.equalTo(@(kBgWidth));
        make.height.equalTo(@(kBgHeight));
    }];
}

-(void)showLoginCurrentTypePage
{
    //gameLoginType为登录方式
    mCurrentLoginInfoView = [[CurrentLoginInfoView alloc]initWithLoginType:SDK_DATA.gameLoginType];
    mCurrentLoginInfoView.delegate = self;
    
    [self.view addSubview:mCurrentLoginInfoView];
    
    [mCurrentLoginInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(0));
        make.centerY.equalTo(@(0));
        make.width.equalTo(@(kBgWidth));
        make.height.equalTo(@(kBgHeight));
    }];
}

-(void)showLoginUnbind
{
    
}


-(void)showLoginBind
{
        mBindAccountView = [[BindAccountView alloc]initView];
    
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
    }
}

#pragma mark - 代理

- (void)goBindView
{
    [self showLoginBind];
}

- (void)logout
{
    
}

@end
