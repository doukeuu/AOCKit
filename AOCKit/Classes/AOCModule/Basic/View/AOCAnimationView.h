//
//  AOCAnimationView.h
//  AOCKit
//
//  Created by ssbm on 2021/6/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 弹出动画式样
typedef NS_ENUM(NSInteger, AOCAnimationType) {
    /// 从顶部弹出
    AOCAnimationPopFromTop,
    /// 从左边弹出
    AOCAnimationPopFromLeft,
    /// 从底部弹出
    AOCAnimationPopFromBottom,
    /// 从右边弹出
    AOCAnimationPopFromRight,
    /// 从指定点缩放弹出
    AOCAnimationScaleFromPoint,
    /// 从右上角放大弹出
    AOCAnimationScaleFromRightTop
};

@interface AOCAnimationView : UIView

/// 自定义内容视图
@property (nonatomic, strong) UIView *bezelView;
/// 弹出位置
@property (nonatomic, assign) CGPoint popupPoint;
/// 弹出动画样式
@property (nonatomic, assign) AOCAnimationType animationType;
/// 隐藏后回调
@property (nonatomic, copy) void(^hideCompleted)(void);

/// 更新视图的Frame
- (void) updateBezelViewFrame;
/// 弹出视图
- (void) popViewAnimated;
/// 隐藏视图
- (void) hideViewAnimated;
@end

NS_ASSUME_NONNULL_END
