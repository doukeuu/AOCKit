//
//  UIView+AOC.h
//  AOCKit
//
//  Created by ssbm on 2021/6/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (AOC)

/// frame.origin.
@property (nonatomic) CGPoint origin;
/// frame.size.
@property (nonatomic) CGSize  size;
/// frame.origin.x.
@property (nonatomic) CGFloat left;
/// frame.origin.y
@property (nonatomic) CGFloat top;
/// frame.origin.x + frame.size.width
@property (nonatomic) CGFloat right;
/// frame.origin.y + frame.size.height
@property (nonatomic) CGFloat bottom;
/// frame.size.width.
@property (nonatomic) CGFloat width;
/// frame.size.height.
@property (nonatomic) CGFloat height;
/// center.x
@property (nonatomic) CGFloat centerX;
/// center.y
@property (nonatomic) CGFloat centerY;

/// 获取视图控制器，可能为nil
- (nullable UIViewController *)viewController;
/// 截图
- (UIImage *)screenShot;
@end

NS_ASSUME_NONNULL_END
