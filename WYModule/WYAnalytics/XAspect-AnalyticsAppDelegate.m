//
//  XAspect-AnalyticsAppDelegate.m
//  WYModule
//
//  Created by mac on 2018/11/14.
//

#import <Foundation/Foundation.h>
#import <XAspect/XAspect.h>
#import <UMCommon/UMCommon.h>
#import <UMCommonLog/UMCommonLogHeaders.h>
#import <UMAnalytics/MobClick.h>

#import "WYAppDelegate.h"
#import "WYAnalyticsConfigManager.h"


#define AtAspect ShareAppDelegate

#define AtAspectOfClass WYAppDelegate
@classPatchField(WYAppDelegate)

AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    NSLog(@"成功加载友盟统计");

    //打开日志
    if ([WYAnalyticsConfigManager sharedInstance].isLogEnabled) {
        //开发者需要显式的调用此函数，日志系统才能工作
        [UMCommonLogManager setUpUMCommonLogManager];
        [UMConfigure setLogEnabled:YES];
    }
    
    //配置友盟SDK产品并并统一初始化
    if ([WYAnalyticsConfigManager sharedInstance].analyticsAppKey) {
        [UMConfigure initWithAppkey:[WYAnalyticsConfigManager sharedInstance].analyticsAppKey channel:[WYAnalyticsConfigManager sharedInstance].analyticsChannelID];
    }
    
    [MobClick setCrashReportEnabled:[WYAnalyticsConfigManager sharedInstance].bCrashReportEnabled];
    
    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
}

@end
#undef AtAspectOfClass
#undef AtAspect
