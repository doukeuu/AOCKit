//
//  AOCBase64.m
//  AOCKit
//
//  Created by pan on 2021/7/30.
//

#import "AOCBase64.h"

@implementation AOCBase64

#pragma mark - Encode

+ (NSData *)encodedDataWithEncodingData:(NSData *)data {
    return [data base64EncodedDataWithOptions:0];
}

+ (NSData *)encodedDataWithEncodingString:(NSString *)str {
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedDataWithOptions:0];
}

+ (NSString *)encodedStringWithEncodingData:(NSData *)data {
    return [data base64EncodedStringWithOptions:0];
}

+ (NSString *)encodedStringWithEncodingString:(NSString *)str {
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

#pragma mark - Decode

+ (NSData *)decodedDataWithEncodedData:(NSData *)data {
    return [[NSData alloc] initWithBase64EncodedData:data options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

+ (NSData *)decodedDataWithEncodedString:(NSString *)str {
    return [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

+ (NSString *)decodedStringWithEncodedData:(NSData *)data {
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedData:data options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
}

+ (NSString *)decodedStringWithEncodedString:(NSString *)str {
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
}

#pragma mark - Other

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
