//
//  WYSocialConfigManager.h
//  WYModule
//
//  Created by hero on 2018/11/14.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//配置类型 目前只支持新浪、微信、腾讯
typedef NS_ENUM(NSInteger, WYSocialSharePlatConfigType) {
    WYSocialSharePlatConfigType_Sina,
    WYSocialSharePlatConfigType_Wechat,
    WYSocialSharePlatConfigType_Tencent
};

//平台类型 目前只支持新浪、微信好友、微信朋友圈、QQ好友、qq空间
typedef NS_ENUM(NSInteger, WYSocialPlatformType) {
    WYSocialPlatformType__UnKnown,      //未指定
    WYSocialPlatformType_Sina,          //新浪
    WYSocialPlatformType_WechatSession, //微信好友
    WYSocialPlatformType_WechatTimeLine,//微信朋友圈
    WYSocialPlatformType_QQ,            //QQ好友
    WYSocialPlatformType_Qzone,         //qq空间
};

@interface WYSocialConfigManager : NSObject

//友盟分享配置: 友盟key,是否开启SDK调试
@property (nonatomic, copy) NSString *shareAppKey;
@property (nonatomic, getter=isLogEnabled) BOOL shareLogEnabled;

//其它配置: 分享成功跟失败的提示语
@property (nonatomic, copy) NSString *shareSuccessMessage;
@property (nonatomic, copy) NSString *shareFailureMessage;

//设置新浪
@property (nonatomic, copy) NSString *sharePlatConfigType_Sina_AppKey;
@property (nonatomic, copy) NSString *sharePlatConfigType_Sina_AppSecret;
@property (nonatomic, copy) NSString *sharePlatConfigType_Sina_RedirectURL;

//设置微信
@property (nonatomic, copy) NSString *sharePlatConfigType_Wechat_AppKey;
@property (nonatomic, copy) NSString *sharePlatConfigType_Wechat_AppSecret;
@property (nonatomic, copy) NSString *sharePlatConfigType_Wechat_RedirectURL;

//设置腾讯
@property (nonatomic, copy) NSString *sharePlatConfigType_Tencent_AppKey;
@property (nonatomic, copy) NSString *sharePlatConfigType_Tencent_AppSecret;
@property (nonatomic, copy) NSString *sharePlatConfigType_Tencent_RedirectURL;

+ (WYSocialShareConfigManager *)sharedInstance;

/**
 * 设置平台配置内容
 *
 * @param platformType 平台类型
 * @param appKey       appKey
 * @param appSecret    appSecret
 * @param redirectURL  redirectURL
 */
- (void)setPlatform:(WYSocialSharePlatConfigType)platformType
             appKey:(NSString *)appKey
          appSecret:(NSString *)appSecret
        redirectURL:(NSString *)redirectURL;

@end

NS_ASSUME_NONNULL_END
