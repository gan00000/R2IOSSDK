//
//  UIUtil.m
//  CCSkyHourSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "UIUtil.h"
#import "CCSkyHourHeader.h"
#import "CCSkyHourSDKPlat.h"

@implementation UIUtil

#pragma mark - UI

+ (UIButton *)initBtnWithNormalImage:(NSString *)normalImageName
                    highlightedImage:(NSString *)highlightedImageName
                                 tag:(NSUInteger)tag
                            selector:(SEL)selector
                              target:(id)target
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:GetImage(normalImageName) forState:UIControlStateNormal];
    [btn setImage:GetImage(highlightedImageName) forState:UIControlStateHighlighted];
    [btn setTag:tag];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

+ (UIButton *)initBtnWithTitle:(NSString *)titleText
                           tag:(NSUInteger)tag
                      selector:(SEL)selector
                        target:(id)target
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:titleText forState:0];
    [btn setTitleColor:[UIColor blackColor] forState:0];
    [btn setTag:tag];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn.layer setBorderWidth:1.5f];
    [btn.layer setBorderColor:[UIColor grayColor].CGColor];
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:5.0f];
    
    return btn;
}

+ (UIButton *)initBtnWithTitle2:(NSString *)titleText
                           tag:(NSUInteger)tag
                      selector:(SEL)selector
                        target:(id)target
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:titleText forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor colorWithHexString:@"#777777"] forState:0];
    [btn setTag:tag];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    //[btn.layer setBorderWidth:1.5f];
    //[btn.layer setBorderColor:[UIColor grayColor].CGColor];
   // [btn.layer setMasksToBounds:YES];
    //[btn.layer setCornerRadius:5.0f];
    
    return btn;
}


+(void)showAlertTips:(UIViewController *)viewController msg:(NSString *)msg
{
    UIAlertController *mAlert = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //响应事件
                                                              NSLog(@"action = %@", action);
                                                          }];
    [mAlert addAction:defaultAction];
    if (viewController) {
        [viewController presentViewController:mAlert animated:YES completion:nil];
    }else
    {
        [hillTopViewController presentViewController:mAlert animated:YES completion:nil];
    }
    
}

+(void)showAlertTips:(UIViewController *)viewController msg:(NSString *)msg okHandler:(void (^ __nullable)(UIAlertAction *action))handler
{
    UIAlertController *mAlert = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:handler];
    [mAlert addAction:defaultAction];
    if (viewController) {
        [viewController presentViewController:mAlert animated:YES completion:nil];
    }else
    {
         [hillTopViewController presentViewController:mAlert animated:YES completion:nil];
    }
   
}


+(UIViewController *)getSDKController
{
//    if ([R2SDKPlat shareR2SDK].sdkPresentedVC) {
//        return [R2SDKPlat shareR2SDK].sdkPresentedVC;
//    }else
//    {
//      return  [GamaFunction getCurrentViewController];
//    }
    
     return  [CCSkyHourFunction getCurrentViewController];
}


@end
