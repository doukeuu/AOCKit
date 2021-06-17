//
//  UIBarButtonItem+AOC.h
//  AOCKit
//
//  Created by ssbm on 2021/5/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (AOC)

/// 返回按钮样式
+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image
                                target:(id)target
                                action:(SEL)action;

/// 左边图片按钮样式
+ (UIBarButtonItem *)leftItemWithImage:(UIImage *)image
                                target:(id)target
                                action:(SEL)action;

/// 右边图片按钮样式
+ (UIBarButtonItem *)rightItemWithImage:(UIImage *)image
                                 target:(id)target
                                 action:(SEL)action;

/// 左边文字按钮样式
+ (UIBarButtonItem *)leftItemWithTitle:(NSString *)title
                                 color:(UIColor *)color
                                target:(id)target
                                action:(SEL)action;

/// 右边文字按钮样式
+ (UIBarButtonItem *)rightItemWithTitle:(NSString *)title
                                 color:(UIColor *)color
                                target:(id)target
                                action:(SEL)action;

/// 导航栏图片按钮样式
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image
                            target:(id)target
                            action:(SEL)action;

/// 导航栏图片按钮样式
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image
                         highLight:(UIImage *)highLight
                            target:(id)target
                            action:(SEL)action;

/// 导航栏文字按钮样式
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                              font:(CGFloat)fontSize
                             color:(UIColor *)color
                            target:(id)target
                            action:(SEL)action;

/// 重置文字
- (void)resetItemTitle:(NSString *)title;
/// 隐藏按钮
- (void)hideItem;
/// 显示按钮
- (void)showItem;
@end

NS_ASSUME_NONNULL_END
