//
//  AOCModel.h
//  AOCKit
//
//  Created by ssbm on 2021/5/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCModel : NSObject

/// 获取所有的属性字段
+ (NSArray *)getAllPropertyKeys;

/// 从另一个数据类中拷贝属性值
- (void)copyValueFromModel:(AOCModel *)original;

/// 判断内容是否相等，仅支持全基础类型属性
- (BOOL)isEqualToModel:(AOCModel *)original;
@end

NS_ASSUME_NONNULL_END
