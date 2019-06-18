//
//  WYJPushConfigManager.m
//  WYModule
//
//  Created by Highden on 2019/6/18.
//

#import "WYJPushConfigManager.h"

@implementation WYJPushConfigManager

+ (WYJPushConfigManager *)sharedInstance {
    static WYJPushConfigManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WYJPushConfigManager new];
    });
    return instance;
}

@end
