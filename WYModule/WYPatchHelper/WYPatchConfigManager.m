//
//  WYPatchConfigManager.m
//  WYModule
//
//  Created by hero on 2018/11/20.
//

#import "WYPatchConfigManager.h"
#import "WYPatchHelper.h"

@implementation WYPatchConfigManager

+ (WYPatchConfigManager *)sharedInstance
{
    static WYPatchConfigManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WYPatchConfigManager new];
    });
    
    return instance;
}

- (void)setJsPatchMutableArray:(NSMutableArray *)jsPatchMutableArray {
    if (jsPatchMutableArray.count) {
        NSLog(@"开启热更新功能");
        
        WYPatchHelper *helper = [[WYPatchHelper alloc] initWithPatchArray:jsPatchMutableArray];
        [helper loadPathchFile];
    }
}

@end
