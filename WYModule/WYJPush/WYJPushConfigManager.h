//
//  WYJPushConfigManager.h
//  WYModule
//
//  Created by Highden on 2019/6/18.
//

#import <Foundation/Foundation.h>
#import <JPush/JPUSHService.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYJPushConfigManager : NSObject

+ (WYJPushConfigManager *)sharedInstance;

//个推配置
@property (nonatomic, copy) NSString *appKey;

@property (nonatomic, copy, nullable) NSString *advertisingId;

/**
 指明应用程序包的下载渠道，为方便分渠道统计，具体值由你自行定义，如：App Store。
 */
@property (nonatomic, copy, nullable) NSString *channel;
/**
 1, 1.3.1 版本新增，用于标识当前应用所使用的 APNs 证书环境。
 2, 0（默认值）表示采用的是开发证书，1 表示采用生产证书发布应用。
 3, 注：此字段的值要与 Build Settings的Code Signing 配置的证书环境一致。
 */
@property (nonatomic, assign) BOOL isProduction;

@end

NS_ASSUME_NONNULL_END
