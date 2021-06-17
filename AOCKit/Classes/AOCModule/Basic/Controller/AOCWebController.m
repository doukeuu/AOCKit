//
//  AOCWebController.m
//  AOCKit
//
//  Created by ssbm on 2021/4/26.
//

#import "AOCWebController.h"
#import "AOCConstantKey.h"
#import "AOCDefineSize.h"
#import "UIBarButtonItem+AOC.h"
#import "NSBundle+AOC.h"

@interface AOCWebController ()
<
    WKNavigationDelegate,
    WKUIDelegate
>
@property (nonatomic, strong) UIProgressView *progressView; // 进度条视图
@property (nonatomic, strong) WKWebView *webView;           // 网页视图
@property (nonatomic, strong) NSMutableURLRequest *request; // 网络请求类
@property (nonatomic, strong) NSString *htmlString;         // html内容字符
@end

@implementation AOCWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 返回按钮
    UIImage *indicator = [UIImage imageNamed:@"arrow_back_black"
                                    inBundle:[NSBundle aocBundle]
               compatibleWithTraitCollection:nil];
    indicator = [indicator imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *backItem = [UIBarButtonItem backItemWithImage:indicator
                                                            target:self
                                                            action:@selector(clickBackItem)];
    self.navigationItem.backBarButtonItem = backItem;
    
    // 导航栏进度条
    [self.view addSubview:self.progressView];
    // 网页视图
    [self.view insertSubview:self.webView belowSubview:self.progressView];
    
    [self loadWebViewRequest];
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - Setter

- (void)setUrlContent:(NSString *)urlContent {
    _urlContent = [urlContent copy];
    [self handleURLContent:_urlContent];
}

// 处理网址或内容
- (void)handleURLContent:(NSString *)content {
    if (content == nil) {
        self.request = nil;
        self.htmlString = nil;
    } else if ([content hasPrefix:@"http"] || [content hasPrefix:@"HTTP"]) { // 网址
        if ([content containsString:@".jpg"]  ||
            [content containsString:@".jped"] ||
            [content containsString:@".png"]  ||
            [content containsString:@".gif"]) { // 图片网址
            NSString *htmlCode = @"<body style=\"margin:0; padding:0\"><p><img src=\"%@\"/></p></body>";
            self.htmlString = [NSString stringWithFormat:htmlCode, content];
        } else {
            NSURL *url = [NSURL URLWithString:content];
            self.request = [[NSMutableURLRequest alloc] initWithURL:url];
            self.request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
            self.request.timeoutInterval = 20;
        }
    } else {
        if ([content containsString:@"<body"]) { // 内容有body标签
            self.htmlString = content;
        } else { // 添加body标签，设置边距为0
            self.htmlString = [NSString stringWithFormat:@"<body style=\"margin:8; padding:0\">%@</body>", content];
        }
    }
}

// 加载网页请求
- (void)loadWebViewRequest {
    if (self.request != nil) {
        [self.webView loadRequest:self.request];
    } else if (self.htmlString != nil) {
        WKUserScript *userScript = [[WKUserScript alloc] initWithSource:AOCJSInjectedFormat injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        [self.webView.configuration.userContentController addUserScript:userScript];
        [self.webView loadHTMLString:self.htmlString baseURL:nil];
    }
}

#pragma mark - Respond

// 点击返回按钮
- (void)clickBackItem {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        if(self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Getter

// 进度条视图
- (UIProgressView *)progressView {
    if (_progressView) return _progressView;
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 2);
    _progressView = [[UIProgressView alloc] initWithFrame:rect];
    _progressView.trackTintColor = [UIColor clearColor];
    _progressView.progressTintColor = UIColor.blueColor;
    return _progressView;
}

// 网页视图
- (WKWebView *)webView {
    if (_webView) return _webView;
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _webView.configuration.preferences.minimumFontSize = 15;
    _webView.configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    _webView.configuration.allowsInlineMediaPlayback = YES;
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    return _webView;
}

@end
