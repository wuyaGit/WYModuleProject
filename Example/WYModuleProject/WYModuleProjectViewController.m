//
//  WYModuleProjectViewController.m
//  WYModuleProject
//
//  Created by 407671883@qq.com on 11/14/2018.
//  Copyright (c) 2018 407671883@qq.com. All rights reserved.
//

#import "WYModuleProjectViewController.h"

#import <WYIntroViewHelper.h>

#import <WYEmptyView.h>

#import <WYLocationManager.h>

#import <WYSearchBar.h>

@interface WYModuleProjectViewController ()

@end

@implementation WYModuleProjectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"guideMovie1" ofType:@"mov"];
//    [WYIntroViewHelper showVideoIntroViewWithPath:videoPath inView:self.view];
    
    NSArray *imageNameArray = @[@"guideImage6.gif",@"guideImage7.gif",@"guideImage8.gif"];
    [WYIntroViewHelper showImageIntroViewWithSource:imageNameArray bottonIsHidden:NO slideInto:NO inView:self.view];
    
//    self.view.ly_emptyView = [WYEmptyView diyNoDataEmpty];
//    self.view.ly_emptyView = [WYEmptyView diyNoNetworkEmptyWithTarget:self action:@selector(reload:)];
//    [self.view ly_showEmptyView];
    
//    [[WYLocationManager sharedInstance] startLocationWithCompletion:^(CLLocation * _Nonnull location, NSString * _Nonnull country, NSString * _Nonnull province, NSString * _Nonnull city, NSString * _Nonnull town, NSError * _Nonnull error) {
//
//    }];
    
    //输出信息
//    DDLogError(@"错误信息"); //红色
//    DDLogWarn(@"警告"); //橙色
//    DDLogInfo(@"提示信息"); //默认颜色
//    DDLogDebug(@"调试信息"); //默认颜色
//    DDLogVerbose(@"详细信息"); //默认颜色

//    NSLog(@"错误信息");
//    NSLog(@"警告");
//    NSLog(@"提示信息");
//    NSLog(@"调试信息");
    
    DDLogInfo(@"错误信息");
    DDLogInfo(@"警告");
    
    WYSearchBar *sear = [[WYSearchBar alloc] initWithFrame:CGRectMake(0, 100, 400, 30)];
    [self.view addSubview:sear];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
