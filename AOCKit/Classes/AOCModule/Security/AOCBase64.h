//
//  AOCBase64.h
//  AOCKit
//
//  Created by pan on 2021/7/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCBase64 : NSObject

#pragma mark - Encode

/// 编码Data为Data
+ (NSData *)encodedDataWithEncodingData:(NSData *)data;
/// 编码String为Data
+ (NSData *)encodedDataWithEncodingString:(NSString *)str;
/// 编码Data为String
+ (NSString *)encodedStringWithEncodingData:(NSData *)data;
/// 编码String为String
+ (NSString *)encodedStringWithEncodingString:(NSString *)str;

#pragma mark - Decode

/// 解码Data为Data
+ (NSData *)decodedDataWithEncodedData:(NSData *)data;
/// 解码String为Data
+ (NSData *)decodedDataWithEncodedString:(NSString *)str;
/// 解码Data为String
+ (NSString *)decodedStringWithEncodedData:(NSData *)data;
/// 解码String为String
+ (NSString *)decodedStringWithEncodedString:(NSString *)str;

#pragma mark - Other

/// 异或加密，一次加密，再次解密
+ (NSString *)XOR:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
