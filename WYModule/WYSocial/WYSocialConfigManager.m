//
//  WYSocialConfigManager.m
//  WYModule
//
//  Created by hero on 2018/11/14.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import "WYSocialConfigManager.h"

@implementation WYSocialConfigManager

+ (WYSocialConfigManager *)sharedInstance {
    static WYSocialConfigManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WYSocialConfigManager new];
    });
    return instance;
}

- (void)setPlatform:(WYSocialSharePlatConfigType)platformType
             appKey:(NSString *)appKey
          appSecret:(NSString *)appSecret
        redirectURL:(NSString *)redirectURL {
    switch (platformType) {
        case WYSocialSharePlatConfigType_Sina:
            self.sharePlatConfigType_Sina_AppKey = appKey;
            self.sharePlatConfigType_Sina_AppSecret = appSecret;
            self.sharePlatConfigType_Sina_RedirectURL = redirectURL;
            break;
        case WYSocialSharePlatConfigType_Wechat :
            self.sharePlatConfigType_Wechat_AppKey = appKey;
            self.sharePlatConfigType_Wechat_AppSecret = appSecret;
            self.sharePlatConfigType_Wechat_RedirectURL = redirectURL;
            break;
        case WYSocialSharePlatConfigType_Tencent:
            self.sharePlatConfigType_Tencent_AppKey = appKey;
            self.sharePlatConfigType_Tencent_AppSecret = appSecret;
            self.sharePlatConfigType_Tencent_RedirectURL = redirectURL;
            break;
        default:
            break;
    }
}

@end
