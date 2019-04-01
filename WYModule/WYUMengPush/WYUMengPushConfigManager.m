//
//  WYUMengPushConfigManager.m
//  WYModule
//
//  Created by mac on 2019/2/15.
//

#import "WYUMengPushConfigManager.h"

@implementation WYUMengPushConfigManager

+ (WYUMengPushConfigManager *)sharedInstance {
    static WYUMengPushConfigManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WYUMengPushConfigManager new];
    });
    return instance;
}

@end
