//
//  AccountListViewCell.m
//  R2DSDK
//
//  Created by ganyuanrong on 2020/7/13.
//  Copyright © 2020 ganyuanrong. All rights reserved.
//

#import "AccountListViewCell.h"
#import "CCSkyHourHeader.h"

@implementation AccountListViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
       if (self) {
           [self addCellView];
       }
       return self;
}

- (void)addCellView{
    
    self.deleteAccountBtn = [UIUtil initBtnWithNormalImage:@"fl_sdk_close.png" highlightedImage:@"fl_sdk_close.png" tag:kMoreAccountDeleteActTag selector:@selector(deleteAccontClick:) target:self];
    self.deleteAccountBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.deleteAccountBtn];
    [self.deleteAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView.mas_trailing).mas_offset(-10);
        make.top.mas_equalTo(self.contentView).offset(2);
        make.bottom.mas_equalTo(self.contentView).offset(-2);
        make.width.mas_equalTo(16);
        
    }];
    
    self.accountUILabel = [[UILabel alloc] init];
    self.accountUILabel.font = [UIFont systemFontOfSize:16];
    self.accountUILabel.text = @"XXX";
    self.accountUILabel.textAlignment = NSTextAlignmentCenter;
    self.accountUILabel.backgroundColor = [UIColor clearColor];
    self.accountUILabel.numberOfLines = 1; //0为多行
    self.accountUILabel.textColor = [UIColor colorWithHexString:@"#010101"];
    
    [self.contentView addSubview:self.accountUILabel];
    [self.accountUILabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView).offset(2);
        make.bottom.mas_equalTo(self.contentView).offset(-2);
        make.trailing.mas_equalTo(self.deleteAccountBtn.mas_leading);
        
    }];
}

- (void)deleteAccontClick:(UIButton *)sender
{
    if (self.mItemViewClickHander) {
        self.mItemViewClickHander(sender.tag);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
