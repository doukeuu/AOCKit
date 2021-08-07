//
//  AOCTabBarController.m
//  AOCKit
//
//  Created by ssbm on 2021/4/23.
//

#import "AOCTabBarController.h"
#import "AOCDefineColor.h"
#import "AOCDefineFont.h"
#import "AOCDefineSize.h"
#import "UIImage+AOC.h"

@interface AOCTabBarController ()

@end

@implementation AOCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kCOLOR_VIEW_BG;
    // 返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"   "
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    
    self.tabEffectView.hidden = NO;
    self.tabLineView.hidden = NO;
    
    [self configTabBar];
}

// 生成tabBarItem
- (UITabBarItem *)tabBarItemWithTitle:(NSString *)title normalImage:(NSString *)normal selectedImage:(NSString *)selected {
    UIImage *normalImage = [[UIImage imageNamed:normal] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:selected] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectedImage];
    item.titlePositionAdjustment = UIOffsetMake(0, -1);
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor blackColor];
    NSDictionary *normalAttributes = @{NSForegroundColorAttributeName: kCOLOR_TAB_TITLE_N,
                                       NSFontAttributeName: kFONT_TAB_TITLE,
                                       NSShadowAttributeName: shadow};
    NSDictionary *selectedAttributes = @{NSForegroundColorAttributeName: kCOLOR_TAB_TITLE_S,
                                         NSFontAttributeName: kFONT_TAB_TITLE,
                                         NSShadowAttributeName: shadow};
    [item setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
    return item;
}

#pragma mark - Style

// 配置TabBar
- (void)configTabBar {
    // TabBar背景透明
    UIImage *backImage = [UIImage imageWithColor:UIColor.clearColor];
    self.tabBar.backgroundImage = backImage;
    self.tabBar.shadowImage = backImage;
}

#pragma mark - Getter

// 导航栏位置背景模糊视图
- (UIVisualEffectView *)tabEffectView {
    if (_tabEffectView) return _tabEffectView;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _tabEffectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    _tabEffectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, TAB_BAR_HEIGHT);
    _tabEffectView.contentView.backgroundColor = kCOLOR_TAB_BACK;
    [self.tabBar insertSubview:_tabEffectView atIndex:0];
    return _tabEffectView;
}

// 导航栏位置分割线图片视图
- (UIImageView *)tabLineView {
    if (_tabLineView) return _tabLineView;
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 1);
    _tabLineView = [[UIImageView alloc] initWithFrame:rect];
    _tabLineView.backgroundColor = kCOLOR_TAB_LINE;
    [self.tabEffectView.contentView addSubview:_tabLineView];
    return _tabLineView;
}

@end
