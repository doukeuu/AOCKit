//
//  AOCDatePickerView.h
//  AOCKit
//
//  Created by ssbm on 2021/6/9.
//

#import "AOCAnimationView.h"

NS_ASSUME_NONNULL_BEGIN

/// 选择器日期类型
typedef NS_OPTIONS(NSInteger, AOCDatePickerType) {
    /// 年
    AOCDatePickerYear = 1 << 0,
    /// 月
    AOCDatePickerMonth = 1 << 1,
    /// 日
    AOCDatePickerDay = 1 << 2,
};

/// 日期回调，返回年、月、日
typedef void(^DatePickerBlock)(NSInteger year, NSInteger month, NSInteger day);

@interface AOCDatePickerView : AOCAnimationView

/// 日期类型
@property (nonatomic, assign) AOCDatePickerType pickerType;
/// 最小日期
@property (nonatomic, strong) NSDate *minimumDate;
/// 最大日期
@property (nonatomic, strong) NSDate *maximumDate;
/// 含有全部
@property (nonatomic, assign) BOOL includeTotal;
/// 选择回调
@property (nonatomic, copy) DatePickerBlock block;

/// 展示日期选择视图
/// @param type 日期类型
/// @param block 选择后回调
+ (void)showDatePickerWithType:(AOCDatePickerType)type
                    completion:(DatePickerBlock _Nullable)block;

/// 展示日期选择视图
/// @param type 日期类型
/// @param minDate 最小日期
/// @param maxDate 最大日期
/// @param includeTotal 是否包含全部选项
/// @param block 选择后回调，点击空白，则全部回调值为-1
+ (void)showPickerWithType:(AOCDatePickerType)type
                   minDate:(NSDate * _Nullable)minDate
                   maxDate:(NSDate * _Nullable)maxDate
              includeTotal:(BOOL)includeTotal
                completion:(DatePickerBlock _Nullable)block;
@end

NS_ASSUME_NONNULL_END
