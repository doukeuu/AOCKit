//
//  AOCDateManager.h
//  AOCKit
//
//  Created by pan on 2021/8/4.
//  24小时制

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCDateManager : NSObject

/// 当前 年-月-日 时:分:秒
+ (NSString *)currentDateAndTime;
/// 当前 年-月-日
+ (NSString *)currentDateOnly;
/// 当前 时:分:秒
+ (NSString *)currentTimeOnly;
/// 根据格式获取日期
+ (NSString *)currentDateWithFormat:(NSString *)format;

/// 根据格式将字符串转换为时间类
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;
/// 将输入的时间以特定格式的字符串输出
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;
/// 根据格式将时间间隔字符串转换为时间类
+ (NSString *)stringWithTimeInterval:(NSString *)time withFormat:(NSString *)format;

/// 将时间与现在对比，说明时间状态
+ (NSString *)timeStateConversionFromDate:(NSDate *)date;
/// 将时间与现在对比，说明时间状态(年月日)
+ (NSString *)dateStateConversionFromDate:(NSDate *)date;

// 当前 年、月、日、周几
+ (NSInteger)currentYear;
+ (NSInteger)currentMonth;
+ (NSInteger)currentDay;
+ (NSString *)currentWeekName;

/// 获取当前日历日期组成
+ (NSDateComponents *)currentDateComponents;
/// 根据给定日期，获取日历日期组成
+ (NSDateComponents *)dateComponentsWithDate:(NSDate *)date;
/// 根据日历组成，转变为周几
+ (NSString *)weekNameWithDateComponents:(NSDateComponents *)components;
/// 根据日期字符串和格式，转变为周几
+ (NSString *)weekNameFromString:(NSString *)string withFormat:(NSString *)format;

// 相同的日期
+ (BOOL)isSameDay:(NSDate *)date anotherDay:(NSDate *)anotherDay;
@end

FOUNDATION_EXPORT NSString *const DateHyphenTimeColonFormat;     // 日期连字符分割，时间冒号分割
FOUNDATION_EXPORT NSString *const DateUnderScoreTimeColonFormat; // 日期下划线分割，时间冒号分割
FOUNDATION_EXPORT NSString *const DateSlashTimeColonFormat;      // 日期斜杠分割，时间冒号分割
FOUNDATION_EXPORT NSString *const DateHyphenFormat;              // 日期格式，连字符分割
FOUNDATION_EXPORT NSString *const DateUnderScoreFormat;          // 日期格式，下划线分割
FOUNDATION_EXPORT NSString *const DateSlashFormat;               // 日期格式，斜杠分割
FOUNDATION_EXPORT NSString *const TimeColonFormat;               // 时间格式，冒号分割

NS_ASSUME_NONNULL_END
