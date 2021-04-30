//
//  AOCViewController.m
//  AOCKit
//
//  Created by pan on 04/23/2021.
//  Copyright (c) 2021 pan. All rights reserved.
//

#import "AOCViewController.h"

@interface AOCViewController ()

@end

@implementation AOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"root";
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    Class secondClass = NSClassFromString(@"AOCSecondController");
    id second = [[secondClass alloc] init];
    [self.navigationController pushViewController:second animated:YES];
}

@end
