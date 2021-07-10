//
//  UIImage+Kit.m
//  AOCKit
//
//  Created by ssbm on 2021/6/9.
//

#import "UIImage+Kit.h"
#import "NSBundle+AOC.h"

@implementation UIImage (Kit)

// 获取当前bundle中的图片
+ (instancetype)imageInBundleNamed:(NSString *)name {
    UIImage *image = [UIImage imageNamed:@"arrow_back_black"
                                inBundle:[NSBundle aocBundle]
            compatibleWithTraitCollection:nil];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
