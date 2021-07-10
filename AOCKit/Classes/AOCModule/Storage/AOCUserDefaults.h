//
//  AOCUserDefaults.h
//  AOCKit
//
//  Created by pan on 2021/7/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCUserDefaults : NSObject

/// 单例
+ (instancetype)standardDefaults;

/// NSUserDefaults文件名称
- (NSString *)suiteNameForUserDefaults;

/// NSUserDefaults registerDefaults
- (NSDictionary<NSString *, id> *)registrationDictionary;

/// 存储时防止重名而设置的key前缀
- (NSString *)prefixForKey;

/// 字典中的key是属性名，value是从存储中取值用的key
- (NSDictionary<NSString *, NSString *> *)replacedKeysFromPropertyName;

/// 当有已存储的类需要在解码时转换类名，字典中的key是旧类名，value是转换后的类名
- (NSDictionary<NSString *, NSString *> *)replacedClassFromClassName;
@end

NS_ASSUME_NONNULL_END
