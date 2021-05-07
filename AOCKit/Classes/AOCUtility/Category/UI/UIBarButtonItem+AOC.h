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
+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image action:(SEL)action target:(id)target;
@end

NS_ASSUME_NONNULL_END
