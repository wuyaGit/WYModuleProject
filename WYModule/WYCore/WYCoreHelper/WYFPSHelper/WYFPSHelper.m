//
//  WYFPSHelper.m
//  WYModule
//
//  Created by hero on 2018/11/19.
//

#import "WYFPSHelper.h"

@implementation WYFPSHelper

+ (void)setupInView:(UIView *)view {
    YYFPSLabel *fps = [[YYFPSLabel alloc] initWithFrame:CGRectMake(20, 70, 70, 30)];
    [view addSubview:fps];
}

@end
