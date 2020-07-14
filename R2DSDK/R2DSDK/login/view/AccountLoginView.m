//
//  AccountLoginView.m
//  R2DSDK
//
//  Created by ganyuanrong on 2020/7/9.
//  Copyright © 2020 ganyuanrong. All rights reserved.
//

#import "AccountLoginView.h"
#import "SDKTextFiledView.h"
#import "CCSkyHourHeader.h"
#import "LoginTitleView.h"
#import "LoginButton.h"
#import "RegisterAccountView.h"
#import "AccountListViewCell.h"
#import "BJHTTPServiceEngine.h"
#import "YYModel.h"
#import "AccountModel.h"

static  NSString *AccountListViewCellID = @"AccountListViewCellID";

@interface AccountLoginView() <UITableViewDelegate, UITableViewDataSource>

@end

//会员登入view
@implementation AccountLoginView
{
    SDKTextFiledView *passwordSDKTextFiledView;
    SDKTextFiledView *accountSDKTextFiledView;
    UIButton *checkBoxBtn;
    UIButton *accountLoginBtn;
    UIButton *backBtn;
    UITableView *accountListTableView;
    
    NSMutableArray  *accountDataList;//账号列表数据
}

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
    if (self) {
        
        UIColor *color = [UIColor colorWithHexString:ContentViewBgColor];
        self.backgroundColor = color;//UIColor.lightGrayColor;// 底图透明，控件不透明
        self.layer.cornerRadius = 10; //设置圆角
        self.layer.masksToBounds = YES;
        
        //登入頁logo
        UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage gama_imageNamed:@"fl_sdk_logo"]];
        logoImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:logoImageView];
        [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(12);
            make.centerX.mas_equalTo(self);
            make.width.mas_equalTo(self).mas_offset(-30);
            make.height.mas_equalTo(50);
        }];
        
        backBtn = [UIUtil initBtnWithNormalImage:@"sdk_btn_back.png" highlightedImage:nil tag:kBackBtnActTag selector:@selector(registerViewBtnAction:) target:self];
        [self addSubview:backBtn];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self).mas_offset(20);
            make.width.mas_equalTo(23 * 0.6 );
            make.top.equalTo(self).mas_offset(20);
            make.height.mas_equalTo(37 * 0.6 );
        }];
        
        //账号
        accountSDKTextFiledView = [[SDKTextFiledView alloc] initViewWithType:(SDKTextFiledView_Type_Account)];
        [self addSubview:accountSDKTextFiledView];
        
        [accountSDKTextFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.equalTo(logoImageView.mas_bottom).mas_offset(10);
            make.width.mas_equalTo(self).offset(-30);
            make.height.mas_equalTo(kInputTextFiledWidth);
        }];
        
        
        //账号
        passwordSDKTextFiledView = [[SDKTextFiledView alloc] initViewWithType:(SDKTextFiledView_Type_Password)];
        [self addSubview:passwordSDKTextFiledView];
        
        [passwordSDKTextFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(accountSDKTextFiledView.mas_bottom).mas_offset(10);
            make.leading.mas_equalTo(accountSDKTextFiledView.mas_leading);
            make.trailing.mas_equalTo(accountSDKTextFiledView.mas_trailing);
            make.height.mas_equalTo(accountSDKTextFiledView.mas_height);
        }];
        
        
        //記住密碼
        UILabel *rememberLable = [[UILabel alloc] init];
        rememberLable.text =  @"記住密碼";
        rememberLable.font = [UIFont systemFontOfSize:12];
        rememberLable.textAlignment = NSTextAlignmentLeft;
        rememberLable.backgroundColor = [UIColor clearColor];
        rememberLable.numberOfLines = 1;
        rememberLable.textColor = [UIColor blackColor];
        
        [self addSubview:rememberLable];
        [rememberLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(60);
            make.top.equalTo(passwordSDKTextFiledView.mas_bottom).mas_offset(10);
            make.trailing.mas_equalTo(self.mas_centerX).mas_offset(-40);
            make.height.mas_equalTo(40);
        }];
        
        
        checkBoxBtn = [UIUtil initBtnWithNormalImage:@"btn_checkbox_checked.png" highlightedImage:nil tag:kCheckBoxBtnTag selector:@selector(registerViewBtnAction:) target:self];
        
        [self addSubview:checkBoxBtn];
        [checkBoxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(rememberLable.mas_leading).mas_offset(-4);
            make.centerY.mas_equalTo(rememberLable);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
        }];
        
        //找回密碼
        
        UIButton *findPasswordBtn = [UIUtil initBtnWithTitle2:@"找回密碼" tag:kFindPwdActTag selector:@selector(registerViewBtnAction:) target:self];
        findPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [findPasswordBtn setTitleColor:[UIColor blackColor] forState:0];
        
        [self addSubview:findPasswordBtn];
        [findPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.mas_centerX).mas_offset(40);
            make.centerY.equalTo(rememberLable);
            make.trailing.mas_equalTo(self.mas_trailing).mas_offset(-30);
            make.height.mas_equalTo(40);
        }];
        
        
        //账号登入
        accountLoginBtn = [LoginButton initBtnWithType:(BUTTON_TYPE_ACCOUNT_LOGIN) tag:kAccountLoginActTag selector:@selector(registerViewBtnAction:)  target:self];
        [self addSubview:accountLoginBtn];
        
        [accountLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(rememberLable.mas_bottom).mas_offset(10);
            make.width.mas_equalTo(self).offset(-30);
            make.height.mas_equalTo(40);
        }];
        
        //修改密碼
        UIButton *changePasswordBtn = [UIUtil initBtnWithTitle2:@"修改密碼" tag:kChangePwdActTag selector:@selector(registerViewBtnAction:) target:self];
        [self addSubview:changePasswordBtn];
        [changePasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(90);
            make.top.equalTo(accountLoginBtn.mas_bottom).mas_offset(10);
            make.height.mas_equalTo(40);
        }];
        
        //註冊帳號
        UIButton *registerBtn = [UIUtil initBtnWithTitle2:@"註冊帳號" tag:kRegisterAccountActTag selector:@selector(registerViewBtnAction:) target:self];
        [self addSubview:registerBtn];
        [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(changePasswordBtn.mas_leading).mas_offset(-10);
            make.width.mas_equalTo(changePasswordBtn);
            make.centerY.equalTo(changePasswordBtn);
            make.height.mas_equalTo(changePasswordBtn);
        }];
        
        
        //綁定帳號
        UIButton *bindAccountBtn = [UIUtil initBtnWithTitle2:@"綁定帳號" tag:kBindAccountActTag selector:@selector(registerViewBtnAction:) target:self];
        [self addSubview:bindAccountBtn];
        [bindAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(changePasswordBtn.mas_trailing).mas_offset(10);
            make.width.mas_equalTo(changePasswordBtn);
            make.centerY.equalTo(changePasswordBtn);
            make.height.mas_equalTo(changePasswordBtn);
        }];
        
        
        NSMutableArray  *dataList = [NSMutableArray array];
        
        for (int i = 0;i < 10;i++){
            
            AccountModel *mAccountModel = [[AccountModel alloc] init];
            //赋值
            mAccountModel.lastLoginTime = [NSString stringWithFormat:@"%d", i];
            //[CCSkyHourFunction getTimeStamp];
            mAccountModel.accountName = [NSString stringWithFormat:@"松xxx %@", mAccountModel.lastLoginTime];
            mAccountModel.accountPwd = mAccountModel.lastLoginTime;
            
            [dataList addObject: mAccountModel];
            
        }
        [[ConfigCoreUtil share] saveAccountModels:dataList];//保存
        
        accountDataList = [NSMutableArray array];//账号列表数据
        NSArray *mAccountArray = [[ConfigCoreUtil share] getAccountModels];//获取保存的数据
        if (mAccountArray.count > 1) {
            accountSDKTextFiledView.moreAccountBtn.hidden = NO;
            [accountDataList addObjectsFromArray:mAccountArray];
            
        }else{
            accountSDKTextFiledView.moreAccountBtn.hidden = YES;
        }
        
        //添加账号显示列表
        accountSDKTextFiledView.clickAccountListItem = ^(NSInteger tag) {
            
            if (accountListTableView) {
                //设置点击显示、隐藏
                if (accountListTableView.tag == 0) {
                    [self setTableViewHiden:YES];
                    NSArray *mAccountArray = [[ConfigCoreUtil share] getAccountModels];//获取保存的数据
                    [accountDataList removeAllObjects];
                    [accountDataList addObjectsFromArray:mAccountArray];
                    [accountListTableView reloadData];
                }else{
                    [self setTableViewHiden:NO];
                }
                
                
            }else{//第一次点击显示
                [self addAccountListTableView];
            }
            
        };
    }
    return self;
}

//设置隐藏或者显示
-(void) setTableViewHiden:(BOOL) hiden
{
    accountListTableView.hidden = hiden;
    if (hiden) {
        accountListTableView.tag = 1;
    }else{
        accountListTableView.tag = 0;
    }
}


- (void)addAccountListTableView
{
    
    //账号下拉列表
    accountListTableView = [[UITableView alloc] init];
    accountListTableView.backgroundColor = [UIColor whiteColor];
    [self setTableViewHiden:NO];
    accountListTableView.delegate = self;
    accountListTableView.dataSource = self;
    accountListTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //    accountListTableView.estimatedRowHeight = 0;
    //    accountListTableView.estimatedSectionFooterHeight = 0;
    //    accountListTableView.estimatedSectionHeaderHeight = 0;
    
    [accountListTableView registerClass:[AccountListViewCell class] forCellReuseIdentifier:AccountListViewCellID];
    [self addSubview:accountListTableView];
    [accountListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(accountSDKTextFiledView.mas_leading);
        make.trailing.mas_equalTo(accountSDKTextFiledView.mas_trailing);
        make.top.equalTo(accountSDKTextFiledView.mas_bottom);
        make.height.mas_equalTo(100);
    }];
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
            if (self.delegate) {
                [self.delegate goSelelctBindTypeView];
            }
            break;
            
        case kRegisterAccountActTag:
            SDK_LOG(@"kRegisterAccountActTag");
            if (self.delegate) {
                [self.delegate goRegisterAccountView];
            }
            break;
            
        case kChangePwdActTag:
            SDK_LOG(@"kChangePwdActTag");
            if (self.delegate) {
                [self.delegate goChangePasswordView];
            }
            break;
            
        case kBackBtnActTag:
            SDK_LOG(@"kBackBtnActTag");
            if (self.delegate) {
                [self.delegate goBackBtn:backBtn backCount:1];
            }
            break;
            
        case kAccountLoginActTag:
            SDK_LOG(@"kAccountLoginActTag");
            break;
            
            
        default:
            break;
    }
    
}

-(void) requestAccountLogin
{
    
    NSString *accountName = @"";
    NSString *pwd = @"";
    //    https://login.gamesword.com/login.app?spy_advertiser=&gameCode=twsmios&osLanguage=en&versionName=1.0&captcha=&packageName=com.gamamobi.twsm&deviceType=x86_64&gameLanguage=zh-TW&uuid=ca0a311f-281d-4650-a173-4b91e35d680c&versionCode=1.0.3&signature=1949184f908a1290d90805244c2e2fde&loginTimestamp=1594696873798&name=666666&accessToken=38c9ce91f8cd022a37348f8dcbff7877&pwd=e10adc3949ba59abbe56e057f20f883e&operatingSystem=ios&timestamp=1594697614993&uniqueId=ca0a311f-281d-4650-a173-4b91e35d680c&systemVersion=13.3&adId=00000000-0000-0000-0000-000000000000&spy_platForm=&idfa=00000000-0000-0000-0000-000000000000
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"captcha"] = @"";
    param[@"name"] = accountName;
    param[@"pwd"] = pwd;
    
    
    [BJHTTPServiceEngine postRequestWithFunctionPath:@"" params:param successBlock:^(id responseData) {
        
        CCSDKResponse *mCCSDKResponse = [CCSDKResponse yy_modelWithDictionary:responseData];
        
    } errorBlock:^(BJError *error) {
        
    }];
}

#pragma mark tableview deletage
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return accountDataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountModel *mAccountModel = accountDataList[indexPath.row];
    AccountListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AccountListViewCellID forIndexPath:indexPath];
    cell.accountUILabel.text = mAccountModel.accountName;
    kWeakSelf
    cell.mItemViewClickHander = ^(NSInteger tag) {
        if (tag == kMoreAccountDeleteActTag) {
            [accountDataList removeObject:mAccountModel];
            [tableView reloadData];
            [[ConfigCoreUtil share] saveAccountModels:accountDataList];//保存
            if (accountDataList.count == 0) { //删除到位0的时候隐藏tableview和moreAccountBtn
                [self setTableViewHiden:YES];
                accountSDKTextFiledView.moreAccountBtn.hidden = YES;
            }
        }
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SDK_LOG(@"didSelectRowAtIndexPath %ld", indexPath.row);
    AccountModel *mAccountModel = accountDataList[indexPath.row];
    accountSDKTextFiledView.inputUITextField.text = mAccountModel.accountName;
    passwordSDKTextFiledView.inputUITextField.text = mAccountModel.accountPwd;
    [self setTableViewHiden:YES];
}

@end
