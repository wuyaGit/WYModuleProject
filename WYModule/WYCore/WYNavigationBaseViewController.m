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
    NSLog(@"KZWNavigationViewController release");
#endif
}

@end
