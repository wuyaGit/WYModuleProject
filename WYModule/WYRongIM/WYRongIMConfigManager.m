//
//  WYRongIMConfigManager.m
//  WYModule
//
//  Created by mac on 2019/2/17.
//

#import "WYRongIMConfigManager.h"

@implementation WYRongIMConfigManager

+ (WYRongIMConfigManager *)sharedInstance {
    static WYRongIMConfigManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WYRongIMConfigManager new];
    });
    return instance;
}

@end
