//
//  AOCDigest.m
//  AOCKit
//
//  Created by pan on 2021/7/30.
//

#import "AOCDigest.h"
#import <CommonCrypto/CommonDigest.h>

@implementation AOCDigest

#pragma mark - String MD5

// 字符串MD5值
+ (NSString *)MD5:(NSString *)str {
    if (str == nil || [str length] == 0) return nil;
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSUInteger len = CC_MD5_DIGEST_LENGTH * 2;
    NSMutableString *result = [NSMutableString stringWithCapacity:len];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return [result uppercaseString];
}

// 字符串MD4值
+ (NSString *)MD4:(NSString *)str {
    if (str == nil || [str length] == 0) return nil;
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD4_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSUInteger len = CC_MD4_DIGEST_LENGTH * 2;
    NSMutableString *result = [NSMutableString stringWithCapacity:len];
    for(int i = 0; i < CC_MD4_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return [result uppercaseString];
}

// 字符串MD2值
+ (NSString *)MD2:(NSString *)str {
    if (str == nil || [str length] == 0) return nil;
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD2_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSUInteger len = CC_MD2_DIGEST_LENGTH * 2;
    NSMutableString *result = [NSMutableString stringWithCapacity:len];
    for(int i = 0; i < CC_MD2_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return [result uppercaseString];
}

#pragma mark - Data MD5

// 数据MD5值
+ (NSData *)MD5Data:(NSData *)data {
    if (data == nil) return nil;
    unsigned char hash[CC_MD5_DIGEST_LENGTH];
    (void) CC_MD5([data bytes], (CC_LONG)[data length], hash);
    return ([NSData dataWithBytes: hash length: CC_MD5_DIGEST_LENGTH]);
}

// 数据MD4值
+ (NSData *)MD4Data:(NSData *)data {
    if (data == nil) return nil;
    unsigned char hash[CC_MD4_DIGEST_LENGTH];
    (void) CC_MD4([data bytes], (CC_LONG)[data length], hash);
    return ([NSData dataWithBytes: hash length: CC_MD4_DIGEST_LENGTH]);
}

// 数据MD2值
+ (NSData *)MD2Data:(NSData *)data {
    if (data == nil) return nil;
    unsigned char hash[CC_MD2_DIGEST_LENGTH];
    (void) CC_MD2([data bytes], (CC_LONG)[data length], hash);
    return ([NSData dataWithBytes: hash length: CC_MD2_DIGEST_LENGTH]);
}

#pragma mark - String SHA

+ (NSString *)SHA1:(NSString *)str {
    if (str == nil || [str length] == 0) return nil;
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSUInteger len = CC_SHA1_DIGEST_LENGTH * 2;
    NSMutableString *ms = [NSMutableString stringWithCapacity:len];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    return [ms uppercaseString];
}

+ (NSString *)SHA224:(NSString *)str {
    if (str == nil || [str length] == 0) return nil;
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_SHA224_DIGEST_LENGTH];
    CC_SHA1(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSUInteger len = CC_SHA224_DIGEST_LENGTH * 2;
    NSMutableString *ms = [NSMutableString stringWithCapacity:len];
    for (int i = 0; i < CC_SHA224_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    return [ms uppercaseString];
}

+ (NSString *)SHA256:(NSString *)str {
    if (str == nil || [str length] == 0) return nil;
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA1(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSUInteger len = CC_SHA256_DIGEST_LENGTH * 2;
    NSMutableString *ms = [NSMutableString stringWithCapacity:len];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    return [ms uppercaseString];
}

+ (NSString *)SHA384:(NSString *)str {
    if (str == nil || [str length] == 0) return nil;
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_SHA384_DIGEST_LENGTH];
    CC_SHA1(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSUInteger len = CC_SHA384_DIGEST_LENGTH * 2;
    NSMutableString *ms = [NSMutableString stringWithCapacity:len];
    for (int i = 0; i < CC_SHA384_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    return [ms uppercaseString];
}

+ (NSString *)SHA512:(NSString *)str {
    if (str == nil || [str length] == 0) return nil;
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA1(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSUInteger len = CC_SHA512_DIGEST_LENGTH * 2;
    NSMutableString *ms = [NSMutableString stringWithCapacity:len];
    for (int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    return [ms uppercaseString];
}

#pragma mark - Data SHA

+ (NSData *)SHA1Data:(NSData *)data {
    if (data == nil) return nil;
    unsigned char hash[CC_SHA1_DIGEST_LENGTH];
    (void) CC_SHA1( [data bytes], (CC_LONG)[data length], hash );
    return ( [NSData dataWithBytes: hash length: CC_SHA1_DIGEST_LENGTH] );
}

+ (NSData *)SHA224Data:(NSData *)data {
    if (data == nil) return nil;
    unsigned char hash[CC_SHA224_DIGEST_LENGTH];
    (void) CC_SHA224( [data bytes], (CC_LONG)[data length], hash );
    return ( [NSData dataWithBytes: hash length: CC_SHA224_DIGEST_LENGTH] );
}

+ (NSData *)SHA256Data:(NSData *)data {
    if (data == nil) return nil;
    unsigned char hash[CC_SHA256_DIGEST_LENGTH];
    (void) CC_SHA256( [data bytes], (CC_LONG)[data length], hash );
    return ( [NSData dataWithBytes: hash length: CC_SHA256_DIGEST_LENGTH] );
}

+ (NSData *)SHA384Data:(NSData *)data {
    if (data == nil) return nil;
    unsigned char hash[CC_SHA384_DIGEST_LENGTH];
    (void) CC_SHA384( [data bytes], (CC_LONG)[data length], hash );
    return ( [NSData dataWithBytes: hash length: CC_SHA384_DIGEST_LENGTH] );
}

+ (NSData *)SHA512Data:(NSData *)data {
    if (data == nil) return nil;
    unsigned char hash[CC_SHA512_DIGEST_LENGTH];
    (void) CC_SHA512( [data bytes], (CC_LONG)[data length], hash );
    return ( [NSData dataWithBytes: hash length: CC_SHA512_DIGEST_LENGTH] );
}

@end
