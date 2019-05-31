//
//  ViewController.m
//  R2DSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "ViewController.h"
#import "API/R2SDKPlat.h"
#import "R2DLoginViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[R2SDKPlat shareR2SDK] initWithLanguage:@""];
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 60, 160, 40)];
    [loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
    loginBtn.backgroundColor = [UIColor grayColor];
    [loginBtn addTarget:self action:@selector(openLogin:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:loginBtn];
    
    UIButton *loginTypeBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 120, 160, 40)];
    [loginTypeBtn setTitle:@"当前登录方式" forState:(UIControlStateNormal)];
    loginTypeBtn.backgroundColor = [UIColor grayColor];
    [loginTypeBtn addTarget:self action:@selector(openLoginType:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:loginTypeBtn];
    
    
    UIButton *unbindBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 180, 200, 40)];
    [unbindBtn setTitle:@"游戏内解除绑定" forState:(UIControlStateNormal)];
    unbindBtn.backgroundColor = [UIColor grayColor];
    [unbindBtn addTarget:self action:@selector(unbindPage:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:unbindBtn];
    
    
}

-(void)openLogin:(UIButton *)btn
{
    [[R2SDKPlat shareR2SDK] loginWithViewController:self loginHandler:^(R2LoginResponse * _Nonnull r2LoginResult) {
        
        NSLog(@"登录完成");
        
        //取得帐号的 r2 uid，便于游戏自身定位玩家
        NSString *r2UserId = r2LoginResult.r2Uid; //判断是否绑定 Game center 字段
        //取得相关验证登录合法性的数据
        NSString *loginTimestamp = r2LoginResult.timestamp;
        NSString *sign = r2LoginResult.sign;
        NSString *msg = [NSString stringWithFormat:@"current r2 uid=%@  loginTimestamp=%@ sign=%@ ",r2UserId, loginTimestamp, sign];
        
        [self showTips:msg];
    }];
}

-(void)openLoginType:(UIButton *)btn
{
    [[R2SDKPlat shareR2SDK] showCurrentLoginTypeWithViewController:self
                                                     logoutHandler:^(NSInteger logout) {
                                                         [self showTips:@"退出登录了"];
                                                     }];
}

-(void)unbindPage:(UIButton *)btn
{
   
    [[R2SDKPlat shareR2SDK] showUnbindWithViewController:self
                                                     logoutHandler:^(NSInteger logout) {
                                                         [self showTips:@"退出登录了"];
                                                     }];
}

-(void)showTips:(NSString *)msg
{
    NSLog(msg);
    UIAlertController *mAlert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //响应事件
                                                              NSLog(@"action = %@", action);
                                                          }];
    [mAlert addAction:defaultAction];
    [self presentViewController:mAlert animated:YES completion:nil];
}

@end
