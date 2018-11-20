//
//  WYLocationManager.h
//  WYModule
//
//  Created by hero on 2018/11/20.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYLocationManager : NSObject

+ (WYLocationManager *)sharedInstance;

- (void)startLocationWithCompletion:(void(^)(CLLocation *location, NSString *country, NSString *province, NSString *city, NSString *town, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
