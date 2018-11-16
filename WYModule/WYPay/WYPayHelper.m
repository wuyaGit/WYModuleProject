//
//  WYPayHelper.m
//  WYModule
//
//  Created by hero on 2018/11/15.
//

#import "WYPayHelper.h"
#import <AlipaySDK/AlipaySDK.h>
#import <WechatOpenSDK/WXApi.h>

#import "WYPayConfigManager.h"

@implementation WYPayHelper

+ (BOOL)isWxAppInstalled {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
}

+ (BOOL)isAliAppInstalled {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]];
}

// https://docs.open.alipay.com/204/105295/
+ (void)alipayOrder:(NSString *)orderStr callback:(AlipayCallback)completion {
    if (orderStr == nil) {
        NSLog(@"缺少orderStr参数");
        return;
    }
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:orderStr fromScheme:[WYPayConfigManager sharedInstance].aliAppScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        
        if (completion) {
            completion(resultDic);
        }
    }];
}

// https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=9_12
+ (void)wxpayOrder:(NSDictionary *)payReq {
    if (payReq == nil) {
        NSLog(@"缺少payReq参数");
        return;
    }
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = payReq[@"partnerid"];     //微信支付分配的商户号
    req.prepayId            = payReq[@"prepayid"];      //微信返回的支付交易会话ID
    req.nonceStr            = payReq[@"noncestr"];      //随机字符串，不长于32位。推荐随机数生成算法
    req.timeStamp           = [payReq[@"timeStamp"] intValue]; //时间戳
    req.package             = payReq[@"package"];       //暂填写固定值Sign=WXPay
    req.sign                = payReq[@"sign"];          //签名
    [WXApi sendReq:req];
}

@end
