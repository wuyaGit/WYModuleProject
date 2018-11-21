//
//  WYLoggerFormatter.m
//  WYModuleProject
//
//  Created by hero on 2018/11/14.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import "WYLoggerFormatter.h"

@interface WYLoggerFormatter ()

@property (nonatomic, strong) NSDateFormatter *outputFormatter;
@end

@implementation WYLoggerFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    
    NSString *logLevel = nil;
    switch (logMessage.flag) {
        case DDLogFlagError:
            logLevel = @"[ERROR]>>";
            break;
        case DDLogFlagWarning:
            logLevel = @"[WARN]>>>";
            break;
        case DDLogFlagInfo:
            logLevel = @"[INFO]>>>";
            break;
        case DDLogFlagDebug:
            logLevel = @"[DEBUG]>>";
            break;
        default:
            logLevel = @"[VBOSE]>>";
            break;
    }
    
    NSString *formatStr = [NSString stringWithFormat:@"%@ [%@][line %ld] %@ %@ %@", [self stringWithFormat:@"yyyy-MM-dd HH:mm:ss.S" dateTime:logMessage.timestamp], logMessage.fileName, logMessage.line, logLevel, logMessage.function, logMessage.message];
    return formatStr;
}

- (NSString *)stringWithFormat:(NSString *)format dateTime:(NSDate *)dateTime {
    [self.outputFormatter setDateFormat:format];
    NSString *retStr = [self.outputFormatter stringFromDate:dateTime];
    return retStr;
}

- (NSDateFormatter *)outputFormatter {
    if (!_outputFormatter) {
        _outputFormatter = [[NSDateFormatter alloc] init];
    }
    return _outputFormatter;
}

@end
