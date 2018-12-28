//
//  WYResponseModel.h
//  SZC_WG_LOGIN_Module
//
//  Created by hero on 2018/12/7.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// WYNetworkHelper请求数据Model化
@interface WYResponseModel : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) id data;
@property (nonatomic, strong) NSString *msg;

@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger per_page;
@property (nonatomic, assign) NSInteger current_page;
@property (nonatomic, assign) NSInteger last_page;

@end

NS_ASSUME_NONNULL_END
