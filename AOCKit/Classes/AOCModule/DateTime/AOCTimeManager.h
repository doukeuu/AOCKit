//
//  AOCTimeManager.h
//  AOCKit
//
//  Created by pan on 2021/8/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCTimeManager : NSObject

/**
 按秒倒数计时器，需考虑循环引用
 @param timeInterval    计时秒数
 @param actionBlock     每秒执行的操作，remainingTime 剩余时间，*stop 是否停止，用于退出计时，释放引用
 @param completionBlock 计时完成后执行的操作
 */
+ (void)timerForSecondCountDown:(NSTimeInterval)timeInterval
                         action:(void(^)(NSTimeInterval remainingTime, BOOL *stop))actionBlock
                     completion:(void(^)(void))completionBlock;
@end

NS_ASSUME_NONNULL_END
