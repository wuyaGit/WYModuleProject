//
//  XAspect-UMengPushAppDelegate.m
//  WYModule 抽离原本应在AppDelegate的内容（友盟推送）
//
//  Created by mac on 2019/2/15.
//

#import <Foundation/Foundation.h>
#import <XAspect/XAspect.h>
#import <UMCommon/UMCommon.h>
#import <UMCommonLog/UMCommonLogHeaders.h>
#import <UMPush/UMessage.h>
#import "WYUMengPushConfigManager.h"
#import "WYAppDelegate+uMengPush.h"

// iOS10 及以上需导入 UserNotifications.framework
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

#define AtAspect UMengPushAppDelegate

#define AtAspectOfClass WYAppDelegate
@classPatchField(WYAppDelegate)

@synthesizeNucleusPatch(Default, -, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions);
@synthesizeNucleusPatch(Default, -, void, application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSError *)error);
@synthesizeNucleusPatch(Default, -, void, application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error);
@synthesizeNucleusPatch(Default, -, void, application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings);
@synthesizeNucleusPatch(Default, -, void, application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler);
@synthesizeNucleusPatch(Default, -, void, dealloc);

AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    NSLog(@"成功加载友盟推送");
    //打开日志
    if ([WYUMengPushConfigManager sharedInstance].isLogEnabled) {
        //开发者需要显式的调用此函数，日志系统才能工作
        [UMCommonLogManager setUpUMCommonLogManager];
        [UMConfigure setLogEnabled:YES];
    }
    
    //配置友盟SDK产品并并统一初始化
    if ([WYUMengPushConfigManager sharedInstance].umengKey) {
        [UMConfigure initWithAppkey:[WYUMengPushConfigManager sharedInstance].umengKey channel:@"App Store"];
    }
    
    //初始化
    [self initUMengPushWithOptions:launchOptions];
    
    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
}

/** 远程通知注册成功委托 */
AspectPatch(-, void, application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken)
{
    NSLog(@"\n>>>[DeviceToken值]:%@\n\n", deviceToken);
    
    return XAMessageForward(application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken);
}

/** 远程通知注册失败委托 */
AspectPatch(-, void, application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error)
{
    NSLog(@"\n>>>[DeviceToken失败]:%@\n\n", error.description);
    
    return XAMessageForward(application:application didFailToRegisterForRemoteNotificationsWithError:error);
}

#pragma mark - 用户通知(推送)回调 _IOS 8.0以上使用

/** 已登记用户通知 */
AspectPatch(-, void, application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings)
{
    // 注册远程通知（推送）
    [application registerForRemoteNotifications];
    
    return XAMessageForward(application:application didRegisterUserNotificationSettings:notificationSettings);
}

/** APP已经接收到“远程”通知(推送) - 透传推送消息  */
AspectPatch(-, void, application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler)
{
    //处理applicationIconBadgeNumber-1
    [self handlePushMessage:userInfo notification:nil];
    
    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
    }
    // 处理APN
    //NSLog(@"\n>>>[Receive RemoteNotification - Background Fetch]:%@\n\n", userInfo);
    completionHandler(UIBackgroundFetchResultNewData);
    
    return XAMessageForward(application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler);
}

AspectPatch(-, void, dealloc)
{
    XAMessageForwardDirectly(dealloc);
}

#pragma mark - iOS 10中收到推送消息

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
//  iOS 10: App在前台获取到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)){
    
    NSLog(@"willPresentNotification：%@", notification.request.content.userInfo);
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
        //应用处于前台时的本地推送接受
    }
    // 根据APP需要，判断是否要提示用户Badge、Sound、Alert
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

//  iOS 10: 点击通知进入App时触发
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    
    NSLog(@"didReceiveNotification：%@", response.notification.request.content.userInfo);
    
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
        //应用处于后台时的本地推送接受
    }
    completionHandler();
}
#endif

#pragma mark - 初始化个推

//个推初始化
- (void)initUMengPushWithOptions:(NSDictionary *)launchOptions {
    // Push组件基本功能配置
    UMessageRegisterEntity *entity = [[UMessageRegisterEntity alloc] init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        }else{
        }
    }];
    
//    [UMessage openDebugMode:YES];
    [UMessage addLaunchMessage];
    // 注册 APNs
    [self registerRemoteNotification];
    
    // 处理远程通知启动APP
    [self receiveNotificationByLaunchingOptions:launchOptions];
}

// 注册 APNs
- (void)registerRemoteNotification {
    /*
     警告：Xcode8 需要手动开启"TARGETS -> Capabilities -> Push Notifications"
     */
    
    /*
     警告：该方法需要开发者自定义，以下代码根据 APP 支持的 iOS 系统不同，代码可以对应修改。
     以下为演示代码，注意根据实际需要修改，注意测试支持的 iOS 系统都能获取到 DeviceToken
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
        if (@available(iOS 10.0, *)) {
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            center.delegate = self;
            [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
                if (!error) {
                    NSLog(@"request authorization succeeded!");
                }
            }];
        } else {
            // Fallback on earlier versions
        }
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#else // Xcode 7编译会调用
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#endif
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
}

#pragma mark - 自定义方法

/** 自定义：APP被“推送”启动时处理推送消息处理（APP 未启动--》启动）*/
- (void)receiveNotificationByLaunchingOptions:(NSDictionary *)launchOptions {
    if (!launchOptions)
    return;
    
    /*
     通过“远程推送”启动APP
     UIApplicationLaunchOptionsRemoteNotificationKey 远程推送Key
     */
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        NSLog(@"\n>>>[Launching RemoteNotification]:%@", userInfo);
    }
}

// 处理推送消息
- (void) handlePushMessage:(NSDictionary *)dict notification:(UILocalNotification *)localNotification {
    if ([UIApplication sharedApplication].applicationIconBadgeNumber != 0) {
        if (localNotification) {
            [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
        }
        [UIApplication sharedApplication].applicationIconBadgeNumber -= 1;
    }else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    }
    
    //同步本地角标值到个推服务器
    [UMessage setBadgeClear:[UIApplication sharedApplication].applicationIconBadgeNumber];
}

@end
#undef AtAspectOfClass
#undef AtAspect
