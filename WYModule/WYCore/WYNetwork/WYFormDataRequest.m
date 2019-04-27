//
//  WYFormDataRequest.m
//  WYModule
//
//  Created by Highden on 2019/4/27.
//

#import "WYFormDataRequest.h"
#import <AFNetworking/AFURLRequestSerialization.h>

@interface WYFormDataRequest ()

@property (nonatomic, assign) YTKRequestMethod wntRequestMethod;
@property (nonatomic, strong) id wntRequestArgument;
@property (nonatomic, strong) NSString *wntRequestUrl;

@property (nonatomic, copy) WYNetworkUploadProgress wntProgress;
@end

@implementation WYFormDataRequest

// 表单上传
+ (WYFormDataRequest *)FORM:(NSString *)URL
                 parameters:(id)parameters
                   progress:(WYNetworkUploadProgress)progress
                    success:(WYNetworkRequestSuccess _Nonnull)success
                    failure:(WYNetworkRequestFailed _Nonnull)failure {
    WYFormDataRequest *networkApi = [[WYFormDataRequest alloc] init];
    networkApi.wntRequestMethod = YTKRequestMethodPOST;
    networkApi.wntRequestUrl = URL;
    networkApi.wntRequestArgument = parameters;
    networkApi.wntProgress = progress;
    
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

#pragma mark 上传数据
- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:self.wntRequestArgument options:NSJSONWritingPrettyPrinted error:nil];
        [formData appendPartWithFormData:data name:@"formData"];
    };
}

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

@end
