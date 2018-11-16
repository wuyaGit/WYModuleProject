//
//  WYLaunchAdModel.m
//  WYModule
//
//  Created by hero on 2018/11/16.
//

#import "WYLaunchAdModel.h"

@implementation WYLaunchAdModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        self.content = dict[@"content"];
        self.openUrl = dict[@"openUrl"];
        self.duration = [dict[@"duration"] integerValue];
        self.contentSize = dict[@"contentSize"];
    }
    return self;
}

-(CGFloat)width
{
    return [[[self.contentSize componentsSeparatedByString:@"*"] firstObject] floatValue];
}

-(CGFloat)height
{
    return [[[self.contentSize componentsSeparatedByString:@"*"] lastObject] floatValue];
}

@end
