//
//  WYNetworkHelper.m
//  WYModule
//
//  Created by hero on 2018/11/14.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import "WYNetworkHelper.h"
#import <YTKNetwork/YTKNetwork.h>
#import <AFNetworking/AFNetworking.h>
#import "WYUrlArgumentsFilter.h"

@implementation WYNetworkHelper

+ (WYNetworkHelper *)sharedInstance {
    static WYNetworkHelper* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WYNetworkHelper new];
    });
    
    return instance;
}

- (void)configServerType:(WYNetworkServerType)serverType {
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    [agent setValue:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", @"text/css", nil] forKeyPath:@"jsonResponseSerializer.acceptableContentTypes"];
//    [agent setValue:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", @"text/css", nil] forKeyPath:@"_manager.responseSerializer.acceptableContentTypes"];
    
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    switch (serverType) {
            case WYNetworkServerTypeDev:
            config.baseUrl = @"http://10.0.0.200:888";
            break;
            case WYNetworkServerTypeTest:
            config.baseUrl = @"";
            break;
            case WYNetworkServerTypeRelease:
            config.baseUrl = @"";
            break;
        default:
            break;
    }
}

- (void)configRequestFilters:(NSDictionary *)arguments {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];

    WYUrlArgumentsFilter *urlFilter = [WYUrlArgumentsFilter filterWithArguments:arguments];
    [config addUrlFilter:urlFilter];
}

- (void)configHttps {
    // 获取证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"ssl_content" ofType:@"pem"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // 配置安全模式
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    
    // 验证公钥和证书的其他信息
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // 允许自建证书
    securityPolicy.allowInvalidCertificates = YES;
    
    // 校验域名信息
    securityPolicy.validatesDomainName = YES;
    
    // 添加服务器证书,单向验证;  可采用双证书 双向验证;
    securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
    
    [config setSecurityPolicy:securityPolicy];
}


@end
