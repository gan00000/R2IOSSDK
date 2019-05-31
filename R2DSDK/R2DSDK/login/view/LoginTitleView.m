//
//  LoginTitleView.m
//  R2DSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "LoginTitleView.h"
#import "GamaFunction.h"

@implementation LoginTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initView{
 
    self = [super init];
    
    self.backgroundColor = [UIColor colorWithHexString:@"#75787c"];
    
    UIButton *closeImageView = [UIUtil initBtnWithNormalImage:@"sp_btn_close.png" highlightedImage:@"sp_btn_close.png" tag:400 selector:@selector(closeLoginView:) target:self];
    
//    closeImageView.backgroundColor = [UIColor clearColor];
    closeImageView.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:closeImageView];
    [closeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_right).mas_offset(-5);
        make.centerY.equalTo(self.mas_top).mas_offset(5);
        
        make.size.mas_equalTo(CGSizeMake(30,30));
        
    }];
    
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:GetImage(@"r2_logo_mini.png")]; //[UIImage gama_imageNamed:@"r2_logo_mini.png"];
    
    titleImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:titleImageView];
    
    [titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        
        make.size.mas_equalTo(CGSizeMake( kBgWidth / 4, 60));
        
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
    return self;
}

-(void)closeLoginView:(UIButton *) btn{
    [[GamaFunction getCurrentViewController] dismissViewControllerAnimated:NO completion:nil];
}

@end
