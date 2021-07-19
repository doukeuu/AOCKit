//
//  AOCRouteHandler.m
//  AOCKit
//
//  Created by pan on 2021/7/13.
//

#import "AOCRouteHandler.h"

@implementation AOCRouteHandler

// 路由路径
+ (NSString *)routerPath {
    return nil;
}

// 路由目标控制器名称
+ (NSString *)routeController {
    return nil;
}

- (UIViewController <DPLTargetViewController> *)targetViewController {
    NSString *controllerName = [[self class] routeController];
    if (controllerName.length == 0) return nil;
    
    Class controllerClass = NSClassFromString(controllerName);
    if (controllerClass == nil) return nil;
    if (![controllerClass isSubclassOfClass:[UIViewController class]]) return nil;
    
    return [[controllerClass alloc] init];
}

- (UIViewController *)viewControllerForPresentingDeepLink:(DPLDeepLink *)deepLink {
    return [super viewControllerForPresentingDeepLink:deepLink];
}

- (void)presentTargetViewController:(UIViewController <DPLTargetViewController> *)targetViewController
                   inViewController:(UIViewController *)presentingViewController {
    
    if ([self preferModalPresentation] ||
        ![presentingViewController isKindOfClass:[UINavigationController class]]) {
        
        targetViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [presentingViewController presentViewController:targetViewController animated:NO completion:NULL];
        
    } else if ([presentingViewController isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController *nav = (UINavigationController *)presentingViewController;
        [self navigationController:nav placeTargetViewController:targetViewController];
    }
    
}

- (void)navigationController:(UINavigationController *)nav placeTargetViewController:(UIViewController *)target {
    if ([nav.viewControllers containsObject:target]) {
        [nav popToViewController:target animated:YES];
        
    } else {
        for (UIViewController *controller in nav.viewControllers) {
            if ([controller isMemberOfClass:[target class]]) {
                
                [nav popToViewController:controller animated:NO];
                [nav popViewControllerAnimated:NO];
                
                if ([controller isEqual:nav.topViewController]) {
                    [nav setViewControllers:@[target] animated:NO];
                }
                break;
            }
        }
        if (![nav.topViewController isEqual:target]) {
            [nav pushViewController:target animated:YES];
        }
    }
}

@end



@implementation UIViewController (Router)

- (void)configureWithDeepLink:(DPLDeepLink *)deepLink {

}

@end
