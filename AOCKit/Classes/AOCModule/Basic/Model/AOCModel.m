//
//  AOCModel.m
//  AOCKit
//
//  Created by ssbm on 2021/5/7.
//

#import "AOCModel.h"
#import <MJExtension/MJExtension.h>

@interface AOCModel () <NSCoding>

@property (nonatomic, strong) NSArray *propertyKeyArray; // 属性字段数组
@end

@implementation AOCModel

// 通过字典来创建一个模型
+ (instancetype)parseWithKeyValues:(id)keyValues {
    return [self mj_objectWithKeyValues:keyValues];
}

// 通过字典数组来创建一个模型数组
+ (NSMutableArray *)objectArrayWithKeyValuesArray:(id)keyValuesArray {
    return [self mj_objectArrayWithKeyValuesArray:keyValuesArray];
}

// 字典中的key是属性名，value是从字典中取值用的key，子类重写
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{};
}

// 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型），子类重写
+ (NSDictionary *)objectClassInArray {
    return @{};
}

// 只有这个数组中的属性名才允许进行字典和模型的转换
+ (NSArray *)allowedPropertyNames {
    return @[];
}

// 这个数组中的属性名将会被忽略：不进行字典和模型的转换
+ (NSArray *)ignoredPropertyNames {
    return @[];
}

// 实现MJKeyValue协议方法
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return [self replacedKeyFromPropertyName];
}

// 实现MJKeyValue协议方法
+ (NSDictionary *)mj_objectClassInArray {
    return [self objectClassInArray];
}

// 实现MJKeyValue协议方法
+ (NSArray *)mj_allowedPropertyNames {
    return [self allowedPropertyNames];
}

// 实现MJKeyValue协议方法
+ (NSArray *)mj_ignoredPropertyNames {
    return [self ignoredPropertyNames];
}

/**
 *  将模型转成字典
 *  @return 字典
 */
- (NSMutableDictionary *)keyValues {
    return [self mj_keyValues];
}
- (NSMutableDictionary *)keyValuesWithKeys:(NSArray *)keys {
    return [self mj_keyValuesWithKeys:keys];
}
- (NSMutableDictionary *)keyValuesWithIgnoredKeys:(NSArray *)ignoredKeys {
    return [self mj_keyValuesWithIgnoredKeys:ignoredKeys];
}

#pragma mark - Property Key

// 获取所有的属性字段
+ (NSArray *)getAllPropertyKeys {
    unsigned int count;
    objc_property_t *propertys = class_copyPropertyList(self, &count);
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i ++) {
        const char *property = property_getName(propertys[i]);
        NSString *propertyKey = [NSString stringWithUTF8String:property];
        [mutableArray addObject:propertyKey];
    }
    free(propertys);
    return [mutableArray copy];
}

- (NSArray *)propertyKeyArray {
    if (_propertyKeyArray) return _propertyKeyArray;
    _propertyKeyArray = [[self class] getAllPropertyKeys];
    return _propertyKeyArray;
}

// 从另一个数据类中拷贝属性值
- (void)copyValueFromModel:(AOCModel *)original {
    if (!original) return;
    for (NSString *key in self.propertyKeyArray) {
        [self setValue:[original valueForKey:key] forKey:key];
    }
}

// 判断内容是否相等，仅支持全基础类型属性
- (BOOL)isEqualToModel:(AOCModel *)original {
    for (NSString *key in self.propertyKeyArray) {
        id nowValue = [NSString stringWithFormat:@"%@", [self valueForKey:key] ?: @""];
        id originalValue = [NSString stringWithFormat:@"%@", [original valueForKey:key] ?: @""];
        if (![nowValue isEqualToString:originalValue]) {
             return NO;
        }
    }
    return YES;
}

#pragma mark - Encoding

MJExtensionCodingImplementation

// 数组中的属性名才会进行归档
+ (NSArray *)allowedCodingPropertyNames {
    return @[];
}

// 数组中的属性名将会被忽略：不进行归档
+ (NSArray *)ignoredCodingPropertyNames {
    return @[];
}

// 实现MJCoding协议方法
+ (NSArray *)mj_allowedCodingPropertyNames {
    return [self allowedCodingPropertyNames];
}

// 实现MJCoding协议方法
+ (NSArray *)mj_ignoredCodingPropertyNames {
    return [self ignoredCodingPropertyNames];
}

@end
