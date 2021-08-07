//
//  AOCToolsUI.m
//  AOCKit
//
//  Created by pan on 2021/8/7.
//

#import "AOCToolsUI.h"

@implementation AOCToolsUI

// 获取当前Controller
+ (UIViewController *)currentViewController {
    return [self topViewControllerFrom:[UIApplication sharedApplication].keyWindow.rootViewController];
}

// 查找最上层Controller
+ (UIViewController *)topViewControllerFrom:(UIViewController *)controller {
    if (controller.presentedViewController) {
        controller = controller.presentedViewController;
    }
    if ([controller isKindOfClass:[UINavigationController class]]) {
        return [self topViewControllerFrom:[(UINavigationController *)controller topViewController]];
    } else if ([controller isKindOfClass:[UITabBarController class]]) {
        return [self topViewControllerFrom:[(UITabBarController *)controller selectedViewController]];
    } else {
        return controller;
    }
}

@end
