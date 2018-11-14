//
//  WYSocialShareMenuView.h
//  WYModule
//
//  Created by mac on 2018/11/14.
//

#import <UIKit/UIKit.h>
#import "WYSocialConfigManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^WYSocialSharePlatformSelectionBlock)(WYSocialPlatformType platform, NSDictionary *userInfo);

@interface WYSocialShareMenuView : UIView

+ (void)showShareMenuViewWithPlatforms:(NSArray *)platforms inView:(UIView *)inView selectionBlock:(WYSocialSharePlatformSelectionBlock)block;

@end

NS_ASSUME_NONNULL_END
