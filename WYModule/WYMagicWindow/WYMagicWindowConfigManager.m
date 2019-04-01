//
//  WYMagicWindowConfigManager.m
//  WYModule
//
//  Created by mac on 2019/2/17.
//

#import "WYMagicWindowConfigManager.h"

@implementation WYMagicWindowConfigManager

+ (WYMagicWindowConfigManager *)sharedInstance {
    static WYMagicWindowConfigManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WYMagicWindowConfigManager new];
    });
    return instance;
}

@end
