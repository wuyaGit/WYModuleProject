//
//  WYAlertCityPickerView.h
//  WYModule
//
//  Created by hero on 2018/12/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYAlertCityPickerView : UIView

+ (void)showPickerViewHandel:(void (^)(NSString *province, NSString *city, NSString *area))block;
+ (void)dismissPickerView;

@end

NS_ASSUME_NONNULL_END
