//
//  AOCConstantKey.m
//  AOCKit
//
//  Created by ssbm on 2021/4/29.
//

#import "AOCConstantKey.h"

#pragma mark - Notice Name

NSString * const AOCNoticeReceivedNewMessage = @"kAOCNoticeReceivedNewMessage";

#pragma mark - Javascript

// 说明：分开写JS语句，是因为合并在一起，可能JS不起效果

/// 内容显示宽度
NSString * const AOCMetaJSInjectedFormat = @"var meta = document.createElement('meta'); \
                                            meta.setAttribute('name', 'viewport'); \
                                            meta.setAttribute('content', 'width=device-width, initial-scale=1.0'); \
                                            document.getElementsByTagName('head')[0].appendChild(meta);";

/// 图片宽度
NSString * const AOCImgJSInjectedFormat = @"var imgs = document.getElementsByTagName('img'); \
                                            for (var i in imgs) { \
                                                imgs[i].style.maxWidth='100%'; \
                                                imgs[i].style.height='auto'; \
                                            }";
/// span标签内容强制换行
NSString * const AOCSpanJSInjectedFormat =  @"var spans = document.getElementsByTagName('span'); \
                                            for (var s in spans) { \
                                                spans[s].style.wordWrap='break-word'; \
                                                spans[s].style.wordBreak='break-all'; \
                                            };";
