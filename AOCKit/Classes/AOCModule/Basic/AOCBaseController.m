//
//  AOCBaseController.m
//  AOCKit
//
//  Created by ssbm on 2021/4/23.
//

#import "AOCBaseController.h"
#import "AOCNavigationController.h"
#import "AOCDefineColor.h"
#import "AOCDefineSize.h"

@interface AOCBaseController ()

@end

@implementation AOCBaseController

- (instancetype)init {
    if (self = [super init]) {
        [self initConfig];
    }
    return self;
}

// 初始化
- (void)initConfig {
    
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kCOLOR_VIEW_BG;
    
    self.navEffectView.hidden = NO;
    self.navLineView.hidden = NO;
    
    [self configView];
    [self configFrame];
    [self requestNet];
    [self bindAction];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.view bringSubviewToFront:self.navEffectView];
}

#pragma mark - Config Views

// 配置视图
- (void)configView {
    
}

// 约束布局
- (void)configFrame {
    
}

#pragma mark - Request Network

// 请求网络
- (void)requestNet {
    
}

#pragma mark - Bind Action

// 绑定操作
- (void)bindAction {
    
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
