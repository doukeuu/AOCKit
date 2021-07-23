//
//  AOCRouteHandler.h
//  AOCKit
//
//  Created by pan on 2021/7/13.
//

#import <DeepLinkKit/DPLRouteHandler.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCRouteHandler : DPLRouteHandler

/// 路由路径
+ (NSString *)routerPath;

/// 路由目标控制器名称
+ (NSString *)routeController;
@end

NS_ASSUME_NONNULL_END
