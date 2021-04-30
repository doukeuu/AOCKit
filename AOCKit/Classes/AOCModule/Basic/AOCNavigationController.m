//
//  AOCNavigationController.m
//  AOCKit
//
//  Created by ssbm on 2021/4/23.
//

#import "AOCNavigationController.h"
#import "AOCDefineFont.h"
#import "AOCDefineColor.h"
#import "UIImage+AOC.h"
#import "NSBundle+AOC.h"

@interface AOCNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation AOCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    self.popGestureEnabled = YES;
    
    [self configNavigationBar];
}

// 状态栏颜色设置的一部分
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

// 隐藏tabBar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - Style

// 配置导航栏背景
- (void)configNavigationBar {
    // 背景设置为透明图片
    UIImage *backImage = [UIImage imageFromColor:UIColor.clearColor];
    [self.navigationBar setShadowImage:backImage];
    [self.navigationBar setBackgroundImage:backImage forBarMetrics:UIBarMetricsDefault];
        
    // 返回按钮样式
    UIImage *indicator = [UIImage imageNamed:@"arrow_back_black"
                                    inBundle:[NSBundle aocBundle]
               compatibleWithTraitCollection:nil];
    indicator = [indicator imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationBar.backIndicatorImage = indicator;
    self.navigationBar.backIndicatorTransitionMaskImage = indicator;
    
    // 返回按钮文字移出屏幕
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, 0)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    // 标题样式
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor blackColor];
    NSDictionary *attributes = @{NSFontAttributeName :kFONT_NAV_TITLE,
                                 NSShadowAttributeName:shadow,
                                 NSForegroundColorAttributeName:kCOLOR_NAV_TITLE};
    self.navigationBar.titleTextAttributes = attributes;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count > 1 && self.popGestureEnabled;
}

@end
