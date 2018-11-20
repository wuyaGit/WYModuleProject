//
//  WYLocationManager.m
//  WYModule
//
//  Created by hero on 2018/11/20.
//

#import "WYLocationManager.h"
#import "WYLocationConvert.h"

@interface WYLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, copy) void(^locationBlock)(CLLocation * _Nullable, NSString *_Nullable, NSString * _Nullable, NSString * _Nullable, NSString * _Nullable, NSError * _Nullable);
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

- (void)startLocationWithCompletion:(void (^)(CLLocation * _Nullable, NSString *_Nullable, NSString * _Nullable, NSString * _Nullable, NSString * _Nullable, NSError * _Nullable))completion {
    self.locationBlock = completion;
    
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    }
}

#pragma mark - CLLocationManagerDelegate

/**
 po placemark.addressDictionary
 {
 City = "\U6df1\U5733\U5e02";
 Country = "\U4e2d\U56fd";
 CountryCode = CN;
 FormattedAddressLines =     (
 "\U4e2d\U56fd\U5e7f\U4e1c\U7701\U6df1\U5733\U5e02\U5b9d\U5b89\U533a\U52b3\U52a8\U8def578\U53f7"
 );
 Name = "\U52b3\U52a8\U8def578\U53f7";
 State = "\U5e7f\U4e1c\U7701";
 Street = "\U52b3\U52a8\U8def578\U53f7";
 SubLocality = "\U5b9d\U5b89\U533a";
 SubThoroughfare = "578\U53f7";
 Thoroughfare = "\U52b3\U52a8\U8def";
 }
 
 (lldb) po placemark.thoroughfare
 劳动路
 
 (lldb) po placemark.subThoroughfare
 578号
 
 (lldb) po placemark.locality
 深圳市
 
 (lldb) po placemark.subLocality
 宝安区
 
 (lldb) po placemark.administrativeArea
 广东省
 
 (lldb) po placemark.subAdministrativeArea
 nil
 (lldb) po placemark.postalCode
 nil
 (lldb) po placemark.ISOcountryCode
 CN
 
 (lldb) po placemark.country
 中国
 */

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = [locations lastObject];
    
    //反地理编码
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks lastObject];
            NSString *country = placemark.country;
//            NSString *province = placemark.
            NSString *city = placemark.locality;
//            NSString *
            if (!city) {
                city = placemark.administrativeArea;
            }
            if ([city containsString:@"市辖区"] || [city containsString:@"市"]) {
                city = [city stringByReplacingOccurrencesOfString:@"市辖区" withString:@""];
                city = [city stringByReplacingOccurrencesOfString:@"市" withString:@""];
            }
            
//            if ([_delegate respondsToSelector:@selector(loationMangerSuccessLocationWithCity:)]) {
//                [_delegate loationMangerSuccessLocationWithCity:city];
//            }
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
    
    if (self.locationBlock) {
        self.locationBlock(nil, nil, nil, nil, nil, error);
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
            }else {
                
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
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
        [_locationManager requestWhenInUseAuthorization];
    }
    return _locationManager;
}

@end
