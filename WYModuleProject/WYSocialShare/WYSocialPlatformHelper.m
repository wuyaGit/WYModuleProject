//
//  WYSocialPlatformHelper.m
//  WYModule
//
//  Created by hero on 2018/11/14.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import "WYSocialPlatformHelper.h"
#import <UMShare/UMShare.h>

@implementation WYSocialPlatformHelper

+ (UMSocialPlatformType)getUMSocialPlatformTypeByWYSocialPlatformType:(WYSocialPlatformType)platformType {
    UMSocialPlatformType umPlatformType = UMSocialPlatformType_UnKnown;
    switch (platformType) {
        case WYSocialPlatformType_QQ:
            umPlatformType = UMSocialPlatformType_QQ;
            break;
        case WYSocialPlatformType_Sina:
            umPlatformType = UMSocialPlatformType_Sina;
            break;
        case WYSocialPlatformType_Qzone:
            umPlatformType = UMSocialPlatformType_Qzone;
            break;
        case WYSocialPlatformType__UnKnown:
            umPlatformType = UMSocialPlatformType_UnKnown;
            break;
        case WYSocialPlatformType_WechatSession:
            umPlatformType = UMSocialPlatformType_WechatSession;
            break;
        case WYSocialPlatformType_WechatTimeLine:
            umPlatformType = UMSocialPlatformType_WechatTimeLine;
            break;
            
        default:
            umPlatformType = UMSocialPlatformType_UnKnown;
            break;
    }
    return umPlatformType;
}


+ (BOOL)installPlatAppWithType:(WYSocialPlatformType)platformType {
    BOOL result = NO;
    result = [[UMSocialManager defaultManager] isInstall:[self getUMSocialPlatformTypeByWYSocialPlatformType:platformType]];
    return result;
}

+ (void)authWithPlatform:(WYSocialPlatformType)platformType completion:(WYSocialAutoCompletionHandler)completion {
    [[UMSocialManager defaultManager] authWithPlatform:[self getUMSocialPlatformTypeByWYSocialPlatformType:platformType] currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialAuthResponse *authResponse = result;
        if (completion) {
            completion(authResponse.uid, authResponse.openid, authResponse.accessToken, error);
        }
    }];
}

+ (void)cancelAuthWithPlatform:(WYSocialPlatformType)platformType completion:(WYCancelSocialAutoCompletionHandler)completion {
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:[self getUMSocialPlatformTypeByWYSocialPlatformType:platformType] completion:^(id result, NSError *error) {
        if (completion) {
            completion(result, error);
        }
    }];
}

+ (void)getUserInfoWithPlatform:(WYSocialPlatformType)platformType completion:(WYSocialGetUserInfoCompletionHandler)completion {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:[self getUMSocialPlatformTypeByWYSocialPlatformType:platformType] currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userResponse = result;
        if (completion) {
            completion(userResponse.name, userResponse.iconurl, userResponse.gender, error);
        }
    }];
}

@end
