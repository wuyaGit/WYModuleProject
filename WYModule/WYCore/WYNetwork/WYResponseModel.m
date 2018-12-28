//
//  WYResponseModel.m
//  SZC_WG_LOGIN_Module
//
//  Created by hero on 2018/12/7.
//  Copyright © 2018 407671883@qq.com. All rights reserved.
//

#import "WYResponseModel.h"

@implementation WYResponseModel

+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"total": @"data.total",
             @"per_page": @"data.per_page",
             @"current_page": @"data.current_page",
             @"last_page": @"data.last_page"
             };
}

@end
