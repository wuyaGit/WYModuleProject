//
//  WYAppDelegate+rongIM.h
//  WYModule
//
//  Created by mac on 2019/2/17.
//

#import "WYAppDelegate.h"
#import <RongIMKit/RongIMKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYAppDelegate (rongIM) <RCIMConnectionStatusDelegate, RCIMUserInfoDataSource, RCIMGroupInfoDataSource>

@end

NS_ASSUME_NONNULL_END
