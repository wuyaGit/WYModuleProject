//
//  WYSocialPlatformHelper.h
//  WYModule
//
//  Created by hero on 2018/11/14.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMShare/UMShare.h>
#import "WYSocialShareConfigManager.h"

NS_ASSUME_NONNULL_BEGIN

/**
 授权
 
 @param uid         授权成功获得uid
 @param openid      授权成功获得openid QQ，微信用户openid，其他平台没有
 @param accessToken 授权成功获得accessToken
 @param error       error
 */
typedef void (^WYSocialAutoCompletionHandler)(NSString *uid, NSString *openid,NSString *accessToken,NSError *error);

/**
 取消授权
 
 @param result 结果
 @param error  error
 */
typedef void (^WYCancelSocialAutoCompletionHandler)(id result,NSError *error);

/**
 获得用户
 
 @param name    用户名称
 @param iconUrl 头像URL
 @param gender  性别 （m表示男，w表示女）
 @param error   error
 */
typedef void (^WYSocialGetUserInfoCompletionHandler)(NSString *name,NSString *iconUrl,NSString *gender,NSError *error);


@interface WYSocialPlatformHelper : NSObject

@property (nonatomic, copy) WYSocialAutoCompletionHandler socialAuthCompletionBlock;
@property (nonatomic, copy) WYCancelSocialAutoCompletionHandler cancelSocialAuthCompletionBlock;
@property (nonatomic, copy) WYSocialGetUserInfoCompletionHandler socialGetUserInfoCompletionBlock;

/**
 * 获取友盟分享平台类型
 *
 * @param platformType    平台类型
 * @return   友盟平台类型
 */
+ (UMSocialPlatformType)getUMSocialPlatformTypeByWYSocialPlatformType:(WYSocialPlatformType)platformType;

/**
 判断当前手机是否有安装相应的APP
 
 @param platformType 平台类型
 
 @return YES 有安装 NO 未安装
 */
+ (BOOL)installPlatAppWithType:(WYSocialPlatformType)platformType;


/**
 授权
 
 @param platformType 平台类型
 */
+ (void)authWithPlatform:(WYSocialPlatformType)platformType completion:(WYSocialAutoCompletionHandler)completion;


/**
 取消授权
 
 @param platformType 平台类型
 */
+ (void)cancelAuthWithPlatform:(WYSocialPlatformType)platformType completion:(WYCancelSocialAutoCompletionHandler)completion;


/**
 获得用户信息
 
 @param platformType 平台类型
 */
+ (void)getUserInfoWithPlatform:(WYSocialPlatformType)platformType completion:(WYSocialGetUserInfoCompletionHandler)completion;


@end

NS_ASSUME_NONNULL_END
