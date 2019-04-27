//
//  WYHttpBodyRequest.h
//  WYModule
//
//  Created by Highden on 2019/4/27.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WYNetworkRequestSuccess) (YTKBaseRequest * _Nonnull request);
typedef void(^WYNetworkRequestFailed) (YTKBaseRequest * _Nonnull request);
typedef void(^WYNetworkUploadProgress) (YTKBaseRequest * _Nonnull request, NSProgress *progress);

@interface WYHttpBodyRequest : YTKBaseRequest

// body传参
+ (WYHttpBodyRequest *)HTTPBODY:(NSString *)URL
                     parameters:(id)parameters
                       progress:(WYNetworkUploadProgress _Nullable)progress
                        success:(WYNetworkRequestSuccess _Nonnull)success
                        failure:(WYNetworkRequestFailed _Nonnull)failure;

@end

NS_ASSUME_NONNULL_END
