//
//  WYPayConfigManager.m
//  WYModule
//
//  Created by hero on 2018/11/15.
//

#import "WYPayConfigManager.h"

@implementation WYPayConfigManager

+ (WYPayConfigManager *)sharedInstance {
    static WYPayConfigManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WYPayConfigManager new];
    });
    return instance;
}

@end
