//
//  UIButton+AOC.m
//  AOCKit
//
//  Created by ssbm on 2021/6/9.
//

#import "UIButton+AOC.h"

@implementation UIButton (AOC)

+ (UIButton *)buttonWithBackColor:(UIColor *)color
                       titleColor:(UIColor *)color2
                            title:(NSString *)title
                             font:(CGFloat)font
                            image:(NSString *)imageName
                     cornerRadius:(CGFloat)radius {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = color;
    [button setTitleColor:color2 forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    if (radius > 0) {
        button.layer.cornerRadius = radius;
    }
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return button;
}

// 重新设置 image 及 title 的位置及间距
- (void)resetImageTitlePosition:(AOCButtonImageTitlePosition)position space:(CGFloat)space {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    CGFloat titleWidth = 0.0;
    CGFloat titleHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        titleWidth = self.titleLabel.intrinsicContentSize.width;
        titleHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        titleWidth = self.titleLabel.frame.size.width;
        titleHeight = self.titleLabel.frame.size.height;
    }
    if (titleWidth > (screenWidth - 80)/2) {
//        titleWidth = (screenWidth - 80)/2;
    }
    switch (position) {
        case AOCButtonImageTopTitleDown: {
            self.imageEdgeInsets = UIEdgeInsetsMake(-titleHeight-space, 0, 0, -titleWidth);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space, 0);
        } break;
        case AOCButtonImageLeftTitleRight: {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        } break;
        case AOCButtonImageDownTitleTop: {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, -titleHeight-space, -titleWidth);
            self.titleEdgeInsets = UIEdgeInsetsMake(-imageHeight-space, -imageWith, 0, 0);
        } break;
        case AOCButtonImageRightTitleLeft: {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth+space/2.0, 0, - titleWidth - space/2.0);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        } break;
    }
}


@end
