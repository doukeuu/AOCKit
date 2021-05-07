//
//  AOCNavigationController.h
//  AOCKit
//
//  Created by ssbm on 2021/4/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCNavigationController : UINavigationController

/// 侧滑手势响应开关，最好在viewDidAppear/viewDidDisappear中使用
@property (nonatomic, assign) BOOL popGestureEnabled;
@end

NS_ASSUME_NONNULL_END
