//
//  XAspect-MagicWindowAppDelegate.m
//  WYModule
//
//  Created by mac on 2019/2/17.
//

#import <Foundation/Foundation.h>
#import <XAspect/XAspect.h>
#import <MagicWindowSDK/MWApi.h>

#import "WYAppDelegate.h"
#import "WYMagicWindowConfigManager.h"

#define AtAspect MagicWindowAppDelegate

#define AtAspectOfClass WYAppDelegate
@classPatchField(WYAppDelegate)

@synthesizeNucleusPatch(Default, -, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions);
@synthesizeNucleusPatch(Default, -, BOOL, application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options);
@synthesizeNucleusPatch(Default, -, BOOL, application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler);
@synthesizeNucleusPatch(Default, -, void, dealloc);

AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    NSLog(@"成功加魔窗");
    //初始化SDK，必写
    [MWApi registerApp:[WYMagicWindowConfigManager sharedInstance].mwAppKey];
    
    [self registerMLinkHandel];
    
    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
}

//iOS9+，通过url scheme来唤起app
AspectPatch(-, BOOL, application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options)
{
    //必写
    [MWApi routeMLink:url];
    
//    if(支付宝回调) return 支付宝回调处理逻辑;
//    else if(微信回调) return 微信回调处理逻辑;
//    else if(其他第三方回调) return 其他第三方回调处理逻辑;
//    else [MWApi routeMLink:url]; return YES;
    
    return XAMessageForward(application:app openURL:url options:options);
}
//通过universal link来唤起app
AspectPatch(-, BOOL, application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler)
{
    //必写
    return [MWApi continueUserActivity:userActivity];
}

AspectPatch(-, void, dealloc)
{
    XAMessageForwardDirectly(dealloc);
}

#pragma mark - 微信回调

// 通过小程序唤起app:此步骤请配套mlink小程序SDK使用（需要在小程序中集成mlink小程序SDK）
//- (void)onResp:(BaseResp*)resp {
//    if ([req isKindOfClass:[LaunchFromWXReq class]])
//    {
//        LaunchFromWXReq *request = (LaunchFromWXReq *)req;
//        NSString *appParameter = request.message.messageExt;
//        if (appParameter != nil && appParameter.length > 0)
//        {
//            //必须写
//            [MWApi routeMLink:[NSURL URLWithString:appParameter]];
//        }
//    }
//}

#pragma mark - private

- (void)registerMLinkHandel {
    // 默认跳转
    [MWApi registerMLinkDefaultHandler:^(NSURL * _Nonnull url, NSDictionary * _Nullable params) {
        
    }];
    
    [MWApi registerMLinkHandlerWithKey:@"配置的mlink key" handler:^(NSURL * _Nonnull url, NSDictionary * _Nullable params) {
        // 相关代码
    }];
}

@end
#undef AtAspectOfClass
#undef AtAspect
