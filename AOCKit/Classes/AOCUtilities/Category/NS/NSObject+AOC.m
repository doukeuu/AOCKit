//
//  NSObject+AOC.m
//  AOCKit
//
//  Created by pan on 2021/11/13.
//

#import "NSObject+AOC.h"

@implementation NSObject (AOC)

// 执行某个对象的方法，有返回值，可以消除原生perform方法的警告
+ (id)makeObject:(id)object executeSelector:(NSString *)selString {
    if (!object || !selString) return nil;
    SEL sel = NSSelectorFromString(selString);
    if (![object respondsToSelector:sel]) return nil;
    IMP imp = [object methodForSelector:sel];
    id (* performMethod)(id, SEL) = (void *)imp; // 函数指针
    return performMethod(object, sel);
}

// 执行某个对象的方法，无返回值
+ (void)invokeTarget:(id)target selector:(NSString *)selString {
    if (!target || !selString) return;
    SEL sel = NSSelectorFromString(selString);
    if (![target respondsToSelector:sel]) return;
    NSMethodSignature *signature = [target methodSignatureForSelector:sel];
    if (!signature) return;
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = target;
    invocation.selector = sel;
    [invocation invoke];
}

// 执行某个对象的方法，无返回值，可以消除原生perform方法的警告
+ (void)executeObject:(id)object selector:(NSString *)selString {
    if (!object || !selString) return;
    SEL sel = NSSelectorFromString(selString);
    if (![object respondsToSelector:sel]) return;
    IMP imp = [object methodForSelector:sel];
    void (* executeMethod)(id, SEL) = (void *)imp; // 函数指针
    executeMethod(object, sel);
}

// 执行某个对象的方法(第一个Object)，无返回值，可以消除原生perform方法的警告
+ (void)executeObject:(id)object selector:(NSString *)selString object:(id)first {
    if (!object || !selString) return;
    SEL sel = NSSelectorFromString(selString);
    if (![object respondsToSelector:sel]) return;
    IMP imp = [object methodForSelector:sel];
    void (* executeMethod)(id, SEL, id) = (void *)imp; // 函数指针
    executeMethod(object, sel, first);
}

// 执行某个对象的方法(第一个Object)，无返回值，可以消除原生perform方法的警告
+ (void)executeObject:(id)object selector:(NSString *)selString object:(id)first object:(id)second {
    if (!object || !selString) return;
    SEL sel = NSSelectorFromString(selString);
    if (![object respondsToSelector:sel]) return;
    IMP imp = [object methodForSelector:sel];
    void (* executeMethod)(id, SEL, id, id) = (void *)imp; // 函数指针
    executeMethod(object, sel, first, second);
}

@end
