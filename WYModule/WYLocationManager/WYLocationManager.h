//
//  WYLocationManager.h
//  WYModule
//
//  Created by hero on 2018/11/20.
//
/** placemark.addressDictionary
 {
 City = "\U6df1\U5733\U5e02";
 Country = "\U4e2d\U56fd";
 CountryCode = CN;
 FormattedAddressLines = ();
 Name = "\U52b3\U52a8\U8def578\U53f7";
 State = "\U5e7f\U4e1c\U7701";
 Street = "\U52b3\U52a8\U8def578\U53f7";
 SubLocality = "\U5b9d\U5b89\U533a";
 SubThoroughfare = "578\U53f7";
 Thoroughfare = "\U52b3\U52a8\U8def";
 }
 */

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define WYLOCATION_CITY             @"City"
#define WYLOCATION_COUNTRY          @"Country"
#define WYLOCATION_COUNTRYCODE      @"CountryCode"
#define WYLOCATION_FORMATTEDADDRESSLINE @"FormattedAddressLines"
#define WYLOCATION_NAME             @"Name"
#define WYLOCATION_STATE            @"State"
#define WYLOCATION_STREET           @"Street"
#define WYLOCATION_SUBLOCALITY      @"SubLocality"
#define WYLOCATION_SUBTHOROUGHFARE  @"SubThoroughfare"

NS_ASSUME_NONNULL_BEGIN

@interface WYLocationManager : NSObject

@property (nonatomic, copy) void(^completion)(NSDictionary * _Nullable info, NSError *_Nullable error);

+ (WYLocationManager *)sharedInstance;

- (void)startLocation;

@end

NS_ASSUME_NONNULL_END
