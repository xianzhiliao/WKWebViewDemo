//
//  LXZWebViewController.m
//  WKWebViewDemo
//
//  Created by xianzhiliao on 2017/2/6.
//  Copyright © 2017年 edu.self. All rights reserved.
//

#import "LXZWebViewController.h"
#import "PTWebViewMessageManager.h"
#import "PutaoH5JSBridge.h"

@interface LXZWebViewController ()

@property (nonatomic, strong) PTWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) NSURLRequest *request;

@end

@implementation LXZWebViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self.view addSubview:self.webView];
    [self.webView loadRequest:self.request];
    
    self.webView.progressView.frame = CGRectMake(0, 64 - 3.5, [UIScreen mainScreen].bounds.size.width, 3);
    [self.navigationController.navigationBar addSubview:self.webView.progressView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"native call js" style:UIBarButtonItemStylePlain target:self action:@selector(showAlert:)];
    [self.navigationItem setRightBarButtonItem:rightItem];
}

- (void)dealloc{
     [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Properties

- (PTWebView *)webView{
    if (nil == _webView) {
        PTWebView *webView = [[PTWebView alloc] initWithFrame:self.view.frame];
        webView.messageResponseViewController = self;
        webView.allowsBackForwardNavigationGestures = YES;
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
- (IBAction)showAlert:(UIBarButtonItem *)sender {
    // native call js
    NSString *js = @"showAlert('native call js success')";
//    NSString *js = @"showContact({'name':'张三','phone':'15818696535'})";
    [PutaoJSExecutor callJS:js inWebView:self.webView completionHandler:^(id _Nullable response, NSError * _Nullable error) {
         NSLog(@"%@ %@",response,error);
    }];
//    NSDictionary *result = @{@"name":@"张三",@"phone":@"15818696535"};
//    [PutaoJSExecutor callJSFunction:@"showContact" withJSONObject:result inWebView:self.webView completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//        NSLog(@"%@ %@",response,error);
//    }];
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


@end
