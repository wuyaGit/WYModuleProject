//
//  XAspect-ShareAppDelegate.m
//  WYModule 抽离原本应在AppDelegate友盟分享内容
//
//  Created by hero on 2018/11/14.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XAspect/XAspect.h>
#import <UMCommon/UMCommon.h>
#import <UMCommonLog/UMCommonLogHeaders.h>
#import <UMShare/UMShare.h>

#import "WYAppDelegate.h"
#import "WYSocialConfigManager.h"

#define AtAspect ShareAppDelegate

#define AtAspectOfClass WYAppDelegate
@classPatchField(WYAppDelegate)

AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    NSLog(@"成功加载友盟分享");
    //打开日志
    if ([WYSocialConfigManager sharedInstance].isLogEnabled) {
        //开发者需要显式的调用此函数，日志系统才能工作
        [UMCommonLogManager setUpUMCommonLogManager];
        [UMConfigure setLogEnabled:YES];
    }
    
    //配置友盟SDK产品并并统一初始化
    if ([WYSocialConfigManager sharedInstance].shareAppKey) {
        [UMConfigure initWithAppkey:[WYSocialConfigManager sharedInstance].shareAppKey channel:@"App Store"];
    }
    
    //各平台的详细配置
    //分享-新浪平台已经配置
    if ([WYSocialConfigManager sharedInstance].sharePlatConfigType_Sina_AppKey &&
        [WYSocialConfigManager sharedInstance].sharePlatConfigType_Sina_AppSecret) {
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina
                                              appKey:[WYSocialConfigManager sharedInstance].sharePlatConfigType_Sina_AppKey
                                           appSecret:[WYSocialConfigManager sharedInstance].sharePlatConfigType_Sina_AppSecret
                                         redirectURL:[WYSocialConfigManager sharedInstance].sharePlatConfigType_Sina_RedirectURL];
    }
    
    //分享-微信平台已经配置
    if ([WYSocialConfigManager sharedInstance].sharePlatConfigType_Wechat_AppKey &&
        [WYSocialConfigManager sharedInstance].sharePlatConfigType_Wechat_AppSecret) {
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                              appKey:[WYSocialConfigManager sharedInstance].sharePlatConfigType_Wechat_AppKey
                                           appSecret:[WYSocialConfigManager sharedInstance].sharePlatConfigType_Wechat_AppSecret
                                         redirectURL:[WYSocialConfigManager sharedInstance].sharePlatConfigType_Wechat_RedirectURL];
    }

    //分享-QQ平台已经配置
    if ([WYSocialConfigManager sharedInstance].sharePlatConfigType_Tencent_AppKey &&
        [WYSocialConfigManager sharedInstance].sharePlatConfigType_Tencent_AppSecret) {
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                              appKey:[WYSocialConfigManager sharedInstance].sharePlatConfigType_Tencent_AppKey
                                           appSecret:[WYSocialConfigManager sharedInstance].sharePlatConfigType_Tencent_AppSecret
                                         redirectURL:[WYSocialConfigManager sharedInstance].sharePlatConfigType_Tencent_RedirectURL];
    }

    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
}

// 仅支持iOS9以上系统，iOS8及以下系统不会回调
AspectPatch(-, BOOL, application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options)
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

// 支持目前所有iOS系统
//AspectPatch(-, BOOL, application:(UIApplication *)application handleOpenURL:(NSURL *)url)
//{
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
//    if (!result) {
//        // 其他如支付等SDK的回调
//    }
//    return result;
//}

@end
#undef AtAspectOfClass
#undef AtAspect

