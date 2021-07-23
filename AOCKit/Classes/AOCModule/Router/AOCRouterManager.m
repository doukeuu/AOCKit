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

static NSMutableArray *_handlerArray; // 路由处理类数组

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

#pragma mark - Property

+ (NSMutableArray<NSString *> *)handlerArray {
    if (!_handlerArray) {
        _handlerArray = [NSMutableArray array];
    }
    return _handlerArray;
}

- (DPLDeepLinkRouter *)router {
    if (!_router) {
        _router = [[DPLDeepLinkRouter alloc] init];
    }
    return _router;
}

#pragma mark - Hook AppDelegate

+ (void)routerCheckAppDelegateMethod {
    Class cls = NSClassFromString(@"AppDelegate");

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

+ (void)routerHookAppDelegateMethod {
    Class appDelegateCls = NSClassFromString(@"AppDelegate");
    
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

+ (void)routerRegistration {
    NSArray *handlerArray = AOCRouterManager.handlerArray;
    for (NSString *handlerName in handlerArray) {
        if (handlerName.length == 0) continue;
        
        Class handlerClass = NSClassFromString(handlerName);
        if (handlerClass == nil) continue;
        if (![handlerClass isSubclassOfClass:[AOCRouteHandler class]]) continue;
        
        NSString *route = [handlerClass routerPath];
        if (route.length == 0) continue;
        
        [AOCRouterManager sharedManager].router[route] = handlerClass;
    }
}

+ (void)handleRouteURL:(NSURL *)url completion:(AOCRouteCompletionBlock)completion {
    [[AOCRouterManager sharedManager].router handleURL:url withCompletion:completion];
}

+ (void)handleRouteActivity:(NSUserActivity *)userActivity completion:(AOCRouteCompletionBlock)completion {
    [[AOCRouterManager sharedManager].router handleUserActivity:userActivity withCompletion:completion];
}

+ (void)handleRoutePath:(NSString *)path completion:(AOCRouteCompletionBlock)completion {
    NSURL *url = [NSURL URLWithString:path];
    [self handleRouteURL:url completion:completion];
}

@end



#pragma mark - DPLTargetViewController

@interface UIViewController (Router) <DPLTargetViewController>

@end

@implementation UIViewController (Router)

- (void)configureWithDeepLink:(DPLDeepLink *)deepLink {

}

@end
