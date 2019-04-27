//
//  WYUploadFileRequest.h
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

@interface WYUploadFileRequest : YTKBaseRequest

// 批量上传文件：比如图片
+ (WYUploadFileRequest *)UPLOAD:(NSString *)URL
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
