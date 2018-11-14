//
//  WYSocialHelper.h
//  WYModule
//
//  Created by hero on 2018/11/14.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WYSocialConfigManager.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  授权，分享，UserProfile等操作的回调
 *
 *  @param result 代表回调的结果
 *  @param error  代表回调的错误码
 */
typedef void (^WYSocialShareCompletionHandle)(id result, NSError *error);

@interface WYSocialHelper : NSObject

@property (nonatomic, copy) WYSocialShareCompletionHandle shareCompletionHandel;

/**
 *  纯文本分享
 *
 *  @param platformType 平台类型
 *  @param textData     分享内容
 *  @param completion   返回结果
 */
+ (void)shareTextDataWithPlatform:(WYSocialPlatformType)platformType withTextData:(NSString *)textData completion:(WYSocialShareCompletionHandle)completion;

/**
 *  URL分享
 *
 *  @param platformType 平台类型
 *  @param shareUrl     分享的Url
 *  @param title        标题
 *  @param descr        描述
 *  @param thumImage    缩略图（UIImage或者NSData类型，或者image_url）
 *  @param completion   返回结果
 */
+ (void)shareUrlDataWithPlatform:(WYSocialPlatformType)platformType withShareUrl:(NSString *)shareUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImage:(id)thumImage completion:(WYSocialShareCompletionHandle)completion;

/**
 *  图文分享
 *
 *  @param platformType 平台类型
 *  @param shareImage   分享的图片（可以是UIImage类对象，也可以是NSdata类对象，也可以是图片链接imageUrl NSString类对象）图片大小根据各个平台限制而定
 *  @param title        标题
 *  @param descr        描述
 *  @param thumImage    缩略图（UIImage或者NSData类型，或者image_url）
 *  @param completion   返回结果
 */
+ (void)shareImageTextDataWithPlatform:(WYSocialPlatformType)platformType withShareImage:(id)shareImage withTitle:(NSString *)title withDescr:(NSString *)descr withThumImage:(id)thumImage completion:(WYSocialShareCompletionHandle)completion;

/**
 *  视频网页分享
 *
 *  @param platformType 平台类型
 *  @param shareVideoUrl 视频网页的URL字符串 不能为空且长度不能超过255
 *  @param title        标题
 *  @param descr        描述
 *  @param thumImage    缩略图（UIImage或者NSData类型，或者image_url）
 *  @param completion   返回结果
 */
+ (void)shareVideoDataWithPlatform:(WYSocialPlatformType)platformType withShareVideoUrl:(id)shareVideoUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImage:(id)thumImage completion:(WYSocialShareCompletionHandle)completion;


/**
 *  视频网页分享
 *
 *  @param platformType 平台类型
 *  @param shareMusicUrl 音乐网页的url地址  长度不能超过10K
 *  @param title        标题
 *  @param descr        描述
 *  @param thumImage    缩略图（UIImage或者NSData类型，或者image_url）
 *  @param completion   返回结果
 */
+ (void)shareMusicDataWithPlatform:(WYSocialPlatformType)platformType withShareMusicUrl:(id)shareMusicUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImage:(id)thumImage completion:(WYSocialShareCompletionHandle)completion;


@end

NS_ASSUME_NONNULL_END
