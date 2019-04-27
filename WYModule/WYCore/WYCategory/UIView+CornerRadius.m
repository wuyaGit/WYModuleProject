//
//  UIView+CornerRadius.m
//  SZC_UnitedMall
//
//  Created by hero on 2018/9/10.
//  Copyright © 2018年 Shenzhen Shen Zi Chuang Software Development Technology Co., Ltd. All rights reserved.
//

#import "UIView+CornerRadius.h"

@implementation UIView (CornerRadius)

- (void)maskLayerWithCornerRadius:(CGFloat)cornerRadius {
    if (self.layer.mask.frame.size.height != self.bounds.size.height) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];    //圆角
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        //设置大小
        maskLayer.frame = self.bounds;
        //设置图形样子
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    }
}

- (void)maskLayerWithCornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    if (self.layer.mask.frame.size.height != self.bounds.size.height) {
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = self.bounds;
        
        CAShapeLayer *borderLayer = [CAShapeLayer layer];
        borderLayer.frame = self.bounds;
        borderLayer.lineWidth = borderWidth+1.0;
        borderLayer.strokeColor = borderColor.CGColor;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
        maskLayer.path = bezierPath.CGPath;
        borderLayer.path = bezierPath.CGPath;
        
        [self.layer insertSublayer:borderLayer atIndex:0];
        self.layer.mask = maskLayer;
    }
}

@end
