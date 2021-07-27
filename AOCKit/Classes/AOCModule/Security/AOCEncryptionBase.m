//
//  AOCEncryptionBase.m
//  AOCKit
//
//  Created by ssbm on 2021/7/27.
//

#import "AOCEncryptionBase.h"

@implementation AOCEncryptionBase

// base64编码NSData数据
+ (NSString *)base64EncodingData:(NSData *)data {
    return [data base64EncodedStringWithOptions:0];
}

// base64解码NSData数据
+ (NSString *)base64DecodingData:(NSData *)data {
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedData:data options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
}

// base64编码字符串
+ (NSString *)base64EncodingString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

// base64解码字符串
+ (NSString *)base64DecodingString:(NSString *)string {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

// 异或加密，一次加密，再次解密
+ (NSString *)XOR:(NSString *)string {
    NSData *originalData = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *sourceDataPoint = (Byte *)[originalData bytes];
    for (int i = 0; i < originalData.length; i++) {
        // 与(&)、非(~)、或(|)、异或(^)
        sourceDataPoint[i] ^= 1;
    }
    return [[NSString alloc] initWithData:originalData encoding:NSUTF8StringEncoding];
}

@end
