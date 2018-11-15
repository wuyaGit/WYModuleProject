//
//  WYPayConfigManager.h
//  WYModule
//
//  Created by hero on 2018/11/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYPayConfigManager : NSObject

+ (WYPayConfigManager *)sharedInstance;

// 应用注册scheme,在Info.plist定义URL types
@property (nonatomic, copy) NSString *aliAppScheme;

// 微信注册AppId,在Info.plist定义URL types
@property (nonatomic, copy) NSString *wxAppId;

@end

NS_ASSUME_NONNULL_END
