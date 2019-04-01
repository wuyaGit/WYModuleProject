//
//  XAspect-RongIMAppDelegate.m
//  WYModule
//
//  Created by mac on 2019/2/17.
//

#import <Foundation/Foundation.h>
#import <XAspect/XAspect.h>
#import <RongIMKit/RongIMKit.h>

#import "WYAppDelegate+rongIM.h"
#import "WYRongIMConfigManager.h"

#define AtAspect RongIMAppDelegate

#define AtAspectOfClass WYAppDelegate
@classPatchField(WYAppDelegate)

@synthesizeNucleusPatch(Default, -, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions);
@synthesizeNucleusPatch(Default, -, BOOL, application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options);
@synthesizeNucleusPatch(Default, -, BOOL, application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler);
@synthesizeNucleusPatch(Default, -, void, dealloc);

AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    NSLog(@"成功加载融云即时通讯");

    [[RCIM sharedRCIM] initWithAppKey:[WYRongIMConfigManager sharedInstance].rongIMAppKey];
    [RCIM sharedRCIM].userInfoDataSource = self;
    [RCIM sharedRCIM].groupInfoDataSource = self;
    [RCIM sharedRCIM].enableMessageAttachUserInfo = NO; //发送消息就不会携带用户信息了
    //    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES; //获取到的用户信息持久化存储在本地
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];

    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, iOS 8
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveMessageNotification:)
                                                 name:RCKitDispatchMessageNotification
                                               object:nil];

    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
}

AspectPatch(-, void, dealloc)
{
    XAMessageForwardDirectly(dealloc);
}

#pragma mark - RCIMConnectionStatusDelegate

- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的帐号在别的设备上登录，您被迫下线！" preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];
//        [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
//        [[UMUserSingletion sharedInstance] clearUserForUserDeatult];
//        [[RCIMClient sharedRCIMClient] logout];
//        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//
//        [[UMUserSingletion sharedInstance] clearUserForUserDeatult];
//        [self applicationResetRootViewController];
    }
}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    //    [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
    
    if ([notification.object isKindOfClass:[RCMessage class]] && ((RCMessage *)notification.object).conversationType == ConversationType_PRIVATE) {
        RCMessage *message = notification.object;
        
        if (message.conversationType == ConversationType_PRIVATE) {
//            [[UMMessageViewModel new] senderIM_user_infoWith:nil uid:message.senderUserId completion:^(NSString *uid, NSString *name, NSString *portrait) {
//                RCUserInfo *userInfo = [[RCUserInfo alloc] initWithUserId:uid name:name portrait:portrait];
//                [[RCIM sharedRCIM] refreshUserInfoCache:userInfo withUserId:message.senderUserId];
//            }];
        }else if (message.conversationType == ConversationType_GROUP) {
//            [[UMMessageViewModel new] senderIM_group_infoWith:nil gid:message.targetId completion:^(NSString *gid, NSString *groupName, NSString *portraitUri) {
//                RCGroup *groupInfo = [[RCGroup alloc] initWithGroupId:gid groupName:groupName portraitUri:portraitUri?portraitUri:@"msg_icon_team"];
//                [[RCIM sharedRCIM] refreshGroupInfoCache:groupInfo withGroupId:message.targetId];
//            }];
        }
    }
}

#pragma mark RCIMUserInfoDataSource & RCIMGroupInfoDataSource

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
    if (userId == nil || userId.length == 0) {
        completion(nil);
        return;
    }
    
    if ([userId isEqualToString:[RCIM sharedRCIM].currentUserInfo.userId]) {
//        RCUserInfo *userInfo = [[RCUserInfo alloc] init];
//        userInfo.userId = userId;
//        userInfo.name = [UMUserSingletion sharedInstance].nickname;
//        userInfo.portraitUri = [UMUserSingletion sharedInstance].avatar;
//        completion(userInfo);
    }else {
//        [[UMMessageViewModel new] senderIM_user_infoWith:nil uid:userId completion:^(NSString *uid, NSString *name, NSString *portrait) {
//            RCUserInfo *userInfo = [[RCUserInfo alloc] initWithUserId:uid name:name portrait:portrait];
//            completion(userInfo);
//        }];
    }
}

- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *))completion {
    if (groupId == nil || groupId.length == 0) {
        completion(nil);
        return;
    }
    
//    [[UMMessageViewModel new] senderIM_group_infoWith:nil gid:groupId completion:^(NSString *gid, NSString *groupName, NSString *portraitUri) {
//        RCGroup *groupInfo = [[RCGroup alloc] initWithGroupId:gid groupName:groupName portraitUri:portraitUri?portraitUri:@"msg_icon_team"];
//        completion(groupInfo);
//    }];
}


@end
#undef AtAspectOfClass
#undef AtAspect
