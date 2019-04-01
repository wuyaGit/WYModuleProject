//
//  WYAppDelegate+uMengPush.h
//  WYModule
//
//  Created by mac on 2019/2/15.
//

#import "WYAppDelegate.h"

// iOS10 及以上需导入 UserNotifications.framework
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

NS_ASSUME_NONNULL_BEGIN

/// iOS 10 及以上环境，需要添加 UNUserNotificationCenterDelegate 协议，才能使用 UserNotifications.framework 的回调
@interface WYAppDelegate (uMengPush)<UNUserNotificationCenterDelegate>

@end

NS_ASSUME_NONNULL_END
