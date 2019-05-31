//
//  R2GoogleSignInHelper.h
//
//  Created by LUXING on 2019/5/7.
//  Copyright © 2019 LUXING. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleSignIn/GoogleSignIn.h>

typedef void (^GoogleSignInCompletionHandler)(int code,NSString* msg,NSDictionary* result);

@interface R2GoogleSignInHelper : NSObject<GIDSignInDelegate>

@property (atomic,copy) NSString* googleClientId;
@property GoogleSignInCompletionHandler signInCompletionHandler;

+(id)sharedInstance;

-(void)initWithGoogleSignInClientId:(NSString*)clientId;
-(BOOL)handleURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

-(void)signFromViewController:(UIViewController*)viewController onCompletionHandler:(GoogleSignInCompletionHandler)handler;

-(void)signOut;

@end

