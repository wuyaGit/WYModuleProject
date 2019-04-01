//
//  WYRongIMConfigManager.h
//  WYModule
//
//  Created by mac on 2019/2/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYRongIMConfigManager : NSObject

+ (WYRongIMConfigManager *)sharedInstance;

@property (nonatomic, copy) NSString *rongIMAppKey;

@end

NS_ASSUME_NONNULL_END
