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
#import "WYFPSHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface WYCoreConfigManager : NSObject

+ (WYCoreConfigManager *)sharedInstance;

//是否开启日志记录
@property (nonatomic, assign, getter = isRecordlogger) BOOL recordlogger;
//是否开启查看屏幕帧数工具
@property (nonatomic, assign, getter = isOpenFPS) BOOL openFPS;

@end

NS_ASSUME_NONNULL_END
