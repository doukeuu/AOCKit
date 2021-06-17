//
//  UIImage+Kit.h
//  AOCKit
//
//  Created by ssbm on 2021/6/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Kit)

/// 获取当前bundle中的图片
+ (instancetype)imageInBundleNamed:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
