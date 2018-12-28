//
//  WYNetworkRequest.m
//  WYModule
//
//  Created by hero on 2018/12/7.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import "WYNetworkRequest.h"
#import <AFNetworking/AFURLRequestSerialization.h>

@interface WYNetworkRequest ()

@property (nonatomic, assign) YTKRequestMethod wntRequestMethod;
@property (nonatomic, strong) id wntRequestArgument;
@property (nonatomic, strong) NSString *wntRequestUrl;

@property (nonatomic, strong) NSString *wntName;
@property (nonatomic, strong) NSArray<UIImage *> *wntImages;
@property (nonatomic, strong) NSArray<NSString *> *wntFileNames;
@property (nonatomic, assign) CGFloat wntImageScale;
@property (nonatomic, copy) WYNetworkUploadProgress wntProgress;
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

+ (WYNetworkRequest *)UPLOAD:(NSString *)URL
                  parameters:(id)parameters
                        name:(NSString *)name
                      images:(NSArray *)images
                   fileNames:(NSArray *)fileNames
                  imageScale:(CGFloat)imageScale
                    progress:(WYNetworkUploadProgress)progress
                     success:(WYNetworkRequestSuccess _Nonnull)success
                     failure:(WYNetworkRequestFailed _Nonnull)failure {
    WYNetworkRequest *networkApi = [[WYNetworkRequest alloc] init];
    networkApi.wntRequestMethod = YTKRequestMethodPOST;
    networkApi.wntRequestUrl = URL;
    networkApi.wntRequestArgument = parameters;
    networkApi.wntName = name;
    networkApi.wntImages = images;
    networkApi.wntFileNames = fileNames;
    networkApi.wntImageScale = imageScale;
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
    return 10;
}

#pragma mark 上传图片
- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        for (NSInteger i = 0; i < self.wntImages.count; i++) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName =  [NSString stringWithFormat:@"%@_%ld.jpg",str,i];

            NSData *data = UIImageJPEGRepresentation(self.wntImages[i], self.wntImageScale?: 1.f);
            NSString *name = self.wntName;
            NSString *fileName = self.wntFileNames ? self.wntFileNames[i] : imageFileName;
            NSString *type = @"image/jpeg";
            [formData appendPartWithFileData:data name:name fileName:fileName mimeType:type];
        }
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
