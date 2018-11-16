//
//  XAspect-LaunchAdAppDelegate.m
//  WYModule
//
//  Created by hero on 2018/11/16.
//

#import <Foundation/Foundation.h>
#import <XAspect/XAspect.h>
#import <XHLaunchAd/XHLaunchAd.h>
#import "WYAppDelegate.h"
#import "WYLaunchAdHelper.h"

#define AtAspect LaunchAdAppDelegate

#define AtAspectOfClass WYAppDelegate
@classPatchField(WYAppDelegate)

@synthesizeNucleusPatch(Default, -, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions);

AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    NSLog(@"成功加载开机广告模块");
    
    [WYLaunchAdHelper setupXHLaunchAd];
    
    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
}

@end
#undef AtAspectOfClass
#undef AtAspect
