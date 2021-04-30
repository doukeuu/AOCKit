//
//  NSBundle+AOC.m
//  AOCKit
//
//  Created by ssbm on 2021/4/29.
//

#import "NSBundle+AOC.h"
#import "AOCNavigationController.h"

@implementation NSBundle (AOC)

// 当前bundle文件
+ (instancetype)aocBundle {
    static NSBundle *aocBundle = nil;
    if (aocBundle == nil) {
        NSBundle *bundle = [NSBundle bundleForClass:[AOCNavigationController class]];
        NSString *path = [bundle pathForResource:@"AOCImage" ofType:@"bundle"];
        aocBundle = [NSBundle bundleWithPath:path];
    }
    return aocBundle;
}

@end
