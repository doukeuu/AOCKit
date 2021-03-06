//
//  NSBundle+AOC.h
//  AOCKit
//
//  Created by ssbm on 2021/4/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (AOC)

/// 当前bundle文件
+ (instancetype)aocBundle;

/// URL scheme
+ (NSString *)appScheme;

/// URL identifier
+ (NSString *)appIdentifier;

@end

NS_ASSUME_NONNULL_END
