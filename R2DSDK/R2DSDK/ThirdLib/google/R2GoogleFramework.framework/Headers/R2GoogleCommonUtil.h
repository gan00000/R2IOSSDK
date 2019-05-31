//
//  R2GoogleCommonUtil.h
//
//  Created by LUXING on 2019/5/7.
//  Copyright © 2019 LUXING. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface R2GoogleCommonUtil : NSObject

+(NSBundle*)getSDKBundle;

+(UIViewController *)getCurrentVC;

+(void)printLog:(NSString *)string;

@end

