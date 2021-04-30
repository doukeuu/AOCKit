//
//  AOCSecondController.m
//  AOCKit_Example
//
//  Created by ssbm on 2021/4/30.
//  Copyright © 2021 pan. All rights reserved.
//

#import "AOCSecondController.h"

@interface AOCSecondController ()

@end

@implementation AOCSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"second";
    self.navEffectView.contentView.backgroundColor = UIColor.orangeColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navTitleColor = UIColor.redColor;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.popGestureEnabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navTitleColor = nil;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.popGestureEnabled = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
