//
//  WYMacros.h
//  WYModule
//
//  Created by hero on 2018/11/14.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#ifndef WYMacros_h
#define WYMacros_h

//------------------color----------------
//16进制颜色
#define WY_COLOR_HEX(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

// RGBA颜色
#define WY_COLOR_RGBA(r, g, b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
// RGB颜色
#define WY_COLOR_RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 随机色
#define WY_COLOR_RANDOM RGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

//------------------typeof----------------

// 弱引用
#define WeakObj(type) @autoreleasepool{} __weak typeof(type) type##Weak = type;

// 强引用
#define StrongObj(type) @autoreleasepool{} __strong typeof(type) type = type##Weak;

//------------------safe height----------------
// 屏幕宽
#define WY_MAIN_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
// 屏幕高
#define WY_MAIN_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// 判断设备型号
#define WY_IS_LANDSCAPE         ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight)
#define WY_IS_IPAD              ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define WY_IS_IPHONE            ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define WY_IS_IPHONE4           (WY_IS_IPHONE && WY_MAIN_SCREEN_HEIGHT < 568.0)
#define WY_IS_IPHONE5           (WY_IS_IPHONE && WY_MAIN_SCREEN_HEIGHT == 568.0)
#define WY_IS_IPHONE6           (WY_IS_IPHONE && WY_MAIN_SCREEN_HEIGHT == 667.0)
#define WY_IS_IPHONE6PLUS       (WY_IS_IPHONE && WY_MAIN_SCREEN_HEIGHT == 736.0 || WY_MAIN_SCREEN_WIDTH == 736.0) // Both orientations
#define WY_IS_IPHONEX           (WY_IS_IPHONE && (WY_MAIN_SCREEN_HEIGHT == 812.0 || WY_MAIN_SCREEN_HEIGHT == 896.0))

#define WY_HEIGHT_NAVCONTENTBAR   44.0f //导航栏内容高度
#define WY_HEIGHT_STATUSBAR       ((WY_IS_IPHONEX) ? 44.0f : 20.0f) //状态栏高度
#define WY_HEIGHT_SAFE_TOP        ((WY_IS_IPHONEX) ? 24.0f : 0.0f)  //上部高度
#define WY_HEIGHT_SAFE_NAVBAR     ((WY_IS_IPHONEX) ? 88.0f : 64.0f) //导航栏总高度（加上导航栏高度）
#define WY_HEIGHT_SAFE_TABBAR     ((WY_IS_IPHONEX) ? 83.0f : 49.0f) //底部选择栏高度
#define WY_HEIGHT_SAFE_BOTTOM     ((WY_IS_IPHONEX) ? (34) : (0))    //安全底部高度

//------------------other----------------

#define WY_ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

#define BoundingRectWithSize(text, size, font)                                                                         \
[text boundingRectWithSize:size                                                                                      \
options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading                    \
attributes:@{NSFontAttributeName:font}                                                              \
context:nil]

#endif /* WYMacros_h */
