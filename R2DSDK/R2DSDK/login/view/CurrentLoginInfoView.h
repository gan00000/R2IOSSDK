//
//  CurrentLoginInfoView.h
//  CCSkyHourSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../LoginViewDelegate.h"
#import "SDKBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CurrentLoginInfoView : SDKBaseView

- (instancetype)initWithLoginType:(NSInteger)mLoginType;

@end

NS_ASSUME_NONNULL_END
