//
//  CurrentLoginInfoView.h
//  R2DSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../LoginViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface CurrentLoginInfoView : UIView

@property(nonatomic, weak) id<LoginViewDelegate> delegate;
- (instancetype)initWithLoginType:(NSInteger)mLoginType;

@end

NS_ASSUME_NONNULL_END
