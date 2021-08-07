//
//  UIButton+AOC.h
//  AOCKit
//
//  Created by ssbm on 2021/6/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AOCButtonImageTitlePosition) {
    /// image在上，title在下
    AOCButtonImageTopTitleDown,
    /// image在左，title在右
    AOCButtonImageLeftTitleRight,
    /// image在下，title在上
    AOCButtonImageDownTitleTop,
    /// image在右，title在左
    AOCButtonImageRightTitleLeft
};

@interface UIButton (AOC)

@property (nonatomic, strong) id normalImage;
@property (nonatomic, strong) id normalBackgroundImage;
@property (nonatomic, strong) id hightlightedImage;
@property (nonatomic, strong) id hightlightedBackgroundImage;
@property (nonatomic, strong) id selectedImage;
@property (nonatomic, strong) id selectedBackgroundImage;
@property (nonatomic, strong) id disabledImage;
@property (nonatomic, strong) id disabledBackgroundImage;

+ (UIButton *)buttonWithBackColor:(UIColor *)color
                       titleColor:(UIColor *)color
                            title:(NSString *)title
                             font:(CGFloat)font
                            image:(NSString *)imageName
                     cornerRadius:(CGFloat)radius;

/// 重新设置 image 及 title 的位置及间距
- (void)resetImageTitlePosition:(AOCButtonImageTitlePosition)position space:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
