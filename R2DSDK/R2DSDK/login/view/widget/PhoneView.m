//
//  PhoneView.m
//  R2DSDK
//
//  Created by ganyuanrong on 2020/7/12.
//  Copyright © 2020 ganyuanrong. All rights reserved.
//

#import "PhoneView.h"
#import "CCSkyHourHeader.h"

@implementation PhoneView

- (instancetype)initView
{
    self = [super init];
    if (self) {
        [self addContentView];
    }
    return self;
}


- (void) addContentView
{

    self.backgroundColor = [UIColor clearColor];
    
    NSString *iconName = @"fl_sdk_mb.png";
    NSString *lableName = @"電話";
    
    UIView *areaCodeContentView = [[UIView alloc] init];
     areaCodeContentView.layer.cornerRadius = 4;
    areaCodeContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:areaCodeContentView];
    [areaCodeContentView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.leading.equalTo(self.mas_leading);
        make.top.mas_equalTo(self);
       make.height.mas_equalTo(self);
       make.width.mas_equalTo(self).multipliedBy(0.3);
    }];
    
    UIImageView *lableIconImageView = [[UIImageView alloc] initWithImage:[UIImage gama_imageNamed:iconName]];
    lableIconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [areaCodeContentView addSubview:lableIconImageView];
    [lableIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.leading.equalTo(areaCodeContentView.mas_leading).mas_offset(10);
        make.centerY.mas_equalTo(areaCodeContentView);
       make.height.mas_equalTo(areaCodeContentView).multipliedBy(0.4);
       make.width.mas_equalTo(lableIconImageView.mas_height);
    }];
   
   UILabel *tipsUILabel = [[UILabel alloc] init];
   tipsUILabel.font = [UIFont systemFontOfSize:16];
   tipsUILabel.text = lableName;
   tipsUILabel.textAlignment = NSTextAlignmentCenter;
   tipsUILabel.backgroundColor = [UIColor clearColor];
   tipsUILabel.numberOfLines = 1; //0为多行
    tipsUILabel.textColor = [UIColor colorWithHexString:@"#FF3E37"];
   
   [areaCodeContentView addSubview:tipsUILabel];
   [tipsUILabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.leading.equalTo(lableIconImageView.mas_trailing).mas_offset(4);
       make.top.mas_equalTo(areaCodeContentView).offset(2);
       make.bottom.mas_equalTo(areaCodeContentView).offset(-2);
       make.width.mas_equalTo(40);
       
   }];
    
    UIView *phoneInputContentView = [[UIView alloc] init];
    
     phoneInputContentView.layer.cornerRadius = 4;
    phoneInputContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:phoneInputContentView];
    [phoneInputContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(areaCodeContentView.mas_trailing).mas_offset(20);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.trailing.mas_equalTo(self.mas_trailing);
    }];

    UITextField *mUITextField = [[UITextField alloc] init];
    [mUITextField setKeyboardType:(UIKeyboardTypePhonePad)];
    [phoneInputContentView addSubview:mUITextField];
    [mUITextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(phoneInputContentView).mas_offset(20);
        make.top.mas_equalTo(phoneInputContentView);
        make.bottom.mas_equalTo(phoneInputContentView);
        make.trailing.mas_equalTo(phoneInputContentView);
          
      }];

    
}

@end
