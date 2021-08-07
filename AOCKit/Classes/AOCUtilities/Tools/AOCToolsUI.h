//
//  AOCToolsUI.h
//  AOCKit
//
//  Created by pan on 2021/8/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCToolsUI : NSObject

/// 获取当前Controller
+ (UIViewController *)currentViewController;
/// 查找最上层Controller
+ (nullable UIViewController *)topViewControllerFrom:(UIViewController *)controller;
@end

NS_ASSUME_NONNULL_END
