//
//  SDKTextFiledView.m
//  R2DSDK
//
//  Created by ganyuanrong on 2020/7/9.
//  Copyright © 2020 ganyuanrong. All rights reserved.
//

#import "SDKTextFiledView.h"
#import "UIUtil.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CCSkyHourHeader.h"

@implementation SDKTextFiledView
{
    UITextField *mUITextField;
}


- (instancetype)initViewWithType:(SDKTextFiledView_Type) type
{
    self = [super init];
    if (self) {
        [self addContentView:type];
    }
    return self;
}


- (void) addContentView:(SDKTextFiledView_Type) type
{
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 4;
    
    NSString *iconName;
    NSString *lableName;
    BOOL showEye = NO;
    BOOL addMoreAccountBtn = NO;
    UIKeyboardType mUIKeyboardType = UIKeyboardTypeDefault;
    NSString *placeholderText = @"";
    
    switch (type) {
        case SDKTextFiledView_Type_VfCode:
            iconName = @"fl_sdk_dx.png";
            lableName = @"驗證碼";
            mUIKeyboardType = UIKeyboardTypeNumberPad;
            placeholderText = @"請輸入驗證碼";
            break;
            
        case SDKTextFiledView_Type_Account:
            iconName = @"fl_sdk_ren.png";
            lableName = @"帳號";
            placeholderText = @"6~18字符,僅限字母或數字";
            addMoreAccountBtn = YES;
            break;
            
        case SDKTextFiledView_Type_Password:
            
            iconName = @"fl_sdk_suo.png";
            lableName = @"密碼";
            placeholderText = @"6~18字符,僅限字母或數字";
            showEye = YES;
            break;
            
        case SDKTextFiledView_Type_Password_New:
            iconName = @"fl_sdk_suo.png";
            lableName = @"新密碼";
            //placeholderText = @"6~18字符,僅限字母或數字";
            showEye = YES;
            break;
        case SDKTextFiledView_Type_Password_Old:
            iconName = @"fl_sdk_suo.png";
            lableName = @"舊密碼";
            //placeholderText = @"6~18字符,僅限字母或數字";
            showEye = YES;
            break;
            
        default:
            break;
    }
    
    UIImageView *lableIconImageView = [[UIImageView alloc] initWithImage:[UIImage gama_imageNamed:iconName]];
    lableIconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:lableIconImageView];
    [lableIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading).mas_offset(10);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(self).multipliedBy(0.4);
        make.width.mas_equalTo(lableIconImageView.mas_height);
    }];
    
    UILabel *tipsUILabel = [[UILabel alloc] init];
    tipsUILabel.font = [UIFont systemFontOfSize:16];
    tipsUILabel.text = lableName;
    tipsUILabel.textAlignment = NSTextAlignmentLeft;
    tipsUILabel.backgroundColor = [UIColor clearColor];
    tipsUILabel.numberOfLines = 1; //0为多行
    tipsUILabel.textColor = [UIColor colorWithHexString:@"#FF3E37"];
    
    [self addSubview:tipsUILabel];
    [tipsUILabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(lableIconImageView.mas_trailing).mas_offset(4);
        make.top.mas_equalTo(self).offset(2);
        make.bottom.mas_equalTo(self).offset(-2);
        make.width.mas_equalTo(60);
        
    }];
    
    int trailing_offset = -10;
    if (addMoreAccountBtn || showEye) {
        trailing_offset = -40;
    }
    
    mUITextField = [[UITextField alloc] init];
    self.inputUITextField = mUITextField;
    if (mUIKeyboardType) {
        [mUITextField setKeyboardType:mUIKeyboardType];
    }
    mUITextField.placeholder = placeholderText;
    mUITextField.adjustsFontSizeToFitWidth = YES;//文字大小适配宽度大小
    [self addSubview:mUITextField];
    [mUITextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(tipsUILabel.mas_trailing).mas_offset(2);
        make.top.mas_equalTo(self).offset(10);
        make.bottom.mas_equalTo(self).offset(-10);
        make.trailing.mas_equalTo(self.mas_trailing).mas_offset(trailing_offset);
        
    }];
    
    if (addMoreAccountBtn) {
        
        self.moreAccountBtn = [UIUtil initBtnWithNormalImage:@"sdk_list_down.png" highlightedImage:nil tag:kMoreAccountListActTag selector:@selector(clickItemBtn:) target:self];
        self.moreAccountBtn.hidden = YES;
        self.moreAccountBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.moreAccountBtn];
        [self.moreAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.trailing.mas_equalTo(self.mas_trailing).mas_offset(-10);
            make.centerY.mas_equalTo(mUITextField.mas_centerY);
            make.height.mas_equalTo(mUITextField);
            make.width.mas_equalTo(20);
        }];
        
    }
    
    
    
    if (showEye) {
        mUITextField.secureTextEntry = NO;
        UIButton *eyeBtn = [UIUtil initBtnWithNormalImage:@"fl_sdk_ky.png" highlightedImage:nil tag:22 selector:@selector(eyeViewBtnAction:) target:self];
        eyeBtn.selected = NO;//设置为没有选择
        
        //        UIImageView *eyeImageView = [[UIImageView alloc] initWithImage:[UIImage gama_imageNamed:@"fl_sdk_by.png"]];
        //        eyeImageView.contentMode = UIViewContentModeScaleAspectFit;
        eyeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:eyeBtn];
        [eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            //            make.top.mas_equalTo(self).offset(10);
            //            make.bottom.mas_equalTo(self).offset(-10);
            make.trailing.mas_equalTo(self.mas_trailing).mas_offset(-10);
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(self.mas_height).multipliedBy(0.4);
            make.height.mas_equalTo(self.mas_height);
        }];
    }
    
}

- (void)eyeViewBtnAction:(UIButton *)sender
{
    
    if (sender.selected) { // 按下去了就是明文
        
        NSString *tempPwdStr = mUITextField.text;
        mUITextField.text = @""; // 这句代码可以防止切换的时候光标偏移
        mUITextField.secureTextEntry = NO;
        mUITextField.text = tempPwdStr;
        [sender setImage:GetImage(@"fl_sdk_ky.png") forState:UIControlStateNormal];
        
    } else { // 暗文
        
        NSString *tempPwdStr = mUITextField.text;
        mUITextField.text = @"";
        mUITextField.secureTextEntry = YES;
        mUITextField.text = tempPwdStr;
        
        [sender setImage:GetImage(@"fl_sdk_by.png") forState:UIControlStateNormal];
    }
    // 切换按钮的状态
    sender.selected = !sender.selected;
}

//点击账号记录下拉列表
- (void)clickItemBtn:(UIButton *)sender
{
    if (self.clickAccountListItem) {
        self.clickAccountListItem(sender.tag);
    }
}

@end
