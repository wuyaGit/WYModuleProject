//
//  WSDatePickerView.h
//  WSDatePicker
//
//  Created by iMac on 17/2/23.
//  Copyright © 2017年 zws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+Extension.h"

/**
 *  弹出日期类型
 */
typedef NS_ENUM(NSInteger, WSDatePickerStyle) {
    WSDatePickerStyleYearMonthDayHourMinute  = 0,//年月日时分
    WSDatePickerStyleMonthDayHourMinute,//月日时分
    WSDatePickerStyleYearMonthDay,//年月日
    WSDatePickerStyleYearMonth,//年月
    WSDatePickerStyleMonthDay,//月日
    WSDatePickerStyleHourMinute//时分
};

@interface WSDatePickerView : UIView

/**
 *  确定按钮颜色
 */
@property (nonatomic, strong) UIColor *doneButtonTitleColor;
/**
 *  年-月-日-时-分 文字颜色(默认橙色)
 */
@property (nonatomic, strong) UIColor *dateLabelColor;
/**
 *  滚轮日期颜色(默认黑色)
 */
@property (nonatomic, strong) UIColor *datePickerColor;
/**
 *  大号年份字体颜色(默认灰色)想隐藏可以设置为clearColor
 */
@property (nonatomic, strong) UIColor *yearLabelColor;
/**
 *  滚轮日期、年月日提示字体(默认14号)
 */
@property (nonatomic, strong) UIFont *datePickerFont;
/**
 *  限制最大时间（默认2099）datePicker大于最大日期则滚动回最大限制日期
 */
@property (nonatomic, strong) NSDate *maxLimitDate;
/**
 *  限制最小时间（默认1900） datePicker小于最小日期则滚动回最小限制日期
 */
@property (nonatomic, strong) NSDate *minLimitDate;
/**
 *  滚到指定日期
 */
@property (nonatomic, retain) NSDate *scrollToDate;
/**
 *  日期视图类型
 */
@property (nonatomic, assign) WSDatePickerStyle datePickerStyle;

+ (void)showDatePickerWithDatePickerStyle:(WSDatePickerStyle)pickerStyle completion:(void (^)(NSDate *date))block;
+ (void)showDatePickerWithDatePickerStyle:(WSDatePickerStyle)pickerStyle scrollToDate:(NSDate *)scrollToDate completion:(void (^)(NSDate *date))block;
+ (void)showDatePickerWithParameterBlock:(void (^)(WSDatePickerView *view))parameter completion:(void (^)(NSDate *date))block;
+ (void)dismissDatePickerView;

@end

