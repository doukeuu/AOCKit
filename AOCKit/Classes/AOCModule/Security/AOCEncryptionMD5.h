//
//  AOCEncryptionMD5.h
//  AOCKit
//
//  Created by ssbm on 2021/7/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCEncryptionMD5 : NSObject

// 字符串MD5值
+ (NSString *)MD5:(NSString *)string;
+ (BOOL)verifyString:(NSString *)string withSign:(NSString *)signString;

@end

NS_ASSUME_NONNULL_END
