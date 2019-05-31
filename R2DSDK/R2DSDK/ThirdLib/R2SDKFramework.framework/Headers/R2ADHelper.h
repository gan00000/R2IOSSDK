//
//  R2ADHelper.h
//  TestIAP
//
//  Created by 左细平 on 2016/11/2.
//  Copyright © 2016年 shycie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^R2ShowADCompletion) (BOOL isSuccessful , NSString *msg);
@interface R2ADHelper : NSObject

@property(nonatomic,assign)BOOL isUsersChoice;//用户是否选择：今天不再显示
+(instancetype)sharedHelper;
/**
 展示公告图片

 */
-(void)showADWithViewController:(UIViewController*)viewController completion:(R2ShowADCompletion)handler;


@end
