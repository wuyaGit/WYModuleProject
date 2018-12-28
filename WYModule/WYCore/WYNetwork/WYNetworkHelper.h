//
//  WYNetworkHelper.h
//  WYModule
//
//  Created by hero on 2018/11/14.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WYNetworkRequest.h"

typedef NS_ENUM(NSInteger, WYNetworkServerType) {
    WYNetworkServerTypeDev,         // 开发服务器地址
    WYNetworkServerTypeTest,        // 测试服务器地址
    WYNetworkServerTypeRelease      // 发布服务器地址
};

NS_ASSUME_NONNULL_BEGIN

@interface WYNetworkHelper : NSObject

+ (WYNetworkHelper *)sharedInstance;

// 配置环境
- (void)configServerType:(WYNetworkServerType)serverType;

// 配置通用参数
- (void)configRequestFilters:(NSDictionary *)arguments;

// 配置https
- (void)configHttps;

@end

NS_ASSUME_NONNULL_END
