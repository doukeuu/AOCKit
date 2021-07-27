//
//  AOCEncryptionMD5.m
//  AOCKit
//
//  Created by ssbm on 2021/7/27.
//

#import "AOCEncryptionMD5.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation AOCEncryptionMD5

#pragma mark - MD5

+ (BOOL)verifyString:(NSString *)string withSign:(NSString *)signString {
    return [signString isEqualToString:[self MD5:string]];
}

+ (NSString *)MD5:(NSString *)string {
    
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return [result uppercaseString];
}

@end
