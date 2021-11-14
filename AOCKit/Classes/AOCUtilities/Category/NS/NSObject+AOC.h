//
//  NSObject+AOC.h
//  AOCKit
//
//  Created by pan on 2021/11/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AOC)

/// 执行某个对象的方法，可以消除原生perform方法的警告
+ (id)makeObject:(id)object executeSelector:(NSString *)selString;

/// 执行某个对象的方法，无返回值
+ (void)invokeTarget:(id)target selector:(NSString *)selString;

/// 执行某个对象的方法，无返回值，可以消除原生perform方法的警告
+ (void)executeObject:(id)object selector:(NSString *)selString;

/// 执行某个对象的方法(第一个Object)，无返回值，可以消除原生perform方法的警告
+ (void)executeObject:(id)object selector:(NSString *)selString object:(id)first;

/// 执行某个对象的方法，无返回值，可以消除原生perform方法的警告
+ (void)executeObject:(id)object selector:(NSString *)selString object:(id)first object:(id)second;
@end

NS_ASSUME_NONNULL_END
