//
//  AOCBaseController.h
//  AOCKit
//
//  Created by ssbm on 2021/4/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCBaseController : UIViewController

/// 导航栏位置背景模糊视图
@property (nonatomic, strong) UIVisualEffectView *navEffectView;

/// 导航栏位置分割线图片视图
@property (nonatomic, strong) UIImageView *navLineView;

/// 侧滑手势响应开关，最好在viewDidAppear/viewDidDisappear中使用
@property (nonatomic, assign) BOOL popGestureEnabled;

/// 导航栏标题色
@property (nonatomic, strong, nullable) UIColor *navTitleColor;

@end

NS_ASSUME_NONNULL_END
