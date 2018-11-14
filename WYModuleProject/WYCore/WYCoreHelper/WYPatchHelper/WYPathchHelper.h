//
//  WYPathchHelper.h
//  WYModuleProject
//
//  Created by hero on 2018/11/14.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYPathchHelper : NSObject

/**
 * @brief 初始化方法
 *
 *  @param array WYPathchModel的数组
 */
- (instancetype)initWithPatchArray:(NSMutableArray *)array;

/**
 * @brief 加载热更新文件
 */
- (void)loadPathchFile;

@end

NS_ASSUME_NONNULL_END
