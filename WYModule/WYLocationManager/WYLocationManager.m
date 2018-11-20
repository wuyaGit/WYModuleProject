//
//  WYLocationManager.m
//  WYModule
//
//  Created by hero on 2018/11/20.
//

#import "WYLocationManager.h"
#import "WYLocationConvert.h"

@interface WYLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation WYLocationManager

+ (WYLocationManager *)sharedInstance
{
    static WYLocationManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WYLocationManager new];
    });
    
    return instance;
}

- (void)startLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];

    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = [locations lastObject];
    
    //反地理编码
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks lastObject];
            
            if (self.completion) {
                self.completion(placemark.addressDictionary, nil);
            }
        }
    }];

    //定位成功后，停止定位
    self.locationManager.delegate = nil;
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
    self.locationManager.delegate = nil;
    [self.locationManager stopUpdatingLocation];
    
    if (self.completion) {
        self.completion(nil, error);
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            break;
        case kCLAuthorizationStatusDenied: {
            if([CLLocationManager locationServicesEnabled]) {
//                [LBXAlertAction showAlertWithTitle:@"提示" msg:@"定位服务授权被拒绝，是否前往设置开启？" buttonsStatement:@[@"好的",@"取消"] chooseBlock:^(NSInteger buttonIdx) {
//                    if (buttonIdx == 0) {
//                        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//                        if ([[UIApplication sharedApplication] canOpenURL:url]) {
//                            [[UIApplication sharedApplication] openURL: url];
//                        }
//                    }
//                }];
            }
            break;
        }
        case kCLAuthorizationStatusRestricted:
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            break;
        default:
            break;
    }
}

#pragma mark - getter & setter

- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
        [_locationManager requestWhenInUseAuthorization];
    }
    return _locationManager;
}

@end
