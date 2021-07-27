//
//  AOCEncryptionAES.h
//  AOCKit
//
//  Created by ssbm on 2021/7/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCEncryptionAES : NSObject

/// 字符串AES加密，空字符串也加密
+ (NSString *)encryptionAESForString:(NSString *)parameter;
/// 字符串AES解密
+ (NSString *)decryptionAESForString:(NSString *)parameter;

// 字符串DES加密，空字符串也加密
+ (NSString *)encryptionDESForString:(NSString *)parameter;
// 字符串DES解密
+ (NSString *)decryptionDESForString:(NSString *)parameter;

@end

NS_ASSUME_NONNULL_END
