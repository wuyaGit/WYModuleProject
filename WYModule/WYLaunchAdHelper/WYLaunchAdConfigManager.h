//
//  WYLaunchAdConfigManager.h
//  WYModule github:https://github.com/CoderZhuXH/XHLaunchAd
//
//  Created by hero on 2018/11/16.
//

#import <Foundation/Foundation.h>
#import <XHLaunchAd/XHLaunchAd.h>

NS_ASSUME_NONNULL_BEGIN

// 广告展示类型
typedef NS_ENUM(NSInteger, WYLaunchAdSourceType) {
    WYLaunchAdSourceTypeLocalOrUrlImage,    //本地或网络图片广告（图片不要放在Assets里面,XHLaunchAd不是通过imageName:读取图片）
    WYLaunchAdSourceTypeLocalOrUrlVideo,    //本地或网络视频广告
    WYLaunchAdSourceTypeNetworkImage,       //网络数据，图片广告
    WYLaunchAdSourceTypeNetworkVideo,       //网络数据，视频广告
};

@interface WYLaunchAdConfigManager : NSObject

+ (WYLaunchAdConfigManager *)sharedInstance;

//广告展示类型
@property (nonatomic, assign) WYLaunchAdSourceType launchAdSourceType;

//启动图来源(设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage))
@property (nonatomic, assign) SourceType launchSourceType;

//跳过按钮类型(default SkipTypeTimeText)
@property (nonatomic, assign) SkipType skipButtonType;

//停留时间(default 5 ,单位:秒)
@property (nonatomic, assign) NSInteger duration;

//显示完成动画(default ShowFinishAnimateFadein)
@property (nonatomic, assign) ShowFinishAnimate showFinishAnimate;

//程序从后台恢复时,是否需要展示广告(defailt NO)
@property (nonatomic, assign) BOOL showEnterForeground;

// 点击打开页面参数
@property (nonatomic, strong) id openModel;

// 本地图片/视频 网络图片/视频 名字/URL
@property (nonatomic, copy) NSString *sourceNameOrURLString;

// 网络请求链接
@property (nonatomic, copy) NSString *URLString;

@end

NS_ASSUME_NONNULL_END
