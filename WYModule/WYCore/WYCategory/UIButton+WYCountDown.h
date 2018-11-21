//
//  UIButton+WYCountDown.h
//  WYModule
//
//  Created by hero on 2018/11/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (WYCountDown)

/**
 * 发送验证码倒计时
 *
 * @param second 秒
 */
- (void)wy_countdownWithSecond:(NSInteger)second;

/**
 * 发送验证码倒计时
 *
 * @param second 秒
 * @param completion 完成后回调
 */
- (void)wy_countdownWithSecond:(NSInteger)second completion:(nullable void(^)(void))completion;

/**
 * 发送验证码倒计时
 *
 * @param second 秒
 * @param wTitle 等待中显示文字
 * @param dTitle 完成后显示文字
 * @param completion 完成后回调
 */
- (void)wy_countdownWithSecond:(NSInteger)second waitTitle:(NSString *)wTitle doneTitle:(NSString *)dTitle completion:(nullable void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
