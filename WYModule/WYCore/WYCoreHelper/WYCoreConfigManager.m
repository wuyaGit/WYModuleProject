//
//  WYCoreConfigManager.m
//  WYModule
//
//  Created by hero on 2018/11/14.
//

#import "WYCoreConfigManager.h"

@implementation WYCoreConfigManager

+ (WYCoreConfigManager *)sharedInstance
{
    static WYCoreConfigManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WYCoreConfigManager new];
    });
    
    return instance;
}

- (void)setJsPatchMutableArray:(NSMutableArray *)jsPatchMutableArray {
    if (jsPatchMutableArray.count) {
        NSLog(@"开启热更新功能");
        
        WYPathchHelper *helper = [[WYPathchHelper alloc] initWithPatchArray:jsPatchMutableArray];
        [helper loadPathchFile];
    }
}

@end
