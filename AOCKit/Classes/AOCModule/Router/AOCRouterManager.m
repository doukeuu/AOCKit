//
//  AOCRouterManager.m
//  AOCKit
//
//  Created by pan on 2021/7/11.
//

#import "AOCRouterManager.h"
#import "AOCRouteHandler.h"
#import <objc/runtime.h>
#import <Aspects/Aspects.h>
#import <DeepLinkKit/DeepLinkKit.h>

@interface AOCRouterManager ()

@property (nonatomic, strong) DPLDeepLinkRouter *router; // 路由
@end

@implementation AOCRouterManager

#pragma mark - initial

+ (void)load {
    [super load];
    [self routerCheckAppDelegateMethod];
    [self routerHookAppDelegateMethod];
}

+ (instancetype)sharedManager {
    static AOCRouterManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

+ (void)handleRoute:(Class)handlerClass completion:(AOCRouteCompletionBlock)completion {
    [self handleRoute:handlerClass queryParameters:@{} completion:completion];
}

+ (void)handleRoute:(Class)handlerClass queryParameters:(NSDictionary *)parameters completion:(AOCRouteCompletionBlock)completion {
    if (![handlerClass isSubclassOfClass:[AOCRouteHandler class]]) {
        if (completion) {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: @"路由处理类错误"};
            completion(NO, [NSError errorWithDomain:DPLErrorDomain code:DPLRouteNotFoundError userInfo:userInfo]);
        }
        return;
    }
    NSString *path = [handlerClass routerPath];
    if (path.length == 0) {
        if (completion) {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: @"路由路径不能为空"};
            completion(NO, [NSError errorWithDomain:DPLErrorDomain code:DPLRouteNotFoundError userInfo:userInfo]);
        }
        return;
    }
    DPLMutableDeepLink *deepLink = [[DPLMutableDeepLink alloc] initWithString:path];
    if (parameters != nil && parameters.count > 0) {
        [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            deepLink[key] = obj;
        }];
    }
    [self handleRouteURL:deepLink.URL completion:completion];
}

#pragma mark - Property

// 路由
- (DPLDeepLinkRouter *)router {
    if (!_router) {
        _router = [[DPLDeepLinkRouter alloc] init];
    }
    return _router;
}

#pragma mark - Hook AppDelegate

// AppDelegate类名
+ (Class)appDelegateClass {
    return NSClassFromString(@"AppDelegate");
}

// 检测是否存在AppDelegate方法
+ (void)routerCheckAppDelegateMethod {
    Class cls = [self appDelegateClass];

    SEL cmd1 = @selector(application:openURL:options:);
    SEL cmd2 = @selector(application:continueUserActivity:restorationHandler:);

    Method method1 = class_getInstanceMethod(cls, cmd1);
    Method method2 = class_getInstanceMethod(cls, cmd2);

    IMP imp1 = class_getMethodImplementation(self, cmd1);
    IMP imp2 = class_getMethodImplementation(self, cmd2);

    if (!method1 && imp1) {
        class_addMethod(cls, cmd1, imp1, "i@:@@@");
    }
    if (!method2 && imp2) {
        class_addMethod(cls, cmd2, imp2, "i@:@@@");
    }
}

// 替换AppDelegate方法
+ (void)routerHookAppDelegateMethod {
    Class appDelegateCls = [self appDelegateClass];
    
    [appDelegateCls
     aspect_hookSelector:@selector(application:didFinishLaunchingWithOptions:)
     withOptions:AspectPositionAfter
     usingBlock:^(id<AspectInfo> aspectInfo, id application, id launchOptions) {
        [AOCRouterManager routerRegistration];
    } error:NULL];
    
    [appDelegateCls
     aspect_hookSelector:@selector(application:openURL:options:)
     withOptions:AspectPositionAfter
     usingBlock:^(id<AspectInfo> aspectInfo, id application, id url, id options) {
        [AOCRouterManager handleRouteURL:url completion:nil];
    } error:NULL];
    
    [appDelegateCls
     aspect_hookSelector:@selector(application:continueUserActivity:restorationHandler:)
     withOptions:AspectPositionAfter
     usingBlock:^(id<AspectInfo> aspectInfo, id application, id userActivity, id handler) {
        [AOCRouterManager handleRouteActivity:userActivity completion:nil];
    } error:NULL];
}

- (BOOL)application:(id)app openURL:(id)url options:(id)options {
    return YES;
}

- (BOOL)application:(id)application continueUserActivity:(id)userActivity restorationHandler:(id)restorationHandler {
    return YES;
}

#pragma mark - Router Register

// 注册路径
+ (void)routerRegistration {
    unsigned int count;
    const char **classes;
    
    Class appDelegateCls = [self appDelegateClass];
    const char *image = class_getImageName(appDelegateCls);
    classes = objc_copyClassNamesForImage(image, &count);

    for (int i = 0; i < count; i ++) {
        NSString *className = [NSString stringWithCString:classes[i] encoding:NSUTF8StringEncoding];
        Class class = NSClassFromString(className);
        if ([class isSubclassOfClass:[AOCRouteHandler class]]) {
            NSString *route = [class routerPath];
            if (route.length == 0) continue;
            [AOCRouterManager sharedManager].router[route] = class;
        }
    }
}

+ (void)handleRouteURL:(NSURL *)url completion:(AOCRouteCompletionBlock)completion {
    [[AOCRouterManager sharedManager].router handleURL:url withCompletion:completion];
}

+ (void)handleRouteActivity:(NSUserActivity *)userActivity completion:(AOCRouteCompletionBlock)completion {
    [[AOCRouterManager sharedManager].router handleUserActivity:userActivity withCompletion:completion];
}

@end



#pragma mark - DPLTargetViewController

@interface UIViewController (Router) <DPLTargetViewController>

@end

@implementation UIViewController (Router)

- (void)configureWithDeepLink:(DPLDeepLink *)deepLink {

}

@end
