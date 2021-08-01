//
//  AOCCryptor.m
//  AOCKit
//
//  Created by pan on 2021/7/30.
//

#import "AOCCryptor.h"
#import "AOCBase64.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation AOCCryptor

// 字符串AES128加密，空字符串不加密
+ (NSString *)AES128EncryptString:(NSString *)str key:(NSString *)key {
    if (str.length == 0) return str;
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *outData = [self cryptData:data secretKey:keyData
                            operation:kCCEncrypt algorithm:kCCAlgorithmAES
                              options:kCCOptionPKCS7Padding size:kCCKeySizeAES128];
    
    if (outData != data) {
        return [AOCBase64 encodedStringWithEncodingData:outData];
    } else {
        return str;
    }
}

// 字符串AES128解密
+ (NSString *)AES128DecryptString:(NSString *)str key:(NSString *)key {
    if (str.length == 0) return str;
    
    NSData *data = [AOCBase64 decodedDataWithEncodedString:str];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *outData = [self cryptData:data secretKey:keyData
                            operation:kCCDecrypt algorithm:kCCAlgorithmAES
                              options:kCCOptionPKCS7Padding size:kCCKeySizeAES128];
    
    if (outData != data) {
        return [[NSString alloc] initWithData:outData encoding:NSUTF8StringEncoding];
    } else {
        return str;
    }
}

// 字符串DES加密，空字符串不加密
+ (NSString *)DESEncryptString:(NSString *)str key:(NSString *)key {
    if (str.length == 0) return str;
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *outData = [self cryptData:data secretKey:keyData
                            operation:kCCEncrypt algorithm:kCCAlgorithmDES
                              options:kCCOptionPKCS7Padding size:kCCKeySizeDES];
    
    if (outData != data) {
        return [AOCBase64 encodedStringWithEncodingData:outData];
    } else {
        return str;
    }
}

// 字符串DES解密
+ (NSString *)DESDecryptString:(NSString *)str key:(NSString *)key {
    if (str.length == 0) return str;
    
    NSData *data = [AOCBase64 decodedDataWithEncodedString:str];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *outData = [self cryptData:data secretKey:keyData
                            operation:kCCDecrypt algorithm:kCCAlgorithmDES
                              options:kCCOptionPKCS7Padding size:kCCKeySizeDES];
    
    if (outData != data) {
        return [[NSString alloc] initWithData:outData encoding:NSUTF8StringEncoding];
    } else {
        return str;
    }
}

// 加密/解密 CCCrypt函数封装方法
+ (NSData *)cryptData:(NSData *)data secretKey:(NSData *)secretKey operation:(CCOperation)operation
              algorithm:(CCAlgorithm)algorithm options:(CCOptions)options size:(size_t)size  {
    
    if (data.length == 0) return data;
    
    const void *dataIn  = data.bytes;
    size_t dataInLength = (size_t)data.length;
    const void *key     = secretKey.bytes; // 密钥
    
    size_t dataOutAvailable = (dataInLength + size);
    uint8_t *dataOut = malloc(dataOutAvailable * sizeof(uint8_t));
    memset(dataOut, 00, dataOutAvailable); //将已开辟内存空间buffer的首 1 个字节的值设为值 0
    
    size_t dataOUtMoved;
    CCCryptorStatus status;
    
    status = CCCrypt(                  // CCCrypt函数
                     operation,        // 加密/解密
                     algorithm,        // 根据哪个标准（des，3des，aes。。。。）
                     options,          // 偏移量
                     key,              // 密钥
                     size,             // 匹配算法大小
                     NULL,             // 可选的初始矢量
                     dataIn,           // 数据的存储单元
                     dataInLength,     // 数据的大小
                     dataOut,          // 返回的数据存储单元
                     dataOutAvailable, // 缓存大小
                     &dataOUtMoved     // 若成功，返回加密/解密后的数据大小， 若缓存太小，返回缺失的大小
                     );
    
    NSData *result;
    if (status == kCCSuccess) {
        result = [NSData dataWithBytes:dataOut length:dataOUtMoved];
    } else {
        result = data;
        NSLog(@" Error: CCCrypt status %d", status);
    }
    
    free(dataOut);
    return result;
}

@end
