//
//  WYSearchBar.h
//  WYModule 查找:https://github.com/zonghongyan/EVNCustomSearchBar
//
//  Created by hero on 2018/11/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WYSearchBarIconAlign)
{
    WYSearchBarIconAlignLeft,
    WYSearchBarIconAlignCenter
};

@class WYSearchBar;

@protocol WYSearchBarDelegate <UIBarPositioningDelegate>

@optional

- (BOOL)searchBarShouldBeginEditing:(WYSearchBar *)searchBar;

- (void)searchBarTextDidBeginEditing:(WYSearchBar *)searchBar;

- (BOOL)searchBarShouldEndEditing:(WYSearchBar *)searchBar;

- (void)searchBarTextDidEndEditing:(WYSearchBar *)searchBar;

- (void)searchBar:(WYSearchBar *)searchBar textDidChange:(NSString *)searchText;

- (BOOL)searchBar:(WYSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

- (void)searchBarSearchButtonClicked:(WYSearchBar *)searchBar;

- (void)searchBarCancelButtonClicked:(WYSearchBar *)searchBar;

@end

/**
 * 自定义SearchBar
 */
@interface WYSearchBar : UIView<UITextInputTraits>

/**
 * 搜索框的代理
 */
@property (nullable, nonatomic, weak) id<WYSearchBarDelegate> delegate;

/**
 * 搜索框文本
 */
@property (nullable, nonatomic, copy) NSString *text;

/**
 * 搜索框文本颜色
 */
@property (nullable, nonatomic, strong) UIColor *textColor;

/**
 * 搜索框文本字体
 */
@property (nullable, nonatomic,strong) UIFont *textFont;

/**
 * 搜索框提示信息(默认"请输入关键字")
 */
@property (nullable, nonatomic, copy) NSString *placeholder;

/**
 * 搜索框提示信息颜色(默认#666666)
 */
@property (nullable, nonatomic, strong) UIColor *placeholderColor;

/**
 * 搜索框颜色
 */
@property (nullable, nonatomic, strong) UIColor *textFieldColor;

/**
 * 左边icon的图片(默认searchImageTextColor)
 */
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) UIImage *backgroundImage;

/**
 * 右边取消按钮
 */
@property (nullable, nonatomic, strong) UIButton *cancelButton;

@property (nonatomic) BOOL isHiddenCancelButton;

/**
 * 输入框的风格
 */
@property (nonatomic) UITextBorderStyle textBorderStyle;

/**
 * 键盘类型
 */
@property (nonatomic) UIKeyboardType keyboardType;

/**
 * 左边icon的位置(默认WYSearchBarIconAlignCenter)
 */
@property (nonatomic) WYSearchBarIconAlign iconAlign;

@property (nonatomic, strong) UIView *inputAccessoryView;

@property (nonatomic, strong) UIView *inputView;

- (BOOL)isFirstResponder;
- (BOOL)resignFirstResponder;
- (BOOL)becomeFirstResponder;

- (void)setAutoCapitalizationMode:(UITextAutocapitalizationType)type;

@end

NS_ASSUME_NONNULL_END
