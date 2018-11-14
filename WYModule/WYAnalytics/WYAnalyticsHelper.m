//
//  WYAnalyticsHelper.m
//  WYModule
//
//  Created by mac on 2018/11/14.
//

#import "WYAnalyticsHelper.h"
#import <Aspects/Aspects.h>
#import <UMAnalytics/MobClick.h>

#import "WYAnalyticsConfigManager.h"

@implementation WYAnalyticsHelper

+ (void)analyticsViewController {
    //放到异步线程去执行
    __weak typeof(self) WeakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info, BOOL animated){
            UIViewController *controller = info.instance;
            BOOL filterResult = [WeakSelf fileterWithControllerName:NSStringFromClass([controller class])];
            if (filterResult) {
                [WeakSelf beginLogPageView:[controller class]];
            }
        }error:NULL];
        
        [UIViewController aspect_hookSelector:@selector(viewWillDisappear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info, BOOL animated){
            UIViewController *controller = info.instance;
            BOOL filterResult = [WeakSelf fileterWithControllerName:NSStringFromClass([controller class])];
            if (filterResult) {
                [WeakSelf endLogPageView:[controller class]];
            }
        } error:NULL];

    });
}

+ (void)beginLogPageView:(__unsafe_unretained Class)pageView {
    [MobClick beginLogPageView:NSStringFromClass(pageView)];
    return;
}

+ (void)endLogPageView:(__unsafe_unretained Class)pageView {
    [MobClick endLogPageView:NSStringFromClass(pageView)];
    return;
}

+(void)beginLogPageViewName:(NSString *)pageViewName
{
    [MobClick beginLogPageView:pageViewName];
    return;
}

+(void)endLogPageViewName:(NSString *)pageViewName
{
    [MobClick endLogPageView:pageViewName];
    return;
}

+(void)logEvent:(NSString*)eventId
{
    [MobClick event:eventId];
}

+(void)logEvent:(NSString*)eventId attributes:(NSDictionary *)attributes
{
    [MobClick event:eventId attributes:attributes];
}

#pragma mark - private

+ (BOOL)fileterWithControllerName:(NSString *)controllerName {
    BOOL result = NO;
    
    if ([WYAnalyticsConfigManager sharedInstance].prefixFilterArray.count == 0 &&
        [WYAnalyticsConfigManager sharedInstance].noFileterNameArray.count == 0 &&
        [WYAnalyticsConfigManager sharedInstance].fileterNameArray.count == 0) {
        return YES;
    }
    
    //判断是否在符合前缀里面
    if ([WYAnalyticsConfigManager sharedInstance].prefixFilterArray.count) {
        for (NSString *prefixItem in [WYAnalyticsConfigManager sharedInstance].prefixFilterArray) {
            if ([controllerName hasPrefix:prefixItem]) {
                result = YES;
                break;
            }
        }
    }
    
    //若有符合前缀则执行下面的内容 再进行判断当前页面是否要被省略掉的页面
    if (result) {
        if ([[WYAnalyticsConfigManager sharedInstance].noFileterNameArray containsObject:controllerName]) {
            result = NO;
        }
    }else {
        if ([[WYAnalyticsConfigManager sharedInstance].fileterNameArray containsObject:controllerName]) {
            result = YES;
        }
    }
    
    return result;
}

@end
