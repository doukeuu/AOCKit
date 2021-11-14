//
//  AOCToolsNS.m
//  AOCKit
//
//  Created by pan on 2021/8/7.
//

#import "AOCToolsNS.h"

@implementation AOCToolsNS

// 判断对象是否为空、NULL、nil
+ (BOOL)isBlank:(id)obj {
    if(obj == [NSNull null] || obj == nil) return YES;
    if([obj isKindOfClass:[NSArray class]])
        return [obj count] == 0;
    if([obj isKindOfClass:[NSDictionary class]])
        return [obj count] == 0;
    if([obj isKindOfClass:[NSData class]])
        return [obj length] == 0;
    if([obj isKindOfClass:[NSString class]])
        return [obj length] == 0;
    return NO;
}

// 字符串是否为空
+ (BOOL)isEmpty:(NSString *)string {
    if (!string || [string isEqual:[NSNull null]]) {
        return YES;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [string stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0 || [trimedString isEqualToString:@"(null)"]) {
            return YES;
        } else {
            return NO;
        }
    }
}

// 生成UUID
+ (NSString *)generateUUID {
    CFUUIDRef UUID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef UUIDString = CFUUIDCreateString(kCFAllocatorDefault, UUID);
    NSString *result = [[NSString alloc] initWithString:(__bridge NSString *)UUIDString];
    CFRelease(UUID);
    CFRelease(UUIDString);
    return result;
}

@end
