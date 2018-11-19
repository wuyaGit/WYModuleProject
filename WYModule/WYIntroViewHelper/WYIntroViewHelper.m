//
//  WYIntroViewHelper.m
//  WYModule
//
//  Created by hero on 2018/11/19.
//

#import "WYIntroViewHelper.h"
#import "DHGuidePageHUD/DHGuidePageHUD.h"

@implementation WYIntroViewHelper

+ (void)showImageIntroViewWithSource:(NSArray *)source bottonIsHidden:(BOOL)isHidden slideInto:(BOOL)slideInto inView:(UIView *)view {
    DHGuidePageHUD *introView = [[DHGuidePageHUD alloc] dh_initWithFrame:[UIScreen mainScreen].bounds imageNameArray:source buttonIsHidden:isHidden];
    introView.slideInto = slideInto;
    [view addSubview:introView];
}

+ (void)showVideoIntroViewWithPath:(NSString *)path inView:(UIView *)view {
    if (![NSURL fileURLWithPath:path]) {
        NSLog(@"无相关的视频");
        return;
    }
    DHGuidePageHUD *introView = [[DHGuidePageHUD alloc] dh_initWithFrame:[UIScreen mainScreen].bounds videoURL:[NSURL fileURLWithPath:path]];
    [view addSubview:introView];
}

@end
