//
//  AOCTabBarController.h
//  AOCKit
//
//  Created by ssbm on 2021/4/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCTabBarController : UITabBarController

/// 导航栏位置背景模糊视图
@property (nonatomic, strong) UIVisualEffectView *tabEffectView;

/// 导航栏位置分割线图片视图
@property (nonatomic, strong) UIImageView *tabLineView;

/// 生成tabBarItem
- (UITabBarItem *)tabBarItemWithTitle:(NSString *)title normalImage:(NSString *)normal selectedImage:(NSString *)selected;
@end

NS_ASSUME_NONNULL_END
