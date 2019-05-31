#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "R2FacebookLoginResult.h"
#import <R2SDKFramework/R2SDKFramework.h>


#define FACEBOOK_BIND_SUCCESS 0
#define FACEBOOK_BIND_FAILED -200
#define FACEBOOK_BIND_LOGIN_FAILED 1001

#define FACEBOOK_SWITCH_SUCCESS 0
#define FACEBOOK_SWITCH_FAILED 3000
#define FACEBOOK_SWITCH_LOGIN_FAILED 3001


typedef void(^R2FBBindHandler)(int code,NSString *msg,R2FacebookLoginResult *result);
typedef void(^R2FBSwitchHandler)(int code,NSString *msg,R2LoginResponse *result);

@interface R2FacebookMgrHelper : NSObject

@property(copy,atomic) NSString* currentFacebookUid;

+(id)sharedHelper;
-(void)bindFBWithViewController:(UIViewController *)viewController withReadPermissions:(NSArray *)permissions andR2UidToBeBound:(NSString*)r2uid completionHandler:(R2FBBindHandler)handler;


-(void)switchFBWithViewController:(UIViewController *)viewController withReadPermissions:(NSArray *)permissions enableCreateNewAccount:(BOOL)enable completionHandler:(R2FBSwitchHandler)handler;
-(void)switchFBWithViewController:(UIViewController *)viewController withReadPermissions:(NSArray*)permissions completionHandler:(R2FBSwitchHandler)handler;



-(void)logOut;

@end
