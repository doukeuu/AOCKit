//
//  EFATabBarController.m
//  AOCKit_Example
//
//  Created by ssbm on 2021/5/6.
//  Copyright © 2021 pan. All rights reserved.
//

#import "EFATabBarController.h"
#import "EFAViewController.h"
#import "EFANavigationController.h"
#import <AOCKit/AOCBuldgeTabBar.h>

@interface EFATabBarController ()

@end

@implementation EFATabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    EFAViewController *first = [[EFAViewController alloc] init];
    UITabBarItem *item = [self tabBarItemWithTitle:@"第一" normalImage:@"" selectedImage:@""];
    EFANavigationController *nav = [[EFANavigationController alloc] initWithRootViewController:first];
    nav.tabBarItem = item;
    self.viewControllers = @[nav];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    NSLog(@" ---- %@ --  %@", [self class], self.navigationController.navigationBar);
}

// 配置自定义TabBar
- (void)generateTabBar {
    AOCBuldgeTabBar *bulge = [[AOCBuldgeTabBar alloc] init];
    bulge.backgroundImage = [UIImage imageNamed:@"sy_tab_bj_png"];
    [self setValue:bulge forKey:@"tabBar"];
}

@end
