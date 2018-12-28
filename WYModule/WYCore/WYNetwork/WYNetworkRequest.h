//
//  WYNetworkRequest.h
//  WYModule
//
//  Created by hero on 2018/12/7.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import "YTKBaseRequest.h"
#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WYNetworkRequestSuccess) (YTKBaseRequest * _Nonnull request);
typedef void(^WYNetworkRequestFailed) (YTKBaseRequest * _Nonnull request);
typedef void(^WYNetworkUploadProgress) (YTKBaseRequest * _Nonnull request, NSProgress *progress);

@interface WYNetworkRequest : YTKBaseRequest

+ (WYNetworkRequest *)GET:(NSString *)URL
               parameters:(id)parameters
                  success:(WYNetworkRequestSuccess)success
                  failure:(WYNetworkRequestFailed)failure;

+ (WYNetworkRequest *)POST:(NSString *)URL
                parameters:(id)parameters
                   success:(WYNetworkRequestSuccess)success
                   failure:(WYNetworkRequestFailed)failure;

+ (WYNetworkRequest *)UPLOAD:(NSString *)URL
                  parameters:(id)parameters
                        name:(NSString *)name
                      images:(NSArray *)images
                   fileNames:(NSArray * _Nullable)fileNames
                  imageScale:(CGFloat)imageScale
                    progress:(WYNetworkUploadProgress _Nullable)progress
                     success:(WYNetworkRequestSuccess _Nonnull)success
                     failure:(WYNetworkRequestFailed _Nonnull)failure;
@end

NS_ASSUME_NONNULL_END
