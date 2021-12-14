//
//  AOCFileManager.h
//  AOCKit
//
//  Created by pan on 2021/9/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCFileManager : NSObject

/// 根据路径获取文件或文件夹的大小
+ (long)fileSizeWithPath:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
