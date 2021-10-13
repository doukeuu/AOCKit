//
//  AOCToolsNS.m
//  AOCKit
//
//  Created by pan on 2021/8/7.
//

#import "AOCToolsNS.h"

@implementation AOCToolsNS

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

@end
