//
//  LXZWebViewController.m
//  WKWebViewDemo
//
//  Created by xianzhiliao on 2017/2/6.
//  Copyright © 2017年 edu.self. All rights reserved.
//

#import "LXZWebViewController.h"
#import "WKWebViewConfiguration+LXZPreference.h"


@interface LXZWebViewController ()
<
WKNavigationDelegate,
WKUIDelegate,
WKScriptMessageHandler
>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSURLRequest *request;

@end

@implementation LXZWebViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.webView];
    [self.webView loadRequest:self.request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Properties

- (WKWebViewConfiguration *)config{
    if (nil == _config) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        [config lxz_preference];
        // 1. JS call nativie
        [config.userContentController addScriptMessageHandler:self name:@"saveContacts"];
        self.config = config;
    }
    return _config;
}

- (WKWebView *)webView{
    if (nil == _webView) {
        WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:self.config];
        webView.allowsBackForwardNavigationGestures = YES;
        webView.navigationDelegate = self;
        webView.UIDelegate = self;
        self.webView = webView;
    }
    return _webView;
}

#pragma mark - Public method

- (instancetype)initWithURLString:(NSString *)str{
    if (self = [super init]) {
        [self loadURLWithString:str];
    }
    return self;
}
- (instancetype)initWithURL:(NSURL *)url{
    if (self = [super init]) {
        [self loadURL:url];
    }
    return self;
}
- (instancetype)initWithURL:(NSURL *)url cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval{
    if (self = [super init]) {
        [self loadURL:url cachePolicy:cachePolicy timeoutInterval:timeoutInterval];
    }
    return self;
}

#pragma mark - Private method

- (void)loadURLWithString:(NSString *)str{
#warning TODO str 非合法url
//    if (str ) {
//        <#statements#>
//    }
    NSURL *url = [NSURL URLWithString:str];
    [self loadURL:url];
}
- (void)loadURL:(NSURL *)url{
    #warning TODO
    [self loadURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
}
- (void)loadURL:(NSURL *)url cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval{
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:cachePolicy timeoutInterval:timeoutInterval];
    self.request = request;
}

#pragma mark - WKNavigationDelegate

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"didStartProvisionalNavigation");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"didCommitNavigation");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"didFinishNavigation");
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"didFailProvisionalNavigation");
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - WKUIDelegate

// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    return nil;
}

/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"alert");
    completionHandler();
}

#pragma mark - WKScriptMessageHandler

// 从web界面中接收到一个脚本时调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"messageName:%@\nmessageBody:%@", message.name,message.body);
    NSString *methodName = [NSString stringWithFormat:@"%@:", message.name];
    SEL method = NSSelectorFromString(methodName);
    // 通过methodName 找到类
    [self performSelectorSafetyWithArgs:method ,message.body];
}

- (void)saveContacts:(id)object{
    NSLog(@"saveContacts");
    // native call js
    NSDictionary *dic = object;
    NSString *js = [NSString stringWithFormat:@"showContacts('%@','%@')",dic[@"name"],dic[@"phone"]];
    [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@ %@",response,error);
    }];
}


@end
