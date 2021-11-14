//
//  NSArray+AOC.h
//  AOCKit
//
//  Created by pan on 2021/11/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (AOC)

///  返回逆序排序的数组
- (NSArray *)reversedArray;

/// 将数组转换成JSON字符串，JSON字符串或者nil（转换失败）
- (NSString *)toJSONString;
@end

NS_ASSUME_NONNULL_END
