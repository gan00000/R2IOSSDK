//
//  R2GoogleHelper.h
//
//  Created by LUXING on 2019/5/9.
//  Copyright © 2019 LUXING. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <R2SDKFramework/R2SDKFramework.h>

typedef void (^GoogleApiCompletionHandler)(int code,NSString* msg,R2LoginResponse* loginResponse,NSDictionary* result);

@interface R2GoogleHelper : NSObject

@property(atomic) UIViewController *topVC;


@property GoogleApiCompletionHandler loginCompletionHandler;
@property GoogleApiCompletionHandler bindCompletionHandler;
@property GoogleApiCompletionHandler switchCompletionHandler;

+(id)sharedInstance;

/* must be called from the application:didFinishLaunchingWithOptions: method of the AppDelegate */
-(void)initWithGoogleSignInClientId:(NSString*)clientId;
/* must be called from the application:openURL:options: method of the AppDelegate */
-(BOOL)handleURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

-(void)loginFromViewController:(UIViewController*)viewController onCompletionHandler:(GoogleApiCompletionHandler)handler;
-(void)bindFromViewController:(UIViewController*)viewController withR2Uid:(NSString*)r2uid  onCompletionHandler:(GoogleApiCompletionHandler)handler;
-(void)switchFromViewController:(UIViewController*)viewController enableCreateNewAccount:(BOOL)enable onCompletionHandler:(GoogleApiCompletionHandler)handler;

@end

