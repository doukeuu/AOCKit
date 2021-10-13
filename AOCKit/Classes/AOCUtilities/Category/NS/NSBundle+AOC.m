//
//  NSBundle+AOC.m
//  AOCKit
//
//  Created by ssbm on 2021/4/29.
//

#import "NSBundle+AOC.h"
#import "AOCDevice.h"

@implementation NSBundle (AOC)

// 当前bundle文件
+ (instancetype)aocBundle {
    static NSBundle *aocBundle = nil;
    if (aocBundle == nil) {
        NSBundle *bundle = [NSBundle bundleForClass:[AOCDevice class]];
        NSString *path = [bundle pathForResource:@"AOCImage" ofType:@"bundle"];
        aocBundle = [NSBundle bundleWithPath:path];
    }
    return aocBundle;
}

// URL scheme
+ (NSString *)appScheme {
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    NSArray *urlTypes = dict[@"CFBundleURLTypes"];
    NSDictionary *firstTypeInfo = urlTypes.firstObject;
    NSArray *schemes = firstTypeInfo[@"CFBundleURLSchemes"];
    return schemes.firstObject;
}

// URL identifier
+ (NSString *)appIdentifier {
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    NSArray *urlTypes = dict[@"CFBundleURLTypes"];
    NSDictionary *firstTypeInfo = urlTypes.firstObject;
    return firstTypeInfo[@"CFBundleURLName"];
}

@end
