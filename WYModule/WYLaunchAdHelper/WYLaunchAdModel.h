//
//  WYLaunchAdModel.h
//  WYModule
//
//  Created by hero on 2018/11/16.
//
/**
    请求数据格式
    {
        "code":200,
        "msg":"success",
        "data":{
            "content":"http://yun.it7090.com/image/XHLaunchAd/pic_test01.jpg",
            "openUrl":"http://www.it7090.com",
            "contentSize":"1242*1786",
            "duration":5,
        }
    }
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYLaunchAdModel : NSObject

/**
 *  广告URL
 */
@property (nonatomic, copy) NSString *content;

/**
 *  点击打开连接
 */
@property (nonatomic, copy) NSString *openUrl;

/**
 *  广告分辨率
 */
@property (nonatomic, copy) NSString *contentSize;

/**
 *  广告停留时间
 */
@property (nonatomic, assign) NSInteger duration;


/**
 *  分辨率宽
 */
@property(nonatomic,assign,readonly)CGFloat width;
/**
 *  分辨率高
 */
@property(nonatomic,assign,readonly)CGFloat height;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
