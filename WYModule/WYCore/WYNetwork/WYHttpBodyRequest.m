//
//  WYHttpBodyRequest.m
//  WYModule
//
//  Created by Highden on 2019/4/27.
//

#import "WYHttpBodyRequest.h"

@interface WYHttpBodyRequest ()

@property (nonatomic, assign) YTKRequestMethod wntRequestMethod;
@property (nonatomic, strong) id wntRequestArgument;
@property (nonatomic, strong) NSString *wntRequestUrl;

@property (nonatomic, copy) WYNetworkUploadProgress wntProgress;
@end

@implementation WYHttpBodyRequest

// body传参
+ (WYHttpBodyRequest *)HTTPBODY:(NSString *)URL
                     parameters:(id)parameters
                       progress:(WYNetworkUploadProgress _Nullable)progress
                        success:(WYNetworkRequestSuccess _Nonnull)success
                        failure:(WYNetworkRequestFailed _Nonnull)failure {
    WYHttpBodyRequest *networkApi = [[WYHttpBodyRequest alloc] init];
    networkApi.wntRequestMethod = YTKRequestMethodPOST;
    networkApi.wntRequestUrl = URL;
    networkApi.wntRequestArgument = parameters;
    networkApi.wntProgress = progress;
    
    [networkApi startWithCompletionBlockWithSuccess:success failure:failure];
    
    return networkApi;
}

//- (NSString *)requestUrl {
//    return self.wntRequestUrl;
//}
//
//- (YTKRequestMethod)requestMethod {
//    return self.wntRequestMethod;
//}
//
//- (id)requestArgument {
//    return self.wntRequestArgument;
//}

- (NSTimeInterval)requestTimeoutInterval {
    return 20;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

// header 传值。比如token
//- (nullable NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary {
//    if ([GVUserDefaults standardUserDefaults].token) {
//        return @{@"X-AUTH-TOKEN": [GVUserDefaults standardUserDefaults].token};
//    }
//    return nil;
//}

#pragma mark 上传进度
- (AFURLSessionTaskProgressBlock) resumableUploadProgressBlock {
    __weak typeof(self) weakSelf = self;
    AFURLSessionTaskProgressBlock block = ^void(NSProgress * progress){
        if (weakSelf.wntProgress) {
            weakSelf.wntProgress(weakSelf, progress);
        }
    };
    return block;
}

// 会忽略其他的一切自定义request的方法，例如requestUrl,requestArgument,requestMethod,requestSerializerType,requestHeaderFieldValueDictionary等等
// 注意：self.requestUrl为带IP地址的全地址
- (nullable NSURLRequest *)buildCustomUrlRequest {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.wntRequestArgument options:NSJSONWritingPrettyPrinted error:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.requestUrl]];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    //添加header传值，token
//    [request addValue:@"token" forHTTPHeaderField:@"token"];
//    [request addValue:@"userId" forHTTPHeaderField:@"userId"];
    
    [request setHTTPBody:jsonData];
    return request;
}

@end
