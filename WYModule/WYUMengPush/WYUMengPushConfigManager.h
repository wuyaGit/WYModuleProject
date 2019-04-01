//
//  WYUMengPushConfigManager.h
//  WYModule
//
//  Created by mac on 2019/2/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYUMengPushConfigManager : NSObject

+ (WYUMengPushConfigManager *)sharedInstance;

//友盟分享配置: 友盟key,是否开启SDK调试
@property (nonatomic, copy) NSString *umengKey;
@property (nonatomic, getter=isLogEnabled) BOOL umengLogEnabled;

@end

NS_ASSUME_NONNULL_END
