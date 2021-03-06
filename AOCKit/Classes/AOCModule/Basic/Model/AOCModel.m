//
//  AOCModel.m
//  AOCKit
//
//  Created by ssbm on 2021/5/7.
//

#import "AOCModel.h"
#import <objc/runtime.h>

@interface AOCModel ()

@property (nonatomic, strong) NSArray *propertyKeyArray; // 属性字段数组
@end

@implementation AOCModel

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

@end
