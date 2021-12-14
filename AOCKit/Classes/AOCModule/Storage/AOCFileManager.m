//
//  AOCFileManager.m
//  AOCKit
//
//  Created by pan on 2021/9/8.
//

#import "AOCFileManager.h"

@interface AOCFileManager ()

@end

@implementation AOCFileManager

+ (long)fileSizeWithPath:(NSString *)path {
    NSUInteger size = 0;
    if (path.length == 0) {
        return size;
    }
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDirectory;
    if (![manager fileExistsAtPath:path isDirectory:&isDirectory]) {
        return size;
    }
    if (isDirectory) {
        NSDirectoryEnumerator *fileEnumerator = [manager enumeratorAtPath:path];
        for (NSString *fileName in fileEnumerator) {
            NSString *filePath = [path stringByAppendingPathComponent:fileName];
            NSDictionary *attrs = [manager attributesOfItemAtPath:filePath error:nil];
            size += [attrs fileSize];
        }
    } else {
        NSDictionary *attributes = [manager attributesOfItemAtPath:path error:nil];
        size = [attributes fileSize];
    }
    return size;
}

@end
