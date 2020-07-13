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
   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
    Boolean showEye = NO;
    UIKeyboardType mUIKeyboardType;
    
    switch (type) {
        case SDKTextFiledView_Type_VfCode:
            iconName = @"fl_sdk_dx.png";
            lableName = @"驗證碼";
            mUIKeyboardType = UIKeyboardTypeNumberPad;
            break;
            
        case SDKTextFiledView_Type_Account:
            iconName = @"fl_sdk_ren.png";
            lableName = @"帳號";
            break;
            
        case SDKTextFiledView_Type_Password:
                   
            iconName = @"fl_sdk_suo.png";
            lableName = @"密碼";
            showEye = YES;
            break;
            
        case SDKTextFiledView_Type_Password_New:
            iconName = @"fl_sdk_suo.png";
            lableName = @"新密碼";
            showEye = YES;
            break;
        case SDKTextFiledView_Type_Password_Old:
            iconName = @"fl_sdk_suo.png";
            lableName = @"舊密碼";
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

    UITextField *mUITextField = [[UITextField alloc] init];
    if (mUIKeyboardType) {
        [mUITextField setKeyboardType:mUIKeyboardType];
    }
    
    [self addSubview:mUITextField];
    [mUITextField mas_makeConstraints:^(MASConstraintMaker *make) {
          make.leading.equalTo(tipsUILabel.mas_trailing).mas_offset(10);
          make.top.mas_equalTo(self).offset(10);
          make.bottom.mas_equalTo(self).offset(-10);
          make.trailing.mas_equalTo(self.mas_trailing).mas_offset(-30);
          
      }];

    if (showEye) {
        UIImageView *eyeImageView = [[UIImageView alloc] initWithImage:[UIImage gama_imageNamed:@"fl_sdk_by.png"]];
        eyeImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:eyeImageView];
        [eyeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
//            make.top.mas_equalTo(self).offset(10);
//            make.bottom.mas_equalTo(self).offset(-10);
            make.trailing.mas_equalTo(self.mas_trailing);
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(self).multipliedBy(0.4);
            make.width.mas_equalTo(self.mas_height);
        }];
    }
    
}
@end
