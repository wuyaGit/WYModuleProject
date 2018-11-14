//
//  WYAnalyticsConfigManager.m
//  WYModule
//
//  Created by mac on 2018/11/14.
//

#import "WYAnalyticsConfigManager.h"

@implementation WYAnalyticsConfigManager

+ (WYAnalyticsConfigManager *)sharedInstance {
    static WYAnalyticsConfigManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WYAnalyticsConfigManager new];
    });
    return instance;
}

@end
