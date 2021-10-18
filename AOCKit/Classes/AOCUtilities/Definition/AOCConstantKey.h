//
//  AOCConstantKey.h
//  AOCKit
//
//  Created by ssbm on 2021/4/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#pragma mark - Notice Name

/// 收到新的消息的通知
UIKIT_EXTERN NSString * const AOCNoticeReceivedNewMessage;


#pragma mark - Javascript

/// 注入H5源码中的JS样式--内容显示宽度
UIKIT_EXTERN NSString *const AOCMetaJSInjectedFormat;
/// 注入H5源码中的JS样式--图片宽度
UIKIT_EXTERN NSString *const AOCImgJSInjectedFormat;
/// 注入H5源码中的JS样式--span标签内容强制换行
UIKIT_EXTERN NSString *const AOCSpanJSInjectedFormat;

NS_ASSUME_NONNULL_END
