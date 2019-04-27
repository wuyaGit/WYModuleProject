//
//  WYNavigationBaseViewController.m
//  WYModule
//
//  Created by hero on 2018/11/21.
//

#import "WYNavigationBaseViewController.h"

@interface WYNavigationBaseViewController () <UIGestureRecognizerDelegate>

@end

@implementation WYNavigationBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 解决 popViewController 时 tabBar 中的图标及文字出现位置偏移动画
    [UITabBar appearance].translucent = NO;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
}

#pragma mark - overrides

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UIViewController *popViewController = [self.viewControllers lastObject];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if ([popViewController respondsToSelector:@selector(beforePopViewController)]) {
        if ([popViewController performSelector:@selector(beforePopViewController)]) {
            return [super popViewControllerAnimated:animated];
        }else {
            return nil;
        }
    }
#pragma clang diagnostic pop
    
    return [super popViewControllerAnimated:animated];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0]) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - StatusBarStyle

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (void)dealloc {
    self.viewControllers = @[];
#if DEBUG
    NSLog(@"WYNavigationBaseViewController release");
#endif
}

@end
