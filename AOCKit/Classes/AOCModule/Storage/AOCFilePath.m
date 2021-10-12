//
//  AOCFilePath.m
//  AOCKit
//
//  Created by pan on 2021/9/8.
//

#import "AOCFilePath.h"

@implementation AOCFilePath

+ (NSString *)homePath {
    return NSHomeDirectory();
}

+ (NSString *)documentPath {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [pathArray objectAtIndex:0];
}

+ (NSString *)libraryPath {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [pathArray objectAtIndex:0];
}

+ (NSString *)temporaryPath {
    return NSTemporaryDirectory();
}

+ (NSString *)cachePath {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [pathArray objectAtIndex:0];
}

+ (NSString *)bundlePath {
    return [[NSBundle mainBundle] bundlePath];
}

+ (NSString *)resourcePath {
    return [[NSBundle mainBundle] resourcePath];
}

+ (NSString *)executablePath {
    return [[NSBundle mainBundle] executablePath];
}

@end
