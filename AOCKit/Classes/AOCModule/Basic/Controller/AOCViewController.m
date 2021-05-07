//
//  AOCViewController.m
//  AOCKit
//
//  Created by ssbm on 2021/5/7.
//

#import "AOCViewController.h"
#import "AOCNavigationController.h"
#import "AOCDefineColor.h"
#import "AOCDefineSize.h"

@interface AOCViewController ()

@end

@implementation AOCViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kCOLOR_VIEW_BG;
    // 返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"   "
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    
    self.navEffectView.hidden = NO;
    self.navLineView.hidden = NO;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.view bringSubviewToFront:self.navEffectView];
}

#pragma mark - Setter

// 侧滑手势响应开关
- (void)setPopGestureEnabled:(BOOL)popGestureEnabled {
    _popGestureEnabled = popGestureEnabled;
    if ([self.navigationController isKindOfClass:[AOCNavigationController class]]) {
        AOCNavigationController *navigation = (AOCNavigationController *)self.navigationController;
        navigation.popGestureEnabled = _popGestureEnabled;
    }
}

// 导航栏标题色
- (void)setNavTitleColor:(UIColor *)navTitleColor {
    _navTitleColor = navTitleColor;
    UINavigationBar *bar = self.navigationController.navigationBar;
    if (navTitleColor != nil) {
        bar.titleTextAttributes = @{NSForegroundColorAttributeName: navTitleColor};
    } else {
        bar.titleTextAttributes = @{NSForegroundColorAttributeName: kCOLOR_NAV_TITLE};
    }
}

#pragma mark - Getter

// 导航栏位置背景模糊视图
- (UIVisualEffectView *)navEffectView {
    if (_navEffectView) return _navEffectView;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _navEffectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    _navEffectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_H);
    _navEffectView.contentView.backgroundColor = kCOLOR_NAV_BACK;
    [self.view addSubview:_navEffectView];
    return _navEffectView;
}

// 导航栏位置分割线图片视图
- (UIImageView *)navLineView {
    if (_navLineView) return _navLineView;
    CGRect rect = CGRectMake(0, NAVIGATION_H - 1, SCREEN_WIDTH, 1);
    _navLineView = [[UIImageView alloc] initWithFrame:rect];
    _navLineView.backgroundColor = kCOLOR_NAV_LINE;
    [self.navEffectView.contentView addSubview:_navLineView];
    return _navLineView;
}

@end
