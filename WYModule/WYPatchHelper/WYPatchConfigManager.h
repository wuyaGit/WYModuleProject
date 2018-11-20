//
//  WYPatchConfigManager.h
//  WYModule
//
//  Created by hero on 2018/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYPatchConfigManager : NSObject

+ (WYPatchConfigManager *)sharedInstance;

//设置Patcth 传入WYPathchModel类型的数组 有值则会启动JSPatch热更新功能
@property (nonatomic, strong) NSMutableArray *jsPatchMutableArray;

@end

NS_ASSUME_NONNULL_END
