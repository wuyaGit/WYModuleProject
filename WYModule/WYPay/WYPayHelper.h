//
//  WYPayHelper.h
//  WYModule
//
//  Created by hero on 2018/11/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^AlipayCallback)(NSDictionary *resultDic);

@interface WYPayHelper : NSObject

/**
 * 阿里支付，快捷订单支付 
 *
 * @param orderString       app支付请求参数字符串，主要包含商户的订单信息，key=value形式，以&连接
 * @param completionBlock   快捷支付开发包回调函数，返回免登、支付结果
 */
+ (void)AlipayWithPayOrder:(NSString *)orderString callback:(AlipayCallback)completionBlock;

/**
 * 微信支付
 *
 * @param payReq 调用【统一下单API】生成预付单
 */
+ (void)WechatPayWithPayReqData:(NSDictionary *)payReq;

@end

NS_ASSUME_NONNULL_END
