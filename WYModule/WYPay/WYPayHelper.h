//
//  WYPayHelper.h
//  WYModule
//
//  Created by hero on 2018/11/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYPayHelper : NSObject

+ (void)AlipayWithPayOrder:(NSString *)orderString callback:(^)(void)(NSDictionary *resultDic))result;


+ (void)WechatPayWithPayReqData:(NSDictionary *)payReq;

@end

NS_ASSUME_NONNULL_END
