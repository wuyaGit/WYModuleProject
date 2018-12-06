//
//  WYAlertCityPickerView.m
//  WYModule
//
//  Created by hero on 2018/12/5.
//

#import "WYAlertCityPickerView.h"

static const CGFloat kPickerViewHeight = 250;
static const CGFloat kTopViewHeight = 45;

#define kMainScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kMainScreenHeight [UIScreen mainScreen].bounds.size.height
//16进制颜色
#define kColorHEX(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

@interface WYAlertCityPickerView() <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *titleView;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) NSArray *cityPlist;
@property (nonatomic, strong) NSArray *provinceArray;
@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, strong) NSArray *areaArray;

@property (nonatomic, copy) void (^confirmHandel)(NSString *, NSString *, NSString *);

@end

@implementation WYAlertCityPickerView {
    NSString *_currentProvince;
    NSString *_currentCity;
    NSString *_currentArea;
    
    NSInteger _currentProvnceRow;
}

#pragma mark - Initialzer

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupView];
        [self setupPickerData];
    }
    return self;
}

- (void)setupView {
    
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.topView];
    [self.backgroundView addSubview:self.pickerView];
}

- (void)setupPickerData {
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]].resourcePath stringByAppendingPathComponent:@"/WYAlertCityPickerView.bundle/WYAlertCityPickerView.bundle"];
    NSBundle *resource_bundle = [NSBundle bundleWithPath:bundlePath];

//    NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSString *path = [resource_bundle pathForResource:@"city" ofType:@"plist"];
    self.cityPlist = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *tmpDic in self.cityPlist) {
        for (int i = 0; i < tmpDic.allKeys.count; i ++) {
            [array addObject:tmpDic.allKeys[i]];
        }
    }
    //省
    self.provinceArray = [array copy];
    //市
    self.cityArray = [self getCityFromProvince:0];
    //区
    self.areaArray = [self getAreaFromCity:0];
    
    _currentProvince = self.provinceArray[0];
    _currentCity = self.cityArray[0];
    _currentArea = self.areaArray[0];
}

#pragma mark - Public methods

+ (void)showPickerViewHandel:(void (^)(NSString *, NSString *, NSString *))block {
    WYAlertCityPickerView *pickerView = [[WYAlertCityPickerView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    pickerView.confirmHandel = block;
    
    [[UIApplication sharedApplication].keyWindow addSubview:pickerView];
    
    [UIView animateWithDuration:0.3 animations:^{
        pickerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        pickerView.backgroundView.frame = CGRectMake(0, kMainScreenHeight - kPickerViewHeight, kMainScreenWidth, kPickerViewHeight);
    }];
}

+ (void)dismissPickerView {
    for (UIView *view in [[UIApplication sharedApplication].keyWindow subviews]) {
        if ([view isKindOfClass:[WYAlertCityPickerView class]]) {
            WYAlertCityPickerView *pickerView = (WYAlertCityPickerView *)view;
            [pickerView dismiss];
            
            break;
        }
    }
}

#pragma mark - Private methods

- (NSArray *)getCityFromProvince:(NSInteger)row {
    NSDictionary *tempDic = [self.cityPlist[row] objectForKey:self.provinceArray[row]];
    NSMutableArray *cityArray = [NSMutableArray array];
    
    for (NSDictionary *valueDic in tempDic.allValues) {
        for (int i = 0; i < valueDic.allKeys.count; i ++) {
            [cityArray addObject:valueDic.allKeys[i]];
        }
    }
    return [cityArray copy];
}

- (NSArray *)getAreaFromCity:(NSInteger)row {
    NSDictionary *tempDic = [self.cityPlist[_currentProvnceRow] objectForKey:self.provinceArray[_currentProvnceRow]];
    
    NSDictionary *dic = tempDic.allValues[row];
    NSArray *array = [dic objectForKey:self.cityArray[row]];
    
    return array;
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundView.frame = CGRectMake(0, kMainScreenHeight , kMainScreenWidth, kPickerViewHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Touch Event

- (void)onTouchClickBackAction:(id)sender {
    [self dismiss];
}

- (void)onTouchClickConfirmAction:(id)sender {
    [self dismiss];
    
    if (self.confirmHandel) {
        self.confirmHandel(_currentProvince, _currentCity, _currentArea);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        [self dismiss];
    }
}

#pragma mark - Picker view datasouce

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    }else if (component == 1){
        return self.cityArray.count;
    }else if (component == 2){
        return self.areaArray.count;
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = (UILabel *)view;
    if (!view) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 3, 50)];
        label.backgroundColor = [UIColor whiteColor];
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment = NSTextAlignmentCenter;
    }
    
    if (component == 0) {
        label.text = self.provinceArray[row];
    }else if (component == 1){
        label.text = self.cityArray[row];
    }else if (component == 2){
        label.text = self.areaArray[row];
    }
    return label;
}

#pragma mark - Picker view delegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //选择省
    if (component == 0) {
        _currentProvnceRow = row;
        self.cityArray = [self getCityFromProvince:row];
        self.areaArray = [self getAreaFromCity:0];
        
        [self.pickerView reloadComponent:1];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        [self.pickerView reloadComponent:2];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
        
        _currentProvince = self.provinceArray[row];
        _currentCity = self.cityArray[0];
        _currentArea = self.areaArray[0];
        
        //选择市
    }else if (component == 1){
        self.areaArray = [self getAreaFromCity:row];
        
        [self.pickerView reloadComponent:2];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
        
        _currentCity = self.cityArray[row];
        _currentArea = self.areaArray[0];
        
        //选择区
    }else if (component == 2){
        _currentArea = self.areaArray[row];
    }
}

#pragma mark - Getter

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight, kMainScreenWidth, kPickerViewHeight)];
        _backgroundView.backgroundColor = kColorHEX(0xf7f7f5);
    }
    return _backgroundView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kTopViewHeight)];
        _topView.backgroundColor = [UIColor whiteColor];
        
        [_topView addSubview:self.titleView];
        [_topView addSubview:self.backButton];
        [_topView addSubview:self.confirmButton];
    }
    return _topView;
}

- (UILabel *)titleView {
    if (!_titleView) {
        _titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kTopViewHeight)];
        _titleView.textAlignment = NSTextAlignmentCenter;
        _titleView.text = @"选择区域";
    }
    return _titleView;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kTopViewHeight, kMainScreenWidth, kPickerViewHeight - kTopViewHeight)];
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
        [_backButton addTarget:self action:@selector(onTouchClickBackAction:) forControlEvents:UIControlEventTouchUpInside];
        [_backButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    }
    return _backButton;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame: CGRectMake(kMainScreenWidth - 65, 0, 50, kTopViewHeight)];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kColorHEX(0x333333) forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(onTouchClickConfirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton.titleLabel setFont: [UIFont systemFontOfSize:16]];
    }
    return _confirmButton;
}


@end
