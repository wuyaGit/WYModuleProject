//
//  WYFileLogger.h
//  WYModuleProject
//
//  Created by hero on 2018/11/14.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WYLoggerFormatter.h"
#import "WYCocoaLumberjack.h"

NS_ASSUME_NONNULL_BEGIN

@interface WYFileLogger : NSObject

@property (nonatomic, strong, readwrite) DDFileLogger *fileLogger;

+(WYFileLogger *)sharedManager;

@end

NS_ASSUME_NONNULL_END
