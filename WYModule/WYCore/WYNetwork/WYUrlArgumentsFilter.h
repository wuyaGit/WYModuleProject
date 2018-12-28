//
//  WYUrlArgumentsFilter.h
//  WYModule
//
//  Created by hero on 2018/12/7.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYUrlArgumentsFilter : NSObject <YTKUrlFilterProtocol>

+ (WYUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments;

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request;

@end

NS_ASSUME_NONNULL_END
