//
//  XAspect-GeTuiAppDelegate.m
//  WYModule 抽离原本应在AppDelegate的内容（个推）
//
//  Created by hero on 2018/11/15.
//

#import <Foundation/Foundation.h>
#import <GTSDK/GeTuiSdk.h>      // GetuiSdk头文件应用
#import <XAspect/XAspect.h>
#import "WYGTConfigManager.h"
#import "WYAppDelegate+myGT.h"

// iOS10 及以上需导入 UserNotifications.framework
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

#define AtAspect GeTuiAppDelegate

#define AtAspectOfClass WYAppDelegate
@classPatchField(WYAppDelegate)

@synthesizeNucleusPatch(Default, -, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions);
@synthesizeNucleusPatch(Default, -, void, application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo);
@synthesizeNucleusPatch(Default, -, void, application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error);
@synthesizeNucleusPatch(Default, -, void, application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings);
@synthesizeNucleusPatch(Default, -, void, application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler);
@synthesizeNucleusPatch(Default, -, void, dealloc);

AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    NSLog(@"成功加载个推模块");
    
    //个推初始化
    [self initGeTuiWithOptions:launchOptions];

    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
}

/** 远程通知注册成功委托 */
AspectPatch(-, void, application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken)
{
    // [3]:向个推服务器注册deviceToken 为了方便开发者，建议使用新方法
    [GeTuiSdk registerDeviceTokenData:deviceToken];
    
    NSLog(@"\n>>>[DeviceToken值]:%@\n\n", deviceToken);

    return XAMessageForward(application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken);
}

/** 远程通知注册失败委托 */
AspectPatch(-, void, application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error)
{
    [GeTuiSdk registerDeviceToken:@""];
    
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
    
    //除了个推还要处理走苹果的信息放在body里面
    if (userInfo) {
        NSString *payloadMsg = [userInfo objectForKey:@"payload"];
        NSString *message=[[[userInfo objectForKey:@"aps"]objectForKey:@"alert"]objectForKey:@"body"];
        
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:payloadMsg,@"payload",message,@"message",nil];
        
        //处理苹果远程通知，判断是否存在receiveRemoteNotification方法
        [self receiveRemoteMessageHandleing:dict];
    }
    
    // 将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:userInfo];
    
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
    
    // 根据APP需要，判断是否要提示用户Badge、Sound、Alert
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

//  iOS 10: 点击通知进入App时触发
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    
    NSLog(@"didReceiveNotification：%@", response.notification.request.content.userInfo);
    
    NSDictionary *userInfo = [[NSDictionary alloc]init];
    userInfo = response.notification.request.content.userInfo;
    if (userInfo) {
        NSString *payloadMsg = [userInfo objectForKey:@"payload"];
        NSString *message=[[[userInfo objectForKey:@"aps"]objectForKey:@"alert"]objectForKey:@"body"];
        
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:payloadMsg,@"payload",message,@"message",nil];
        
        //处理苹果远程通知，判断是否存在receiveRemoteNotification方法
        [self receiveRemoteMessageHandleing:dict];
    }
    
    // [ GTSdk ]：将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:response.notification.request.content.userInfo];
    
    completionHandler();
}
#endif

#pragma mark - GeTuiSdkDelegate

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    // [4-EXT-1]: 个推SDK已注册，返回clientId
    NSLog(@"\n>>>[个推Cid]:%@\n\n", clientId);
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}

/** SDK收到sendMessage消息回调 */
- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result {
    // [4-EXT]:发送上行消息结果反馈
    NSString *msg = [NSString stringWithFormat:@"sendmessage=%@,result=%d", messageId, result];
    NSLog(@"\n>>>[GexinSdk DidSendMessage]:%@\n\n", msg);
}

/** SDK运行状态通知 */
- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus {
    // [EXT]:通知SDK运行状态
    NSLog(@"\n>>>[GexinSdk SdkState]:%u\n\n", aStatus);
}

/** SDK设置推送模式回调 */
- (void)GeTuiSdkDidSetPushMode:(BOOL)isModeOff error:(NSError *)error {
    if (error) {
        NSLog(@"\n>>>[GexinSdk SetModeOff Error]:%@\n\n", [error localizedDescription]);
        return;
    }
    
    NSLog(@"\n>>>[GexinSdk SetModeOff]:%@\n\n", isModeOff ? @"开启" : @"关闭");
}

/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    
    [self handlePushMessage:nil notification:nil];
    
    // 数据转换
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:msgId,@"aMsgId", [NSNumber numberWithBool:offLine],@"offLine",appId,@"appId",payloadMsg,@"payload",nil];
    
    [self geTuiMessageHandleing:dict];
}

#pragma mark - 初始化个推

//个推初始化
- (void)initGeTuiWithOptions:(NSDictionary *)launchOptions {
    // 通过个推平台分配的appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:[WYGTConfigManager sharedInstance].wyGTAppId
                         appKey:[WYGTConfigManager sharedInstance].wyGTAppKey
                      appSecret:[WYGTConfigManager sharedInstance].wyGTAppSecret delegate:self];
    
    // 注册 APNs
    [self registerRemoteNotification];
    
    // 处理远程通知启动APP
    [self receiveNotificationByLaunchingOptions:launchOptions];

    //个推SDK支持当APP进入后台后，个推是否运行。NO是不允许(为了让个APP进入后端时就直接走苹果推送)
    [GeTuiSdk runBackgroundEnable:NO];
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
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
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
    [GeTuiSdk setBadge:[UIApplication sharedApplication].applicationIconBadgeNumber];
}

//处理苹果远程通知，判断是否存在receiveRemoteNotification方法
- (void)receiveRemoteMessageHandleing:(NSDictionary *)dic{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    SEL receiveRemoteNotificationSelector = @selector(receiveRemoteNotification:);
    if([self respondsToSelector:receiveRemoteNotificationSelector])
    {
        [self performSelector:receiveRemoteNotificationSelector withObject:dic];
    }
#pragma clang diagnostic pop
}

//处理个推本地通知，判断是否存在gtNotification方法
- (void)geTuiMessageHandleing:(NSDictionary *)dic{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    SEL gtNotificationSelector = @selector(gtNotification:);
    if([self respondsToSelector:gtNotificationSelector])
    {
        [self performSelector:gtNotificationSelector withObject:dic];
    }
#pragma clang diagnostic pop
}


@end
#undef AtAspectOfClass
#undef AtAspect


