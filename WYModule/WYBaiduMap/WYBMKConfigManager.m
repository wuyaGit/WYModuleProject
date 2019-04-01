//
//  WYBMKConfigManager.m
//  WYModule
//
//  Created by mac on 2019/2/19.
//

#import "WYBMKConfigManager.h"

@implementation WYBMKConfigManager

+ (WYBMKConfigManager *)sharedInstance {
    static WYBMKConfigManager* instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [WYBMKConfigManager new];
    });
    
    return instance;
}

+ (void)installMapSDKWithAppKey:(NSString *)appKey {
    // 要使用百度地图，请先启动BaiduMapManager
    BMKMapManager *mapManager = [[BMKMapManager alloc] init];
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
    BOOL ret = [mapManager start:appKey  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    WYBMKConfigManager *config = [WYBMKConfigManager sharedInstance];
    config.appKey = appKey;
    config.mapManager = mapManager;
}


@end
