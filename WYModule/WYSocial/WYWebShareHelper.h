//
//  WYWebShareHelper.h
//  WYModule 用于H5页跟JS交互分享
//  JSExportAs可以传递多个参数  也可以不用但传多个参时可以用字典
//
//  Created by hero on 2018/11/14.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WYWebShareHelperInterface <NSObject>

/**
 纯文本分享
 
 @param platformType sina（新浪微博）wechatsession（微信好友）wechattimeline（微信朋友圈）tencentwb（腾讯微博）qzone(QQ空间) qq（QQ）
 @param text         文本内容
 */
JSExportAs(shareText,-(void)shareText:(NSString *)platformType withText:(NSString *)text);


/**
 URL分享
 
 @param platformType sina（新浪微博）wechatsession（微信好友）wechattimeline（微信朋友圈）tencentwb（腾讯微博）qzone(QQ空间) qq（QQ）
 @param shareUrl     分享地址URL
 @param title        标题
 @param descr        简介
 @param thumImageUrl 缩略图URL
 */
JSExportAs(shareUrl,-(void)shareUrl:(NSString *)platformType withShareUrl:(NSString *)shareUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImageUrl:(NSString *)thumImageUrl);


/**
 图文分享
 
 @param platformType  sina（新浪微博）wechatsession（微信好友）wechattimeline（微信朋友圈）tencentwb（腾讯微博）qzone(QQ空间) qq（QQ）
 @param shareImageUrl 分享图片的URL
 @param title         标题
 @param descr         简介
 @param thumImageUrl  缩略图URL
 */
JSExportAs(shareImageText,- (void)shareImageText:(NSString *)platformType withShareImageUrl:(NSString *)shareImageUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImageUrl:(NSString *)thumImageUrl);

@end

@interface WYWebShareHelper : NSObject <WYWebShareHelperInterface>


@end

NS_ASSUME_NONNULL_END
