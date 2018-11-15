//
//  WYGTConfigManager.m
//  WYModule
//
//  Created by mac on 2018/11/14.
//

#import "WYGTConfigManager.h"

@implementation WYGTConfigManager

+ (WYGTConfigManager *)sharedInstance {
    static WYGTConfigManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WYGTConfigManager new];
    });
    return instance;
}

@end
