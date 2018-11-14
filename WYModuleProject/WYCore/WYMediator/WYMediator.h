//
//  WYMediator.h
//  WYModule
//
//  Created by hero on 2018/11/14.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYMediator : NSObject

+ (instancetype)sharedInstance;

// 远程App调用入口
- (_Nullable id)performActionWithUrl:(NSURL *)url completion:(void(^)(NSDictionary * _Nonnull info))completion;

// 本地组件调用入口
- (_Nullable id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;

@end

NS_ASSUME_NONNULL_END
