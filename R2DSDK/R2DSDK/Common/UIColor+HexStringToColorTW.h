//
//  UIColor+HexStringToColor.h
//  UIKitExample
//
//  Created by TangTieshan on 15/9/23.
//  Copyright (c) 2015年 TangTieshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexStringToColorTW)
/**
 *  将十六进制颜色转化为UIColor
 *
 *  @param color 十六进制字符串
 *
 *  @return UIColor对象
 */
+ (UIColor *)colorWithHexString: (NSString *)color;


+ (UIColor *) colorWithHexString: (NSString *)color andAlpha:(CGFloat)alpha;

@end
