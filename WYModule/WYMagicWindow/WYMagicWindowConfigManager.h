//
//  WYMagicWindowConfigManager.h
//  WYModule
//
//  Created by mac on 2019/2/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYMagicWindowConfigManager : NSObject

+ (WYMagicWindowConfigManager *)sharedInstance;

@property (nonatomic, copy) NSString *mwAppKey;

@end

NS_ASSUME_NONNULL_END
