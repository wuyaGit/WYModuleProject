//
//  XAspect-JPushAppDelegate.m
//  WYModule 抽离原本应在AppDelegate的内容（极光推送）
//
//  Created by Highden on 2019/6/18.
//

#import <Foundation/Foundation.h>
#import <XAspect/XAspect.h>
#import "WYJPushConfigManager.h"
#import "WYAppDelegate+JPush.h"

// 引入 JPush 功能所需头文件
#import <JPush/JPUSHService.h>
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

#define AtAspect JPushAppDelegate

#define AtAspectOfClass WYAppDelegate
@classPatchField(WYAppDelegate)

@synthesizeNucleusPatch(Default, -, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions);
@synthesizeNucleusPatch(Default, -, void, application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken);
@synthesizeNucleusPatch(Default, -, void, application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error);
@synthesizeNucleusPatch(Default, -, void, application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler);
@synthesizeNucleusPatch(Default, -, void, application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo);
@synthesizeNucleusPatch(Default, -, void, dealloc);

AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    NSLog(@"成功加载极光推送模块");
    
    //初始化
    [self initJPushWithOptions:launchOptions];
    
    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
}

// 注册 APNs 成功并上报 DeviceToken
AspectPatch(-, void, application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken) {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    
    NSLog(@"\n>>>[DeviceToken值]:%@\n\n", deviceToken);
    
    return XAMessageForward(application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken);
}

// 实现注册 APNs 失败接口（可选）
AspectPatch(-, void, application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error) {
    //Optional
    NSLog(@"\n>>>[DeviceToken失败]:%@\n\n", error.description);
    
    return XAMessageForward(application:application didFailToRegisterForRemoteNotificationsWithError:error);
}

// APP已经接收到“远程”通知(推送) - 透传推送消息
AspectPatch(-, void, application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler) {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    return XAMessageForward(application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler);
}

AspectPatch(-, void, application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo) {
    
    // Required, For systems with less than or equal to iOS 6
    [JPUSHService handleRemoteNotification:userInfo];
    return XAMessageForward(application:application didReceiveRemoteNotification:userInfo);
}

AspectPatch(-, void, dealloc)
{
    XAMessageForwardDirectly(dealloc);
}

#pragma mark- JPUSHRegisterDelegate

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_12_0
// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0)){
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}
#endif

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }else {
        // 本地通知
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }else {
        // 本地通知
    }
    completionHandler();  // 系统要求执行这个方法
}
#endif

#pragma mark - 初始化极光推送

- (void)initJPushWithOptions:(NSDictionary *)launchOptions {
    //初始化 APNs 代码
    [self registerForRemoteNotification];
    
    //初始化 JPush 代码
    // Optional
    // 获取 IDFA
    // 如需使用 IDFA 功能请添加此代码并在初始化方法的 advertisingIdentifier 参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    [JPUSHService setupWithOption:launchOptions appKey:[WYJPushConfigManager sharedInstance].appKey
                          channel:[WYJPushConfigManager sharedInstance].channel
                 apsForProduction:[WYJPushConfigManager sharedInstance].isProduction
            advertisingIdentifier:advertisingId];
}

//初始化 APNs
- (void)registerForRemoteNotification {
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
}

@end
#undef AtAspectOfClass
#undef AtAspect
