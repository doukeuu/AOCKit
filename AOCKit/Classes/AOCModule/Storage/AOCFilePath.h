//
//  AOCFilePath.h
//  AOCKit
//
//  Created by pan on 2021/9/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCFilePath : NSObject

/// NSHomeDirectory
+ (NSString *)homePath;

/// NSDocumentDirectory
+ (NSString *)documentPath;

/// NSLibraryDirectory
+ (NSString *)libraryPath;

/// NSTemporaryDirectory
+ (NSString *)temporaryPath;

/// NSCachesDirectory
+ (NSString *)cachePath;

/// mainBundle bundlePath
+ (NSString *)bundlePath;

/// mainBundle resourcePath
+ (NSString *)resourcePath;

/// mainBundle executablePath
+ (NSString *)executablePath;

@end

NS_ASSUME_NONNULL_END
