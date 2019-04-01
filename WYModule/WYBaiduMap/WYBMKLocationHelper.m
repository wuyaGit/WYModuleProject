//
//  WYBMKLocationHelper.m
//  WYModule
//
//  Created by mac on 2019/2/19.
//

#import "WYBMKLocationHelper.h"
#import "WYBMKConfigManager.h"

@interface WYBMKLocationHelper () <BMKLocationAuthDelegate, BMKLocationManagerDelegate>

@property (nonatomic, strong) BMKLocationManager *locationManager;
@property (nonatomic, copy) BMKLocatingCompletionBlock completionBlock;
@property (nonatomic, copy) WYBMKLocationBlock locationBlock;

@end

@implementation WYBMKLocationHelper

+ (WYBMKLocationHelper *)sharedInstance {
    static WYBMKLocationHelper* instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [WYBMKLocationHelper new];
    });
    
    return instance;
}

// 单次定位，每次定位时调用
- (void)startSingleLocationWithReg:(BMKLocatingCompletionBlock)completionBlock {
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:[WYBMKConfigManager sharedInstance].appKey authDelegate:self];
    
    [self.locationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:completionBlock];
}

// 开启连续定位
- (void)startBMKLocationWithReg:(WYBMKLocationBlock)locationBlock {
    self.locationBlock = locationBlock;

    // 设置是否允许后台定位
    self.locationManager.allowsBackgroundLocationUpdates = YES;
    // 如果需要持续定位返回地址信息（需要联网），请设置如下：
    [self.locationManager setLocatingWithReGeocode:YES];
    // 开启持续定位
    [self.locationManager startUpdatingLocation];
}

// 停止连续定位
- (void)stopBMKLocation {
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - BMKLocationAuthDelegate

- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError {
    if (iError == 0) {
        NSLog(@"授权成功");
    }else{
        NSLog(@"授权错误码:%ld", iError);
    }
}

#pragma mark - BMKLocationManagerDelegate

// 设备朝向改变调用
- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateHeading:(CLHeading *)heading {
    NSLog(@"设备方向改变了");
}

// 连续定位回调函数
- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateLocation:(BMKLocation *)location orError:(NSError *)error {
    if (error)
    {
        NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
    } if (location) {//得到定位信息，添加annotation
        if (location.location) {
            NSLog(@"LOC = %@",location.location);
        }
        if (location.rgcData) {
            NSLog(@"rgc = %@",[location.rgcData description]);
        }
        
        self.locationBlock(location, nil);
    }
}

// 当定位发生错误时调用
- (void)BMKLocationManager:(BMKLocationManager *)manager didFailWithError:(NSError *)error {
    [self.locationManager stopUpdatingLocation];
    
    self.locationBlock(nil, error);
}

// 定位权限状态改变时回调
- (void)BMKLocationManager:(BMKLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
}

// App系统网络状态改变的回调
- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateNetworkState:(BMKLocationNetworkState)state orError:(NSError *)error {
    
}

#pragma mark - getter & setter

- (BMKLocationManager *)locationManager {
    if (!_locationManager) {
        //初始化实例
        _locationManager = [[BMKLocationManager alloc] init];
        //设置delegate
        _locationManager.delegate = self;
        //设置返回位置的坐标系类型
        _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
        //设置距离过滤参数
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        //设置预期精度参数
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //设置应用位置类型
        _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
        //设置是否自动停止位置更新
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        //设置是否允许后台定位
        //_locationManager.allowsBackgroundLocationUpdates = YES;
        //设置位置获取超时时间
        _locationManager.locationTimeout = 10;
        //设置获取地址信息超时时间
        _locationManager.reGeocodeTimeout = 10;
    }
    return _locationManager;
}

@end
