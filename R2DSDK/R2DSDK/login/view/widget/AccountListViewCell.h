//
//  AccountListViewCell.h
//  R2DSDK
//
//  Created by ganyuanrong on 2020/7/13.
//  Copyright © 2020 ganyuanrong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountListViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *accountUILabel;
@property (nonatomic, strong) UIButton *deleteAccountBtn;

@end

NS_ASSUME_NONNULL_END
