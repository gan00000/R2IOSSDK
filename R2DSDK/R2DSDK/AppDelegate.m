//
//  AppDelegate.m
//  R2DSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "AppDelegate.h"
#import "login/R2DLoginViewController.h"
#import "ViewController.h"
#import "R2SDKPlat.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL handled = [[R2SDKPlat shareR2SDK] application:application openURL:url options:options];
    // Add any custom logic here.
    return handled;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    NSLog(@"UIScreen mainScreen --- height:%f,with:%f",  [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
    
    NSLog(@"UIScreen applicationFrame --- height:%f,with:%f",  [[UIScreen mainScreen] applicationFrame].size.height, [[UIScreen mainScreen] applicationFrame].size.width);
    // Override point for customization after application launch.
    ViewController *viewController = [[ViewController alloc] init];
    self.window.rootViewController = viewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [[R2SDKPlat shareR2SDK] application:application didFinishLaunchingWithOptions:launchOptions];
    NSString *googleClientId = @"113678359411-jnvdc3e59persg70227kkunqqedtqv9g.apps.googleusercontent.com";
//    [[R2GoogleHelper sharedInstance] initWithGoogleSignInClientId:googleClientId];
//    [[R2GoogleSignInHelper sharedInstance] initWithGoogleSignInClientId:googleClientId];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
     [[R2SDKPlat shareR2SDK] applicationWillTerminate:application];
}


@end
