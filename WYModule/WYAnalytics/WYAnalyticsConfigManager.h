//
//  WYAnalyticsConfigManager.h
//  WYModule
//
//  Created by mac on 2018/11/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYAnalyticsConfigManager : NSObject

+ (WYAnalyticsConfigManager *)sharedInstance;

//友盟统计配置 友盟key,chanel,是否开启SDK调试,是否开启闪退记录
@property (nonatomic, copy) NSString *analyticsAppKey;
@property (nonatomic, copy) NSString *analyticsChannelID;
@property (nonatomic, getter=isLogEnabled) BOOL analyticsLogEnabled;
@property (nonatomic) BOOL  bCrashReportEnabled;

//要统计的开头页面的前缀字符串数组 比如"CF"
@property(strong, nonatomic) NSArray *prefixFilterArray;
//要统计的页面名称字符串数组 比如"detailViewController"
@property(strong, nonatomic) NSArray *fileterNameArray;
//不统计的页面名称字符串数组
@property(strong, nonatomic) NSArray *noFileterNameArray;

@end

NS_ASSUME_NONNULL_END
