//
//  AOCWebController.h
//  AOCKit
//
//  Created by ssbm on 2021/4/26.
//

#import "AOCViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCWebController : AOCViewController

/// 网页视图
@property (nonatomic, strong, readonly) WKWebView *webView;
/// 网址或内容
@property (nonatomic, copy) NSString *urlContent;

/// 加载网页请求
- (void)loadWebViewRequest;
@end

NS_ASSUME_NONNULL_END
