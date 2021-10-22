//
//  AOCRouteHandler.h
//  AOCKit
//
//  Created by pan on 2021/7/13.
//

#import <DeepLinkKit/DeepLinkKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCRouteHandler : DPLRouteHandler

/// 路由路径
+ (nullable NSString *)routerPath;

/// 路由目标控制器类
+ (nullable Class)routeController;
@end

NS_ASSUME_NONNULL_END
