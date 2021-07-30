//
//  AOCBase64.h
//  AOCKit
//
//  Created by pan on 2021/7/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCBase64 : NSObject

/// base64编码NSData数据
+ (NSString *)base64EncodingData:(NSData *)data;

/// base64解码NSData数据
+ (NSString *)base64DecodingData:(NSData *)data;

/// base64编码字符串
+ (NSString *)base64EncodingString:(NSString *)string;

/// base64解码字符串
+ (NSString *)base64DecodingString:(NSString *)string;

/// 异或加密，一次加密，再次解密
+ (NSString *)XOR:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
