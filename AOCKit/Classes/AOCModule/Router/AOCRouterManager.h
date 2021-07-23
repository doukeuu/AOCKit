//
//  AOCRouterManager.h
//  AOCKit
//
//  Created by pan on 2021/7/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 路由处理完成回调
typedef void(^AOCRouteCompletionBlock)(BOOL handled, NSError * _Nullable error);


@interface AOCRouterManager : NSObject

/// 路由处理类数组
@property (nonatomic, strong, class, readonly) NSMutableArray<NSString *> *handlerArray;

/// 单例
+ (instancetype)sharedManager;

/// 用于App内部直通过路径接跳转
/// @param path 路由路径
/// @param completion 完成回调
+ (void)handleRoutePath:(NSString *)path completion:(nullable AOCRouteCompletionBlock)completion;
@end

NS_ASSUME_NONNULL_END
