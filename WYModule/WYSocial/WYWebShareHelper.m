//
//  WYWebShareHelper.m
//  WYModule
//
//  Created by hero on 2018/11/14.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import "WYWebShareHelper.h"
#import "WYSocialHelper.h"
#import "WYSocialConfigManager.h"

@implementation WYWebShareHelper

- (void)shareText:(NSString *)platformType withText:(NSString *)text {
    dispatch_async(dispatch_get_main_queue(), ^{
        [WYSocialHelper shareTextDataWithPlatform:[self getPlatformType:platformType] withTextData:text completion:^(id  _Nonnull result, NSError * _Nonnull error) {
            [self shareResultShow:error];
        }];
    });
    
}

- (void)shareUrl:(NSString *)platformType withShareUrl:(NSString *)shareUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImageUrl:(NSString *)thumImageUrl {
    [WYSocialHelper shareUrlDataWithPlatform:[self getPlatformType:platformType] withShareUrl:shareUrl withTitle:title withDescr:descr withThumImage:thumImageUrl completion:^(id  _Nonnull result, NSError * _Nonnull error) {
        [self shareResultShow:error];
    }];
}

- (void)shareImageText:(NSString *)platformType withShareImageUrl:(NSString *)shareImageUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImageUrl:(NSString *)thumImageUrl {
    [WYSocialHelper shareImageTextDataWithPlatform:[self getPlatformType:platformType] withShareImage:shareImageUrl withTitle:title withDescr:descr withThumImage:thumImageUrl completion:^(id  _Nonnull result, NSError * _Nonnull error) {
        [self shareResultShow:error];
    }];
}


#pragma mark - private

- (WYSocialPlatformType)getPlatformType:(NSString *)platformType {
    WYSocialPlatformType wyPlatformType = WYSocialPlatformType__UnKnown;
    if ([platformType isEqualToString:@"sina"]) {
        wyPlatformType = WYSocialPlatformType_Sina;
    }else if ([platformType isEqualToString:@"wechatsession"]) {
        wyPlatformType = WYSocialPlatformType_WechatSession;
    }else if ([platformType isEqualToString:@"wechattimeline"]) {
        wyPlatformType = WYSocialPlatformType_WechatTimeLine;
    }else if ([platformType isEqualToString:@"qzone"]) {
        wyPlatformType = WYSocialPlatformType_Qzone;
    }else if ([platformType isEqualToString:@"qq"]) {
        wyPlatformType = WYSocialPlatformType_QQ;
    }else {
        NSLog(@"分享指定的类型不存在，请检查平台类型字符串是否正确");
    }
    return wyPlatformType;

}

-(void)shareResultShow:(NSError *)error {
    if(error)
    {
        NSLog(@"分享失败了");
        return;
    }
    NSString *alertMessage = [WYSocialConfigManager sharedInstance].shareSuccessMessage ?: @"分享成功";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:alertMessage delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}

@end
