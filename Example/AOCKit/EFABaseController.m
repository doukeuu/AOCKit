//
//  EFABaseController.m
//  AOCKit_Example
//
//  Created by ssbm on 2021/5/6.
//  Copyright © 2021 pan. All rights reserved.
//

#import "EFABaseController.h"

@interface EFABaseController ()

@end

@implementation EFABaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"root";
    
    
    CGRect rect = CGRectMake(0, SCREEN_HEIGHT - 100, 100, 100);
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = UIColor.redColor;
    [self.view addSubview:view];
    
    rect = CGRectMake(0, 0, 100, 100);
    UIView *view2 = [[UIView alloc] initWithFrame:rect];
    view2.backgroundColor = UIColor.redColor;
    [self.view addSubview:view2];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    NSLog(@" ---- %@ --  %@", [self class], self.navigationController.navigationBar);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    Class secondClass = NSClassFromString(@"EFABaseController");
    id second = [[secondClass alloc] init];
    
    UINavigationController *rootVC = (UINavigationController *)[[UIApplication sharedApplication].delegate window].rootViewController;
    [rootVC pushViewController:second animated:YES];
    
//    [self.navigationController pushViewController:second animated:YES];
}

@end
