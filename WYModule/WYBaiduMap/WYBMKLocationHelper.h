//
//  WYBMKLocationHelper.h
//  WYModule
//
//  Created by mac on 2019/2/19.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Base/BMKUserLocation.h>
#import <BMKLocationKit/BMKLocationComponent.h>

typedef void(^WYBMKLocationBlock)(BMKLocation *loction, NSError *error);

NS_ASSUME_NONNULL_BEGIN

@interface WYBMKLocationHelper : NSObject

+ (WYBMKLocationHelper *)sharedInstance;

// 单次定位，每次定位时调用
- (void)startSingleLocationWithReg:(BMKLocatingCompletionBlock)completionBlock;
// 开启连续定位
- (void)startBMKLocationWithReg:(WYBMKLocationBlock)locationBlock;
// 停止连续定位
- (void)stopBMKLocation;

@end

NS_ASSUME_NONNULL_END
