//
//  WYSocialHelper.m
//  WYModule
//
//  Created by hero on 2018/11/14.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import "WYSocialHelper.h"
#import <UMShare/UMShare.h>

#import "WYSharePlatformHelper.h"

@implementation WYSocialHelper

+ (void)shareTextDataWithPlatform:(WYSocialPlatformType)platformType withTextData:(NSString *)textData completion:(WYSocialShareCompletionHandle)completion {
    UMSocialPlatformType umPlatformType = [WYSharePlatformHelper getUMSocialPlatformTypeByWYSocialPlatformType:platformType];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = textData;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:umPlatformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (completion) {
            completion(data, error);
        }
    }];
}

+ (void)shareUrlDataWithPlatform:(WYSocialPlatformType)platformType withShareUrl:(NSString *)shareUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImage:(id)thumImage completion:(WYSocialShareCompletionHandle)completion {
    UMSocialPlatformType umPlatformType = [WYSharePlatformHelper getUMSocialPlatformTypeByWYSocialPlatformType:platformType];

    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:thumImage];
    //设置网页地址
    shareObject.webpageUrl = shareUrl;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:umPlatformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (completion) {
            completion(data, error);
        }
    }];
}


+ (void)shareImageTextDataWithPlatform:(WYSocialPlatformType)platformType withShareImage:(id)shareImage withTitle:(NSString *)title withDescr:(NSString *)descr withThumImage:(id)thumImage completion:(WYSocialShareCompletionHandle)completion {
    UMSocialPlatformType umPlatformType = [WYSharePlatformHelper getUMSocialPlatformTypeByWYSocialPlatformType:platformType];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = thumImage;
    [shareObject setShareImage:shareImage];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:umPlatformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (completion) {
            completion(data, error);
        }
    }];
}

+ (void)shareVideoDataWithPlatform:(WYSocialPlatformType)platformType withShareVideoUrl:(id)shareVideoUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImage:(id)thumImage completion:(WYSocialShareCompletionHandle)completion {
    UMSocialPlatformType umPlatformType = [WYSharePlatformHelper getUMSocialPlatformTypeByWYSocialPlatformType:platformType];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建视频内容对象
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:title descr:descr thumImage:thumImage];
    //设置视频网页播放地址
    shareObject.videoUrl = shareVideoUrl;
//            shareObject.videoStreamUrl = @"这里设置视频数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:umPlatformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (completion) {
            completion(data, error);
        }
    }];
}

+ (void)shareMusicDataWithPlatform:(WYSocialPlatformType)platformType withShareMusicUrl:(id)shareMusicUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImage:(id)thumImage completion:(WYSocialShareCompletionHandle)completion {
    UMSocialPlatformType umPlatformType = [WYSharePlatformHelper getUMSocialPlatformTypeByWYSocialPlatformType:platformType];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建音乐内容对象
    UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:title descr:descr thumImage:thumImage];
    //设置音乐网页播放地址
    shareObject.musicUrl = shareMusicUrl;
//            shareObject.musicDataUrl = @"这里设置音乐数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:umPlatformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (completion) {
            completion(data, error);
        }
    }];
}

@end
