//
//  WYCoreConfigManager.h
//  WYModule
//
//  Created by hero on 2018/11/14.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WYCocoaLumberjack.h"
#import "WYFileLogger.h"
#import "WYPathchHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface WYCoreConfigManager : NSObject

+ (WYCoreConfigManager *)sharedInstance;

//是否开启日志记录
@property(nonatomic, assign, getter = isRecordlogger) BOOL recordlogger;
//是否开启调试插件
@property(nonatomic, assign, getter = isOpenDebug) BOOL openDebug;
//设置Patcth 传入WYPathchModel类型的数组 有值则会启动JSPatch热更新功能
@property(nonatomic, strong) NSMutableArray *jsPatchMutableArray;

@end

NS_ASSUME_NONNULL_END
