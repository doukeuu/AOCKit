//
//  AOCModel.h
//  AOCKit
//
//  Created by ssbm on 2021/5/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCModel : NSObject

/// 通过字典来创建一个模型
/// @param keyValues 字典(可以是NSDictionary、NSData、NSString)
+ (instancetype)parseWithKeyValues:(id)keyValues;

/// 通过字典数组来创建一个模型数组
/// @param keyValuesArray 字典数组(可以是NSDictionary、NSData、NSString)
+ (NSMutableArray *)objectArrayWithKeyValuesArray:(id)keyValuesArray;

/// 字典中的key是属性名，value是从字典中取值用的key，子类重写
+ (NSDictionary *)replacedKeyFromPropertyName;

/// 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型），子类重写
+ (NSDictionary *)objectClassInArray;

/**
 *  将模型转成字典
 *  @return 字典
 */
- (NSMutableDictionary *)keyValues;
- (NSMutableDictionary *)keyValuesWithKeys:(NSArray *)keys;
- (NSMutableDictionary *)keyValuesWithIgnoredKeys:(NSArray *)ignoredKeys;

#pragma mark - Property Key

/// 获取所有的属性字段
+ (NSArray *)getAllPropertyKeys;

/// 从另一个数据类中拷贝属性值
- (void)copyValueFromModel:(AOCModel *)original;

/// 判断内容是否相等，仅支持全基础类型属性
- (BOOL)isEqualToModel:(AOCModel *)original;

#pragma mark - Encoding

/// 数组中的属性名才会进行归档，子类重写
+ (NSArray *)allowedCodingPropertyNames;

/// 数组中的属性名将会被忽略，不进行归档，子类重写
+ (NSArray *)ignoredCodingPropertyNames;
@end

NS_ASSUME_NONNULL_END
