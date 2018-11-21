//
//  UIButton+WYCountDown.m
//  WYModule
//
//  Created by hero on 2018/11/21.
//

#import "UIButton+WYCountDown.h"

@implementation UIButton (WYCountDown)

- (void)wy_countdownWithSecond:(NSInteger)second {
    [self wy_countdownWithSecond:second waitTitle:@"秒后重试" doneTitle:@"重新发送" completion:nil];
}

- (void)wy_countdownWithSecond:(NSInteger)second completion:(void(^)(void))completion {
    [self wy_countdownWithSecond:second waitTitle:@"秒后重试" doneTitle:@"重新发送" completion:completion];
}

- (void)wy_countdownWithSecond:(NSInteger)second waitTitle:(NSString *)wTitle doneTitle:(NSString *)dTitle completion:(void(^)(void))completion {
    __block NSInteger tempSecond = second;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        if (tempSecond <= 1) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = YES;
                
                [self.titleLabel setText:dTitle];
                [self setTitle:dTitle forState:UIControlStateNormal];
                
                if (completion) {
                    completion();
                }
            });
        } else {
            tempSecond--;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.enabled = NO;
                
                NSString *secText = [NSString stringWithFormat:@"%ld %@", (long)tempSecond, wTitle];
                [self.titleLabel setText:secText];
                [self setTitle:secText forState:UIControlStateNormal];
            });
        }
    });
    dispatch_resume(timer);
}

@end
