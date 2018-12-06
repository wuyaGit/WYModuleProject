//
//  WSDatePickerView.m
//  WSDatePicker
//
//  Created by iMac on 17/2/23.
//  Copyright © 2017年 zws. All rights reserved.
//

#import "WSDatePickerView.h"
#import "UIView+Extension.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//16进制颜色
#define kColorHEX(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

// 判断是否是iPhone X
#define isiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// home indicator
#define bottom_height (isiPhoneX ? 34.f : -20.f)

static const NSInteger kMaxYear = 2099;
static const NSInteger kMinYear = 1900;
static const CGFloat kPickerViewHeight = 250;
static const CGFloat kTopViewHeight = 45;

@interface WSDatePickerView () <UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate> {
    //日期存储数组
    NSMutableArray *_yearArray;
    NSMutableArray *_monthArray;
    NSMutableArray *_dayArray;
    NSMutableArray *_hourArray;
    NSMutableArray *_minuteArray;
    NSString *_dateFormatter;
    //记录位置
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;
    NSInteger hourIndex;
    NSInteger minuteIndex;
    
    NSInteger preRow;
    
    NSDate *_compltDate;
}

@property (nonatomic, strong) UIView *backgroundView;       //内容视图
@property (nonatomic, strong) UILabel *showYearView;        //显示年分的背景视图
@property (nonatomic, strong) UIPickerView *pickerView;     //日期选择器

@property (nonatomic, strong) UIView *topView;              //工具视图
@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, copy) void (^confirmHandel)(NSDate *date);

@end

@implementation WSDatePickerView

#pragma mark - Public methods

+ (void)showDatePickerWithDatePickerStyle:(WSDatePickerStyle)pickerStyle completion:(void (^)(NSDate *date))block {
    [self showDatePickerWithDatePickerStyle:pickerStyle scrollToDate:nil completion:block];
}

+ (void)showDatePickerWithDatePickerStyle:(WSDatePickerStyle)pickerStyle scrollToDate:(NSDate *)scrollToDate completion:(void (^)(NSDate *date))block {
    WSDatePickerView *pickerView = [[WSDatePickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    pickerView.confirmHandel = block;
    pickerView.datePickerStyle = pickerStyle;
    pickerView.scrollToDate = scrollToDate;
    
    [pickerView setupData];
    [pickerView setupView];
    [pickerView defaultConfig];

    [[UIApplication sharedApplication].keyWindow addSubview:pickerView];

    [UIView animateWithDuration:0.3 animations:^{
        pickerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        pickerView.backgroundView.frame = CGRectMake(0, kScreenHeight - kPickerViewHeight, kScreenWidth, kScreenHeight);
    }];
}

+ (void)showDatePickerWithParameterBlock:(void (^)(WSDatePickerView *))parameter completion:(void (^)(NSDate *))block {
    WSDatePickerView *pickerView = [[WSDatePickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    pickerView.confirmHandel = block;

    if (parameter) {
        parameter(pickerView);
    }else {
        pickerView.datePickerStyle = WSDatePickerStyleYearMonthDayHourMinute;
    }
    
    [pickerView setupData];
    [pickerView setupView];
    [pickerView defaultConfig];

    [[UIApplication sharedApplication].keyWindow addSubview:pickerView];
    
    [UIView animateWithDuration:0.3 animations:^{
        pickerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        pickerView.backgroundView.frame = CGRectMake(0, kScreenHeight - kPickerViewHeight, kScreenWidth, kScreenHeight);
    }];
}

+ (void)dismissDatePickerView {
    for (UIView *view in [[UIApplication sharedApplication].keyWindow subviews]) {
        if ([view isKindOfClass:[WSDatePickerView class]]) {
            WSDatePickerView *pickerView = (WSDatePickerView *)view;
            [pickerView dismiss];
            
            break;
        }
    }
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setupView {
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.topView];
    [self.backgroundView addSubview:self.showYearView];
    [self.backgroundView addSubview:self.pickerView];
}

- (void)setupData {
    switch (self.datePickerStyle) {
        case WSDatePickerStyleYearMonthDayHourMinute:
            _dateFormatter = @"yyyy-MM-dd HH:mm";
            break;
        case WSDatePickerStyleMonthDayHourMinute:
            _dateFormatter = @"yyyy-MM-dd HH:mm";
            break;
        case WSDatePickerStyleYearMonthDay:
            _dateFormatter = @"yyyy-MM-dd";
            break;
        case WSDatePickerStyleYearMonth:
            _dateFormatter = @"yyyy-MM";
            break;
        case WSDatePickerStyleMonthDay:
            _dateFormatter = @"yyyy-MM-dd";
            break;
        case WSDatePickerStyleHourMinute:
            _dateFormatter = @"HH:mm";
            break;
            
        default:
            _dateFormatter = @"yyyy-MM-dd HH:mm";
            break;
    }
    
}

- (void)defaultConfig {
    if (!_scrollToDate) {
        _scrollToDate = [NSDate date];
    }
    
    //循环滚动时需要用到
    preRow = (self.scrollToDate.year-kMinYear)*12+self.scrollToDate.month-1;
    
    //设置年月日时分数据
    _yearArray = [self setArray:_yearArray];
    _monthArray = [self setArray:_monthArray];
    _dayArray = [self setArray:_dayArray];
    _hourArray = [self setArray:_hourArray];
    _minuteArray = [self setArray:_minuteArray];
    
    for (int i=0; i<60; i++) {
        NSString *num = [NSString stringWithFormat:@"%02d",i];
        if (0<i && i<=12)
            [_monthArray addObject:num];
        if (i<24)
            [_hourArray addObject:num];
        [_minuteArray addObject:num];
    }
    for (NSInteger i=kMinYear; i<=kMaxYear; i++) {
        NSString *num = [NSString stringWithFormat:@"%ld",(long)i];
        [_yearArray addObject:num];
    }
    
    //最大最小限制
    if (!self.maxLimitDate) {
        self.maxLimitDate = [NSDate date];// [NSDate date:@"2099-12-31 23:59" WithFormat:@"yyyy-MM-dd HH:mm"];
    }
    //最小限制
    if (!self.minLimitDate) {
        self.minLimitDate = [NSDate date:@"1900-01-01 00:00" WithFormat:@"yyyy-MM-dd HH:mm"];
    }
}

- (void)addLabelWithName:(NSArray *)nameArr {
    for (id subView in self.showYearView.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            [subView removeFromSuperview];
        }
    }
    
    if (!_dateLabelColor) {
        _dateLabelColor = kColorHEX(0x333333);
    }
    if (!_datePickerFont) {
        _datePickerFont = [UIFont systemFontOfSize:14];
    }
    
    // 显示”年月日“汉字提示
    for (int i=0; i<nameArr.count; i++) {
        CGFloat labelX = self.showYearView.frame.size.width/(nameArr.count*2)+18+self.showYearView.frame.size.width/nameArr.count*i;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(labelX, self.showYearView.frame.size.height/2-15/2.0, 17, 15)];
        label.text = nameArr[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = _datePickerFont;
        label.textColor =  _dateLabelColor;
        label.backgroundColor = [UIColor clearColor];
        [self.showYearView addSubview:label];
    }
}

- (NSArray *)getNumberOfRowsInComponent {
    NSInteger yearNum = _yearArray.count;
    NSInteger monthNum = _monthArray.count;
    NSInteger dayNum = [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
    NSInteger hourNum = _hourArray.count;
    NSInteger minuteNUm = _minuteArray.count;
    
    NSInteger timeInterval = kMaxYear - kMinYear;
    
    switch (self.datePickerStyle) {
        case WSDatePickerStyleYearMonthDayHourMinute:
            return @[@(yearNum),@(monthNum),@(dayNum),@(hourNum),@(minuteNUm)];
            break;
        case WSDatePickerStyleMonthDayHourMinute:
            return @[@(monthNum*timeInterval),@(dayNum),@(hourNum),@(minuteNUm)];
            break;
        case WSDatePickerStyleYearMonthDay:
            return @[@(yearNum),@(monthNum),@(dayNum)];
            break;
        case WSDatePickerStyleYearMonth:
            return @[@(yearNum),@(monthNum)];
            break;
        case WSDatePickerStyleMonthDay:
            return @[@(monthNum*timeInterval),@(dayNum),@(hourNum)];
            break;
        case WSDatePickerStyleHourMinute:
            return @[@(hourNum),@(minuteNUm)];
            break;
        default:
            return @[];
            break;
    }
}

- (NSMutableArray *)setArray:(id)mutableArray
{
    if (mutableArray)
        [mutableArray removeAllObjects];
    else
        mutableArray = [NSMutableArray array];
    return mutableArray;
}

#pragma mark - UIPickerViewDelegate & UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    switch (self.datePickerStyle) {
        case WSDatePickerStyleYearMonthDayHourMinute:
            [self addLabelWithName:@[@"年",@"月",@"日",@"时",@"分"]];
            return 5;
        case WSDatePickerStyleMonthDayHourMinute:
            [self addLabelWithName:@[@"月",@"日",@"时",@"分"]];
            return 4;
        case WSDatePickerStyleYearMonthDay:
            [self addLabelWithName:@[@"年",@"月",@"日"]];
            return 3;
        case WSDatePickerStyleYearMonth:
            [self addLabelWithName:@[@"年",@"月"]];
            return 2;
        case WSDatePickerStyleMonthDay:
            [self addLabelWithName:@[@"月",@"日"]];
            return 2;
        case WSDatePickerStyleHourMinute:
            [self addLabelWithName:@[@"时",@"分"]];
            return 2;
        default:
            return 0;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *numberArr = [self getNumberOfRowsInComponent];
    return [numberArr[component] integerValue];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *customLabel = (UILabel *)view;
    if (!customLabel) {
        customLabel = [[UILabel alloc] init];
        customLabel.textAlignment = NSTextAlignmentCenter;
        
        if (!_datePickerFont) {
            _datePickerFont = [UIFont systemFontOfSize:14];
        }
        [customLabel setFont:_datePickerFont];
    }
    NSString *title;
    
    switch (self.datePickerStyle) {
        case WSDatePickerStyleYearMonthDayHourMinute:
            if (component==0) {
                title = _yearArray[row];
            }
            if (component==1) {
                title = _monthArray[row];
            }
            if (component==2) {
                title = _dayArray[row];
            }
            if (component==3) {
                title = _hourArray[row];
            }
            if (component==4) {
                title = _minuteArray[row];
            }
            break;
        case WSDatePickerStyleYearMonthDay:
            if (component==0) {
                title = _yearArray[row];
            }
            if (component==1) {
                title = _monthArray[row];
            }
            if (component==2) {
                title = _dayArray[row];
            }
            break;
        case WSDatePickerStyleYearMonth:
            if (component==0) {
                title = _yearArray[row];
            }
            if (component==1) {
                title = _monthArray[row];
            }
            break;
        case WSDatePickerStyleMonthDayHourMinute:
            if (component==0) {
                title = _monthArray[row%12];
            }
            if (component==1) {
                title = _dayArray[row];
            }
            if (component==2) {
                title = _hourArray[row];
            }
            if (component==3) {
                title = _minuteArray[row];
            }
            break;
        case WSDatePickerStyleMonthDay:
            if (component==0) {
                title = _monthArray[row%12];
            }
            if (component==1) {
                title = _dayArray[row];
            }
            break;
        case WSDatePickerStyleHourMinute:
            if (component==0) {
                title = _hourArray[row];
            }
            if (component==1) {
                title = _minuteArray[row];
            }
            break;
        default:
            title = @"";
            break;
    }
    
    customLabel.text = title;
    if (!_datePickerColor) {
        _datePickerColor = [UIColor blackColor];
    }
    customLabel.textColor = _datePickerColor;
    return customLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (self.datePickerStyle) {
        case WSDatePickerStyleYearMonthDayHourMinute:{
            if (component == 0) {
                yearIndex = row;
                
                self.showYearView.text =_yearArray[yearIndex];
            }
            if (component == 1) {
                monthIndex = row;
            }
            if (component == 2) {
                dayIndex = row;
            }
            if (component == 3) {
                hourIndex = row;
            }
            if (component == 4) {
                minuteIndex = row;
            }
            if (component == 0 || component == 1){
                [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
                if (_dayArray.count-1<dayIndex) {
                    dayIndex = _dayArray.count-1;
                }
                
            }
        }
            break;
            
        case WSDatePickerStyleYearMonthDay:{
            if (component == 0) {
                yearIndex = row;
                self.showYearView.text =_yearArray[yearIndex];
            }
            if (component == 1) {
                monthIndex = row;
            }
            if (component == 2) {
                dayIndex = row;
            }
            if (component == 0 || component == 1){
                [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
                if (_dayArray.count-1<dayIndex) {
                    dayIndex = _dayArray.count-1;
                }
            }
        }
            break;
        
        case WSDatePickerStyleYearMonth:{
            if (component == 0) {
                yearIndex = row;
                self.showYearView.text =_yearArray[yearIndex];
            }
            if (component == 1) {
                monthIndex = row;
            }
        }
            break;
            
            
        case WSDatePickerStyleMonthDayHourMinute:{
            if (component == 1) {
                dayIndex = row;
            }
            if (component == 2) {
                hourIndex = row;
            }
            if (component == 3) {
                minuteIndex = row;
            }
            
            if (component == 0) {
                
                [self yearChange:row];
                [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
                if (_dayArray.count-1<dayIndex) {
                    dayIndex = _dayArray.count-1;
                }
            }
            [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
            
        }
            break;
            
        case WSDatePickerStyleMonthDay:{
            if (component == 1) {
                dayIndex = row;
            }
            if (component == 0) {
                
                [self yearChange:row];
                [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
                if (_dayArray.count-1<dayIndex) {
                    dayIndex = _dayArray.count-1;
                }
            }
            [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
        }
            break;
            
        case WSDatePickerStyleHourMinute:{
            if (component == 0) {
                hourIndex = row;
            }
            if (component == 1) {
                minuteIndex = row;
            }
        }
            break;
            
        default:
            break;
    }
    
    [pickerView reloadAllComponents];
    
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",_yearArray[yearIndex],_monthArray[monthIndex],_dayArray[dayIndex],_hourArray[hourIndex],_minuteArray[minuteIndex]];
    
    self.scrollToDate = [[NSDate date:dateStr WithFormat:@"yyyy-MM-dd HH:mm"] dateWithFormatter:_dateFormatter];
    
    if ([self.scrollToDate compare:self.minLimitDate] == NSOrderedAscending) {
        self.scrollToDate = self.minLimitDate;
        [self getNowDate:self.minLimitDate animated:YES];
    }else if ([self.scrollToDate compare:self.maxLimitDate] == NSOrderedDescending){
        self.scrollToDate = self.maxLimitDate;
        [self getNowDate:self.maxLimitDate animated:YES];
    }
    
    _compltDate = self.scrollToDate;
}

- (void)yearChange:(NSInteger)row {
    monthIndex = row%12;
    
    //年份状态变化
    if (row-preRow <12 && row-preRow>0 && [_monthArray[monthIndex] integerValue] < [_monthArray[preRow%12] integerValue]) {
        yearIndex ++;
    } else if(preRow-row <12 && preRow-row > 0 && [_monthArray[monthIndex] integerValue] > [_monthArray[preRow%12] integerValue]) {
        yearIndex --;
    }else {
        NSInteger interval = (row-preRow)/12;
        yearIndex += interval;
    }
    
    self.showYearView.text = _yearArray[yearIndex];
    
    preRow = row;
}

#pragma mark - private methods

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundView.frame = CGRectMake(0, kScreenHeight , kScreenWidth, kPickerViewHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)backAction:(id)sender {
    [self dismiss];
}

- (void)confirmAction:(id)sender {
    [self dismiss];
    
    if (self.confirmHandel) {
        _compltDate = [self.scrollToDate dateWithFormatter:_dateFormatter];
        self.confirmHandel(_compltDate);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        [self dismiss];
    }
}

#pragma mark - tools
//通过年月求每月天数
- (NSInteger)DaysfromYear:(NSInteger)year andMonth:(NSInteger)month
{
    NSInteger num_year  = year;
    NSInteger num_month = month;
    
    BOOL isrunNian = num_year%4==0 ? (num_year%100==0? (num_year%400==0?YES:NO):YES):NO;
    switch (num_month) {
        case 1:case 3:case 5:case 7:case 8:case 10:case 12:{
            [self setdayArray:31];
            return 31;
        }
        case 4:case 6:case 9:case 11:{
            [self setdayArray:30];
            return 30;
        }
        case 2:{
            if (isrunNian) {
                [self setdayArray:29];
                return 29;
            }else{
                [self setdayArray:28];
                return 28;
            }
        }
        default:
            break;
    }
    return 0;
}

//设置每月的天数数组
- (void)setdayArray:(NSInteger)num
{
    [_dayArray removeAllObjects];
    for (int i=1; i<=num; i++) {
        [_dayArray addObject:[NSString stringWithFormat:@"%02d",i]];
    }
}

//滚动到指定的时间位置
- (void)getNowDate:(NSDate *)date animated:(BOOL)animated
{
    if (!date) {
        date = [NSDate date];
    }
    
    [self DaysfromYear:date.year andMonth:date.month];
    
    yearIndex = date.year-kMinYear;
    monthIndex = date.month-1;
    dayIndex = date.day-1;
    hourIndex = date.hour;
    minuteIndex = date.minute;
    
    //循环滚动时需要用到
    preRow = (self.scrollToDate.year-kMinYear)*12+self.scrollToDate.month-1;
    
    NSArray *indexArray;
    
    if (self.datePickerStyle == WSDatePickerStyleYearMonthDayHourMinute)
        indexArray = @[@(yearIndex),@(monthIndex),@(dayIndex),@(hourIndex),@(minuteIndex)];
    if (self.datePickerStyle == WSDatePickerStyleYearMonthDay)
        indexArray = @[@(yearIndex),@(monthIndex),@(dayIndex)];
    if (self.datePickerStyle == WSDatePickerStyleYearMonth)
        indexArray = @[@(yearIndex),@(monthIndex)];
    if (self.datePickerStyle == WSDatePickerStyleMonthDayHourMinute)
        indexArray = @[@(monthIndex),@(dayIndex),@(hourIndex),@(minuteIndex)];
    if (self.datePickerStyle == WSDatePickerStyleMonthDay)
        indexArray = @[@(monthIndex),@(dayIndex)];
    if (self.datePickerStyle == WSDatePickerStyleHourMinute)
        indexArray = @[@(hourIndex),@(minuteIndex)];
    
    self.showYearView.text = _yearArray[yearIndex];
    
    [self.pickerView reloadAllComponents];
    
    for (int i=0; i<indexArray.count; i++) {
        if ((self.datePickerStyle == WSDatePickerStyleMonthDayHourMinute || self.datePickerStyle == WSDatePickerStyleMonthDay)&& i==0) {
            NSInteger mIndex = [indexArray[i] integerValue]+(12*(self.scrollToDate.year - kMinYear));
            [self.pickerView selectRow:mIndex inComponent:i animated:animated];
        } else {
            [self.pickerView selectRow:[indexArray[i] integerValue] inComponent:i animated:animated];
        }
    }
}

#pragma mark - getter / setter

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kPickerViewHeight)];
        _backgroundView.backgroundColor = kColorHEX(0xf7f7f5);
    }
    return _backgroundView;
}

- (UILabel *)showYearView {
    if (!_showYearView) {
        _showYearView = [[UILabel alloc] initWithFrame:CGRectMake(0, kTopViewHeight, kScreenWidth, kPickerViewHeight - kTopViewHeight)];
        _showYearView.text = @"2016";
        _showYearView.textAlignment = NSTextAlignmentCenter;
        _showYearView.font = [UIFont systemFontOfSize:120];
        _showYearView.textColor = kColorHEX(0xE9EDF2);
    }
    return _showYearView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopViewHeight)];
        _topView.backgroundColor = [UIColor whiteColor];
        
        [_topView addSubview:self.titleView];
        [_topView addSubview:self.backButton];
        [_topView addSubview:self.confirmButton];
    }
    return _topView;
}

- (UILabel *)titleView {
    if (!_titleView) {
        _titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopViewHeight)];
        _titleView.textAlignment = NSTextAlignmentCenter;
        _titleView.font = [UIFont systemFontOfSize:15];
        _titleView.text = @"选择时间";
    }
    return _titleView;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kTopViewHeight, kScreenWidth, kPickerViewHeight - kTopViewHeight)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 50, kTopViewHeight)];
        [_backButton setTitle:@"取消" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [_backButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    }
    return _backButton;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame: CGRectMake(kScreenWidth - 65, 0, 50, kTopViewHeight)];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kColorHEX(0x333333) forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton.titleLabel setFont: [UIFont systemFontOfSize:16]];
        
        if (_doneButtonTitleColor) {
            [_confirmButton setTitleColor:_doneButtonTitleColor forState:UIControlStateNormal];
        }
    }
    return _confirmButton;
}

- (void)setMinLimitDate:(NSDate *)minLimitDate {
    _minLimitDate = minLimitDate;
    if ([_scrollToDate compare:self.minLimitDate] == NSOrderedAscending) {
        _scrollToDate = self.minLimitDate;
    }
    [self getNowDate:self.scrollToDate animated:NO];
}

- (void)setDoneButtonTitleColor:(UIColor *)doneButtonTitleColor {
    _doneButtonTitleColor = doneButtonTitleColor;
    self.confirmButton.titleLabel.textColor = doneButtonTitleColor;
}

- (void)setDateLabelColor:(UIColor *)dateLabelColor {
    _dateLabelColor = dateLabelColor;
    for (id subView in self.showYearView.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            UILabel *label = subView;
            label.textColor = dateLabelColor;
        }
    }
}

- (void)setYearLabelColor:(UIColor *)yearLabelColor {
    _yearLabelColor = yearLabelColor;
    self.showYearView.textColor = yearLabelColor;
}

@end
