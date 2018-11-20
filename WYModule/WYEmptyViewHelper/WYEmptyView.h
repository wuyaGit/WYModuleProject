//
//  WYEmptyView.h
//  WYModule
//
//  Created by hero on 2018/11/20.
//

#import <UIKit/UIKit.h>
#import <LYEmptyView/LYEmptyViewHeader.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYEmptyView : LYEmptyView

/**
 * 无数据占位图
 */
+ (instancetype)diyNoDataEmpty;

/**
 * 无网络占位图
 */
+ (instancetype)diyNoNetworkEmptyWithTarget:(id)target action:(SEL)action;

/**
 * 自定义空页面占位图
 */
+ (instancetype)diyCustomEmptyViewWithTarget:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
