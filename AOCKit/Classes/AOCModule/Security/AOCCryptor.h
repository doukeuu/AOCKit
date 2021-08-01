//
//  AOCCryptor.h
//  AOCKit
//
//  Created by pan on 2021/7/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCCryptor : NSObject

/// 字符串AES128加密，空字符串不加密
/// @param str 字符串
/// @param key 密钥
+ (NSString *)AES128EncryptString:(NSString *)str key:(NSString *)key;

/// 字符串AES128解密
/// @param str 字符串
/// @param key 密钥
+ (NSString *)AES128DecryptString:(NSString *)str key:(NSString *)key;


/// 字符串DES加密，空字符串不加密
/// @param str 字符串
/// @param key 密钥
+ (NSString *)DESEncryptString:(NSString *)str key:(NSString *)key;

/// 字符串DES解密
/// @param str 字符串
/// @param key 密钥
+ (NSString *)DESDecryptString:(NSString *)str key:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
