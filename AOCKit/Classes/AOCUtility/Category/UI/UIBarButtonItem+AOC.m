//
//  UIBarButtonItem+AOC.m
//  AOCKit
//
//  Created by ssbm on 2021/5/6.
//

#import "UIBarButtonItem+AOC.h"

@implementation UIBarButtonItem (AOC)

// 返回按钮样式
+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image action:(SEL)action target:(id)target {
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    itemBtn.frame = CGRectMake(0, 0, 44, 44);
    itemBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [itemBtn setImage:image forState:UIControlStateNormal];
    [itemBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:itemBtn];
}
@end
