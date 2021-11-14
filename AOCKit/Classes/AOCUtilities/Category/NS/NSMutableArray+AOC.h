//
//  NSMutableArray+AOC.h
//  AOCKit
//
//  Created by pan on 2021/11/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (AOC)

/**
 *  将两个元素互换位置
 *  @return YES，表示移动成功，NO表示移动失败
 */
- (BOOL)exchangeObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to;
@end

NS_ASSUME_NONNULL_END
