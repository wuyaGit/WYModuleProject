//
//  WYAppDelegate.m
//  WYModule
//
//  Created by hero on 2018/11/14.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import "WYAppDelegate.h"
#import "SYSafeCategory.h"

@implementation WYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //是否开始日志记录功能
    if([WYCoreConfigManager sharedInstance].isRecordlogger)
    {
        NSLog(@"成功加载日志记录模块");
        [WYFileLogger sharedManager];
    }
    
    //是否开启查看屏幕帧数工具
    if ([WYCoreConfigManager sharedInstance].isOpenFPS)
    {
        NSLog(@"成功加载查看屏幕帧率模块");
        [WYFPSHelper setupInView:self.window];
    }
    
    //调试插件功能
    if([WYCoreConfigManager sharedInstance].isOpenDebug)
    {
        NSLog(@"成功开启调试插件功能");
        [[FLEXManager sharedManager] showExplorer];
    }
    
    //统一处理一些为数组、集合等对nil插入会引起闪退
    [SYSafeCategory callSafeCategory];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
}

- (void)dealloc {
}

@end
