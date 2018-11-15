//
//  WYGTConfigManager.h
//  WYModule
//
//  Created by mac on 2018/11/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYGTConfigManager : NSObject

+ (WYGTConfigManager *)sharedInstance;

//个推配置
@property (nonatomic, copy) NSString *wyGTAppId;
@property (nonatomic, copy) NSString *wyGTAppKey;
@property (nonatomic, copy) NSString *wyGTAppSecret;

@end

NS_ASSUME_NONNULL_END
