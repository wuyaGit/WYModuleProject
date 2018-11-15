//
//  XAspect-PayAppDelegate.m
//  WYModule
//
//  Created by hero on 2018/11/15.
//

#import <Foundation/Foundation.h>
#import <XAspect/XAspect.h>
#import <AlipaySDK/AlipaySDK.h>
#import <WechatOpenSDK/WXApi.h>

#import "WYAppDelegate+myPay.h"
#import "WYPayConfigManager.h"

#define AtAspect PayAppDelegate

#define AtAspectOfClass WYAppDelegate
@classPatchField(WYAppDelegate)

@synthesizeNucleusPatch(Default, -, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions);
@synthesizeNucleusPatch(Default, -, BOOL, application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation);
@synthesizeNucleusPatch(Default, -, BOOL, application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options);

AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    // 向微信注册APPID
    if ([WYPayConfigManager sharedInstance].wxAppId) {
        [WXApi registerApp:[WYPayConfigManager sharedInstance].wxAppId enableMTA:NO];
    }
    
    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
}

// NOTE: 9.0以前使用新API接口
AspectPatch(-, BOOL, application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation)
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }else {
        [WXApi handleOpenURL:url delegate:self];
    }
    return XAMessageForward(application:application openURL:url sourceApplication:sourceApplication annotation:annotation);
}

// NOTE: 9.0以后使用新API接口
AspectPatch(-, BOOL, application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options)
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }else {
        [WXApi handleOpenURL:url delegate:self];
    }
    return XAMessageForward(application:app openURL:url options:options);
}

#pragma mark - 微信支付回调

- (void)onResp:(BaseResp*)resp {
    if ([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch(resp.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
            default:
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
}


@end
#undef AtAspectOfClass
#undef AtAspect

