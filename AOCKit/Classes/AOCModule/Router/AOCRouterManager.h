//
//  AOCRouterManager.h
//  AOCKit
//
//  Created by pan on 2021/7/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kRouteCallbackURL  @"dpl_callback_url"

/// 路由跳转处理完成回调
typedef void(^AOCRouteCompletionBlock)(BOOL handled, NSError * _Nullable error);



@interface AOCRouterManager : NSObject

/// 单例
+ (instancetype)sharedManager;

/// 用于App内部直通过路径接跳转
/// @param handlerClass 路由处理类
/// @param completion 跳转完成后回调
+ (void)handleRoute:(Class)handlerClass completion:(nullable AOCRouteCompletionBlock)completion;

/// 用于App内部直通过路径接跳转
/// @param handlerClass 路由处理类
/// @param parameters 路径传参
/// @param completion 跳转完成后回调
+ (void)handleRoute:(Class)handlerClass queryParameters:(NSDictionary *)parameters completion:(nullable AOCRouteCompletionBlock)completion;
@end

NS_ASSUME_NONNULL_END
