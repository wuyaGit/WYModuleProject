//
//  WYLaunchAdConfigManager.m
//  WYModule
//
//  Created by hero on 2018/11/16.
//

#import "WYLaunchAdConfigManager.h"

@implementation WYLaunchAdConfigManager

+ (WYLaunchAdConfigManager *)sharedInstance {
    static WYLaunchAdConfigManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WYLaunchAdConfigManager new];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.launchSourceType = SourceTypeLaunchImage;
        self.skipButtonType = SkipTypeTimeText;
        self.duration = 5;
        self.showFinishAnimate = ShowFinishAnimateFadein;
        self.showEnterForeground = NO;
    }
    return self;
}

@end
