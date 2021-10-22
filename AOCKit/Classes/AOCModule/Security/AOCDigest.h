//
//  AOCDigest.h
//  AOCKit
//
//  Created by pan on 2021/7/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCDigest : NSObject

/// 字符串MD5值
+ (nullable NSString *)MD5:(NSString *)str;

/// 字符串MD4值
+ (nullable NSString *)MD4:(NSString *)str;

/// 字符串MD2值
+ (nullable NSString *)MD2:(NSString *)str;


/// 数据MD5值
+ (NSData *)MD5Data:(NSData *)data;

/// 数据MD4值
+ (NSData *)MD4Data:(NSData *)data;

/// 数据MD2值
+ (NSData *)MD2Data:(NSData *)data;


/// 字符串SHA1值
+ (nullable NSString *)SHA1:(NSString *)str;

/// 字符串SHA224值
+ (nullable NSString *)SHA224:(NSString *)str;

/// 字符串SHA256值
+ (nullable NSString *)SHA256:(NSString *)str;

/// 字符串SHA384值
+ (nullable NSString *)SHA384:(NSString *)str;

/// 字符串SHA512值
+ (nullable NSString *)SHA512:(NSString *)str;


/// 数据SHA1值
+ (NSData *)SHA1Data:(NSData *)data;

/// 数据SHA224值
+ (NSData *)SHA224Data:(NSData *)data;

/// 数据SHA256值
+ (NSData *)SHA256Data:(NSData *)data;

/// 数据SHA384值
+ (NSData *)SHA384Data:(NSData *)data;

/// 数据SHA512值
+ (NSData *)SHA512Data:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
