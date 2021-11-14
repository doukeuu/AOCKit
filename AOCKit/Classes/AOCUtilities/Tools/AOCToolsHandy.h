//
//  AOCToolsHandy.h
//  AOCKit
//
//  Created by pan on 2021/11/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCToolsHandy : NSObject

/// 取出最大值
+ (NSString *)validateMaxNumberWithArray:(NSArray *)array;
/// 取出最小值
+ (NSString *)validateMinNumberWithArray:(NSArray *)array;

/// 将手机号、身份证号中间的数字用星号代替
+ (NSString *)replacedWithAsterisk:(NSString *)number;
/// 根据身份证号计算年龄
+ (NSString *)personAgeWithIDCard:(NSString *)number;
/// 身份证校验
+ (BOOL)validateIDCardNumber:(NSString *)value;

/// 手机号验证
+ (BOOL)validatePhoneNumber:(NSString *)value;
/// 固定电话验证
+ (BOOL)validateLandlineTelephoneNumber:(NSString *)number;
/// 验证并格式化固定电话号码（如 0108887777 格式化为 010-8887777），返回值可为nil
+ (NSString *)landlineTelephoneNumberFormated:(NSString *)number;
/// 验证邮箱号
+ (BOOL)validateEmail:(NSString *)email;
@end

NS_ASSUME_NONNULL_END
