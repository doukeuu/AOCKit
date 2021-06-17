//
//  UIBarButtonItem+AOC.m
//  AOCKit
//
//  Created by ssbm on 2021/5/6.
//

#import "UIBarButtonItem+AOC.h"

@implementation UIBarButtonItem (AOC)

// 返回按钮样式
+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image
                                target:(id)target
                                action:(SEL)action {
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    itemBtn.frame = CGRectMake(0, 0, 44, 44);
    itemBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [itemBtn setImage:image forState:UIControlStateNormal];
    [itemBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:itemBtn];
}

// 左边图片按钮样式
+ (UIBarButtonItem *)leftItemWithImage:(UIImage *)image
                                target:(id)target
                                action:(SEL)action {
    UIBarButtonItem *leftItem = [self itemWithImage:image target:target action:action];
    UIButton *leftButton = leftItem.customView;
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    return leftItem;
}

// 右边图片按钮样式
+ (UIBarButtonItem *)rightItemWithImage:(UIImage *)image
                                 target:(id)target
                                 action:(SEL)action {
    UIBarButtonItem *rightItem = [self itemWithImage:image target:target action:action];
    UIButton *rightButton = rightItem.customView;
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    return rightItem;
}

// 左边文字按钮样式
+ (UIBarButtonItem *)leftItemWithTitle:(NSString *)title
                                 color:(UIColor *)color
                                target:(id)target
                                action:(SEL)action {
    UIBarButtonItem *leftItem = [self itemWithTitle:title font:15 color:color target:target action:action];
    UIButton *leftButton = leftItem.customView;
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    return leftItem;
}

// 右边文字按钮样式
+ (UIBarButtonItem *)rightItemWithTitle:(NSString *)title
                                  color:(UIColor *)color
                                 target:(id)target
                                 action:(SEL)action {
    UIBarButtonItem *rightItem = [self itemWithTitle:title font:15 color:color target:target action:action];
    UIButton *rightButton = rightItem.customView;
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    return rightItem;
}

// 导航栏图片按钮样式
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image
                            target:(id)target
                            action:(SEL)action {
    return [self itemWithImage:image highLight:image target:target action:action];
}

// 导航栏图片按钮样式
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image
                         highLight:(UIImage *)highLight
                            target:(id)target
                            action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame  = CGRectMake(0, 0, MAX(image.size.width, 30), 44);
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highLight forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

// 导航栏文字按钮样式
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                              font:(CGFloat)fontSize
                             color:(UIColor *)color
                            target:(id)target
                            action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize: fontSize];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

// 重置文字
- (void)resetItemTitle:(NSString *)title {
    if ([self.customView isKindOfClass:[UIButton class]]) {
        UIButton *button = self.customView;
        [button setTitle:title forState:UIControlStateNormal];
    }
}

// 隐藏按钮
- (void)hideItem {
    self.customView.hidden = YES;
}

// 显示按钮
- (void)showItem {
    self.customView.hidden = NO;
}

@end
