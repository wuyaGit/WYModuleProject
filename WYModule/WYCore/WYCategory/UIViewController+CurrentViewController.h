//
//  UIViewController+CurrentViewController.h
//  WYModule
//
//  Created by hero on 2018/11/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CurrentViewController)

/*!
 @method currentViewController
 
 @return Returns the topViewController in stack of topMostController.
 */
+ (UIViewController *)currentViewController;

@end

NS_ASSUME_NONNULL_END
