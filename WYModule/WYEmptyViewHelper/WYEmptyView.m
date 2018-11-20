//
//  WYEmptyView.m
//  WYModule
//
//  Created by hero on 2018/11/20.
//

#import "WYEmptyView.h"

@implementation WYEmptyView

+ (instancetype)diyNoDataEmpty {
    //1. 获取当前的bundleName
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    //2. 根据图片名称, 在bundle中检索图片路径
    NSString *path = [currentBundle pathForResource:@"no_data@2x.png" ofType:nil inDirectory:@"WYEmptyView.bundle/WYEmptyView.bundle"];
    //3. 获取图片
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    return [WYEmptyView emptyViewWithImage:image
                                  titleStr:@"暂无数据"
                                 detailStr:@"请检查您的网络连接是否正确"];
}

+ (instancetype)diyNoNetworkEmptyWithTarget:(id)target action:(SEL)action {
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [currentBundle pathForResource:@"no_network@2x.png" ofType:nil inDirectory:@"WYEmptyView.bundle/WYEmptyView.bundle"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];

    WYEmptyView *emptyView = [WYEmptyView emptyActionViewWithImage:image
                                                          titleStr:@"暂无数据"
                                                         detailStr:@"请检查您的网络连接是否正确"
                                                       btnTitleStr:@"重新加载"
                                                            target:target
                                                            action:action];
    emptyView.autoShowEmptyView = NO;
    emptyView.imageSize = CGSizeMake(150, 150);
    return emptyView;
}

+ (instancetype)diyCustomEmptyViewWithTarget:(id)target action:(SEL)action {
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = @"暂无数据，请稍后再试！";
    [customView addSubview:titleLab];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 80, 30)];
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"重试" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(120, 50, 80, 30)];
    button2.backgroundColor = [UIColor redColor];
    [button2 setTitle:@"加载" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:15];
    [button2 addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:button2];
    
    WYEmptyView *emptyView = [WYEmptyView emptyViewWithCustomView:customView];
    return emptyView;
}


- (void)prepare{
    [super prepare];
    
    self.subViewMargin = 20.f;
    
    self.titleLabFont = [UIFont systemFontOfSize:21];
    self.titleLabTextColor = [UIColor colorWithRed:90/255.0 green:180/255.0 blue:160/255.0 alpha:1];
    
    self.detailLabFont = [UIFont systemFontOfSize:16];
    self.detailLabTextColor = [UIColor colorWithRed:180/255.0 green:120/255.0 blue:90/255.0 alpha:1];
    self.detailLabMaxLines = 5;
    
    self.actionBtnBackGroundColor = [UIColor colorWithRed:90/255.0 green:180/255.0 blue:160/255.0 alpha:1];
    self.actionBtnTitleColor = [UIColor whiteColor];
}

@end
