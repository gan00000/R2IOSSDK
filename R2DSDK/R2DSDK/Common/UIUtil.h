//
//  UIUtil.h
//  CCSkyHourSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIUtil : NSObject


#pragma mark - UI

+ (UIButton *)initBtnWithNormalImage:(NSString *)normalImageName
                    highlightedImage:(NSString *)highlightedImageName
                                 tag:(NSUInteger)tag
                            selector:(SEL)selector
                              target:(id)target;

+ (UIButton *)initBtnWithTitle:(NSString *)titleText
                           tag:(NSUInteger)tag
                      selector:(SEL)selector
                        target:(id)target;
+ (UIButton *)initBtnWithTitle2:(NSString *)titleText
     tag:(NSUInteger)tag
selector:(SEL)selector
  target:(id)target;

+(void)showAlertTips:(UIViewController *)viewController msg:(NSString *)msg;
+(void)showAlertTips:(UIViewController *)viewController msg:(NSString *)msg okHandler:(void (^ __nullable)(UIAlertAction *action))handler;

+(UIViewController *)getSDKController;

@end

NS_ASSUME_NONNULL_END
