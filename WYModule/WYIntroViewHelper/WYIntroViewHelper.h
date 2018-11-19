//
//  WYIntroViewHelper.h
//  WYModule
//
//  Created by hero on 2018/11/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYIntroViewHelper : NSObject

/**
 * 设置App启动页（静态图片或动态图片）
 *
 * @param source            数据源，图片数组
 * @param isHidden          是否显示底部按钮
 * @param slideInto         是否支持滑动进入APP(默认为NO-不支持滑动进入APP | 只有在buttonIsHidden为YES-隐藏状态下可用; buttonIsHidden为NO-显示状态下直接点击按钮进入)
 * @param view              展示视图
 */
+ (void)showImageIntroViewWithSource:(NSArray *)source bottonIsHidden:(BOOL)isHidden slideInto:(BOOL)slideInto inView:(UIView *)view;

/**
 * 设置App启动页（视频）
 *
 * @param path              视频地址
 * @param view              展示视图
 */
+ (void)showVideoIntroViewWithPath:(NSString *)path inView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
