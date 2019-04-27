//
//  UIView+CornerRadius.h
//  SZC_UnitedMall
//
//  Created by hero on 2018/9/10.
//  Copyright © 2018年 Shenzhen Shen Zi Chuang Software Development Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CornerRadius)

// 圆形头像，解决layer.cornerRadius离屏渲染；layoutIfNeeded方法中添加
/**
 * UIView 添加圆角
 */
- (void)maskLayerWithCornerRadius:(CGFloat)cornerRadius;

/**
 * UIView 添加圆角+边框
 */
- (void)maskLayerWithCornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
@end
