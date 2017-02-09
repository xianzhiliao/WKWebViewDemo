//
//  LXZWebViewController.m
//  WKWebViewDemo
//
//  Created by xianzhiliao on 2017/2/6.
//  Copyright © 2017年 edu.self. All rights reserved.
//

#import "LXZWebViewController.h"
#import "LXZWebViewControllerManager.h"
#import "Booker.h"

@interface LXZWebViewController ()
<
WKNavigationDelegate,
WKUIDelegate
>

@property (nonatomic, strong) LXZWebViewControllerManager *webManager;
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
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"native call js" style:UIBarButtonItemStylePlain target:self action:@selector(showAlert:)];
    [self.navigationItem setRightBarButtonItem:rightItem];
}

- (void)dealloc{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Properties

- (LXZWebViewControllerManager *)webManager{
    if (nil == _webManager) {
        self.webManager = [LXZWebViewControllerManager sharedInstance];
        self.webManager.webViewController = self;
    }
    return _webManager;
}

- (WKWebView *)webView{
    if (nil == _webView) {
        WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:self.webManager.config];
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

// js 执行完native后回掉
- (void)onCallBackJsId:(NSString *)callBackId jsonStr:(NSString *)jsonStr{
    
    NSString *js = [NSString stringWithFormat:@"onCallBack('%@','%@')",callBackId,jsonStr];
    [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@ %@",response,error);
    }];
}

#pragma mark - Private method
- (IBAction)showAlert:(UIBarButtonItem *)sender {
    // native call js
    NSString *js = @"showAlert('native call js success')";
    [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@ %@",response,error);
    }];
}

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
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确定");
    }];
    [alertVC addAction:sureAction];
    [self presentViewController:alertVC animated:YES completion:^{
        
    }];
    completionHandler();
}


@end
