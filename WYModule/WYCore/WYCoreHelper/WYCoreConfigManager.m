//
//  WYCoreConfigManager.m
//  WYModule
//
//  Created by hero on 2018/11/14.
//

#import "WYCoreConfigManager.h"

@implementation WYCoreConfigManager

+ (WYCoreConfigManager *)sharedInstance
{
    static WYCoreConfigManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WYCoreConfigManager new];
    });
    
    return instance;
}

@end
