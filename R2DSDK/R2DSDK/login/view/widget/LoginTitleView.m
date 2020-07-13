//
//  LoginTitleView.m
//  CCSkyHourSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "LoginTitleView.h"
#import "CCSkyHourFunction.h"

@implementation LoginTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initViewWithTitle:(NSString *)title{
 
    self = [super init];
    
    self.backgroundColor = [UIColor clearColor];
    
     //标题
   UILabel *titleLable = [[UILabel alloc] init];
   titleLable.text = title;
   titleLable.font = [UIFont systemFontOfSize:24];
   titleLable.textAlignment = NSTextAlignmentCenter;
   titleLable.backgroundColor = [UIColor clearColor];
   titleLable.numberOfLines = 1;
   titleLable.textColor = [UIColor colorWithHexString:@"#FF3E37"];
   
    [self addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
    }];
    
    
    UIButton *backBtn = [UIUtil initBtnWithNormalImage:@"sdk_btn_back.png" highlightedImage:nil tag:kBackBtnActTag selector:@selector(closeLoginView:) target:self];
   [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).mas_offset(10);
        make.width.mas_equalTo(23 * 0.6 );
        make.centerY.equalTo(self);
        make.height.mas_equalTo(37 * 0.6 );
    }];
    
    return self;
}

-(void)closeLoginView:(UIButton *) btn{
    NSLog(@"kBackBtnActTag");
   // [hillTopViewController dismissViewControllerAnimated:NO completion:nil];
    if (self.delegate) {
        [self.delegate goBackBtn:btn backCount:2];
    }
    
}

@end
