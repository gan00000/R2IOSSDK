#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "R2SDKApi.h"


typedef void (^R2GcLoginInGameCompletionHandler)(BOOL isSuccessful,NSString* msg,NSDictionary* playerData);

@interface R2GCLoginHelper:NSObject<UIAlertViewDelegate>

@property BOOL isPlayerLoggedIn;

@property GKLocalPlayer* localPlayer;

@property UIViewController* topViewController;

@property BOOL isLoggingWithGC;

@property BOOL hasLoginWithGCFailedBefore;


@property BOOL isDialogShowing;

@property BOOL isDialogAlreadyShowed;


@property UIAlertView *alert;

@property UIViewController* gameCenterLoginVC;


-(id)init;

-(void)doGameCenterLoginFromViewController:(UIViewController*)viewController completionHandler:(R2GcLoginInGameCompletionHandler)handler;

+(R2GCLoginHelper*)sharedInstance;

@end
