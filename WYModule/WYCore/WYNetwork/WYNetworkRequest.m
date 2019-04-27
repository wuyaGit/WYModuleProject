//
//  WYNetworkRequest.m
//  WYModule
//
//  Created by hero on 2018/12/7.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import "WYNetworkRequest.h"

@interface WYNetworkRequest ()

@property (nonatomic, assign) YTKRequestMethod wntRequestMethod;
@property (nonatomic, strong) id wntRequestArgument;
@property (nonatomic, strong) NSString *wntRequestUrl;

@end

@implementation WYNetworkRequest

+ (WYNetworkRequest *)GET:(NSString *)URL
               parameters:(id)parameters
                  success:(WYNetworkRequestSuccess)success
                  failure:(WYNetworkRequestFailed)failure {
    WYNetworkRequest *networkApi = [[WYNetworkRequest alloc] init];
    networkApi.wntRequestMethod = YTKRequestMethodGET;
    networkApi.wntRequestUrl = URL;
    networkApi.wntRequestArgument = parameters;
    [networkApi startWithCompletionBlockWithSuccess:success failure:failure];
    
    return networkApi;
}

+ (WYNetworkRequest *)POST:(NSString *)URL
                parameters:(id)parameters
                   success:(WYNetworkRequestSuccess)success
                   failure:(WYNetworkRequestFailed)failure {
    WYNetworkRequest *networkApi = [[WYNetworkRequest alloc] init];
    networkApi.wntRequestMethod = YTKRequestMethodPOST;
    networkApi.wntRequestUrl = URL;
    networkApi.wntRequestArgument = parameters;
    [networkApi startWithCompletionBlockWithSuccess:success failure:failure];

    return networkApi;
}

- (NSString *)requestUrl {
    return self.wntRequestUrl;
}

- (YTKRequestMethod)requestMethod {
    return self.wntRequestMethod;
}

- (id)requestArgument {
    return self.wntRequestArgument;
}

- (NSTimeInterval)requestTimeoutInterval {
    return 10;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

//- (nullable NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary {
//    if ([GVUserDefaults standardUserDefaults].token) {
//        return @{@"X-AUTH-TOKEN": [GVUserDefaults standardUserDefaults].token};
//    }
//    return nil;
//}

@end
