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

NSString * const AOCJSInjectedFormat = @"var meta = document.createElement('meta'); \
                                    meta.setAttribute('name', 'viewport'); \
                                    meta.setAttribute('content', 'width=device-width'); \
                                    document.getElementsByTagName('head')[0].appendChild(meta); \
                                    var imgs = document.getElementsByTagName('img'); \
                                    for (var i in imgs) { \
                                        imgs[i].style.maxWidth='100%'; \
                                        imgs[i].style.height='auto'; \
                                    }";
