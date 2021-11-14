//
//  AOCToolsNS.h
//  AOCKit
//
//  Created by pan on 2021/8/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCToolsNS : NSObject

/// 判断对象是否为空、NULL、nil
+ (BOOL)isBlank:(id)obj;

/// 字符串是否为空
+ (BOOL)isEmpty:(NSString * _Nullable)string;

/// 生成UUID
+ (NSString *)generateUUID;

@end

NS_ASSUME_NONNULL_END
