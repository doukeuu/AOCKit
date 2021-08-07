//
//  UIButton+AOC.m
//  AOCKit
//
//  Created by ssbm on 2021/6/9.
//

#import "UIButton+AOC.h"
#import "UIImage+AOC.h"

@implementation UIButton (AOC)

#pragma mark - State Image Getter & Setter

- (id)normalImage {
    return [self imageForState:UIControlStateNormal];
}

- (void)setNormalImage:(id)image {
    if ([image isKindOfClass:[UIImage class]]) {
        [self setImage:image forState:UIControlStateNormal];
    } else if ([image isKindOfClass:[UIColor class]]) {
        [self setImage:[UIImage imageWithColor:image] forState:UIControlStateNormal];
    } else if ([image isKindOfClass:[NSString class]]) {
        [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
}

- (id)normalBackgroundImage {
    return [self backgroundImageForState:UIControlStateNormal];
}

- (void)setNormalBackgroundImage:(id)image {
    if ([image isKindOfClass:[UIImage class]]) {
        [self setBackgroundImage:image forState:UIControlStateNormal];
    } else if ([image isKindOfClass:[UIColor class]]) {
        [self setBackgroundImage:[UIImage imageWithColor:image] forState:UIControlStateNormal];
    } else if ([image isKindOfClass:[NSString class]]) {
        [self setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
}

- (id)hightlightedImage {
    return [self imageForState:UIControlStateHighlighted];
}

- (void)setHightlightedImage:(id)image {
    if ([image isKindOfClass:[UIImage class]]) {
        [self setImage:image forState:UIControlStateHighlighted];
    } else if ([image isKindOfClass:[UIColor class]]) {
        [self setImage:[UIImage imageWithColor:image] forState:UIControlStateHighlighted];
    } else if ([image isKindOfClass:[NSString class]]) {
        [self setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    }
}

- (id)hightlightedBackgroundImage {
    return [self backgroundImageForState:UIControlStateHighlighted];
}

- (void)setHightlightedBackgroundImage:(id)image {
    if ([image isKindOfClass:[UIImage class]]) {
        [self setBackgroundImage:image forState:UIControlStateHighlighted];
    } else if ([image isKindOfClass:[UIColor class]]) {
        [self setBackgroundImage:[UIImage imageWithColor:image] forState:UIControlStateHighlighted];
    } else if ([image isKindOfClass:[NSString class]]) {
        [self setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    }
}

- (id)selectedImage {
    return [self imageForState:UIControlStateSelected];
}

- (void)setSelectedImage:(id)image {
    if ([image isKindOfClass:[UIImage class]]) {
        [self setImage:image forState:UIControlStateSelected];
    } else if ([image isKindOfClass:[UIColor class]]) {
        [self setImage:[UIImage imageWithColor:image] forState:UIControlStateSelected];
    } else if ([image isKindOfClass:[NSString class]]) {
        [self setImage:[UIImage imageNamed:image] forState:UIControlStateSelected];
    }
}

- (id)selectedBackgroundImage {
    return [self backgroundImageForState:UIControlStateSelected];
}

- (void)setSelectedBackgroundImage:(id)image {
    if ([image isKindOfClass:[UIImage class]]) {
        [self setBackgroundImage:image forState:UIControlStateSelected];
    } else if ([image isKindOfClass:[UIColor class]]) {
        [self setBackgroundImage:[UIImage imageWithColor:image] forState:UIControlStateSelected];
    } else if ([image isKindOfClass:[NSString class]]) {
        [self setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateSelected];
    }
}

- (id)disabledImage {
    return [self imageForState:UIControlStateDisabled];
}

- (void)setDisabledImage:(id)image {
    if ([image isKindOfClass:[UIImage class]]) {
        [self setImage:image forState:UIControlStateDisabled];
    } else if ([image isKindOfClass:[UIColor class]]) {
        [self setImage:[UIImage imageWithColor:image] forState:UIControlStateDisabled];
    } else if ([image isKindOfClass:[NSString class]]) {
        [self setImage:[UIImage imageNamed:image] forState:UIControlStateDisabled];
    }
}

- (id)disabledBackgroundImage {
    return [self backgroundImageForState:UIControlStateDisabled];
}

- (void)setDisabledBackgroundImage:(id)image {
    if ([image isKindOfClass:[UIImage class]]) {
        [self setBackgroundImage:image forState:UIControlStateDisabled];
    } else if ([image isKindOfClass:[UIColor class]]) {
        [self setBackgroundImage:[UIImage imageWithColor:image] forState:UIControlStateDisabled];
    } else if ([image isKindOfClass:[NSString class]]) {
        [self setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateDisabled];
    }
}

#pragma mark - Class Method

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

#pragma mark - Instance Method

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
