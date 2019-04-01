//
//  WYBMKConfigManager.h
//  WYModule
//
//  Created by mac on 2019/2/19.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Base/BMKMapManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYBMKConfigManager : NSObject

+ (WYBMKConfigManager *)sharedInstance;

@property (nonatomic, strong) BMKMapManager *mapManager;
@property (nonatomic, copy) NSString *appKey;

@end

NS_ASSUME_NONNULL_END
