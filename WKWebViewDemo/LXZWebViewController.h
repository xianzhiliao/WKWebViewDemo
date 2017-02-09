//
//  LXZWebViewController.h
//  WKWebViewDemo
//
//  Created by xianzhiliao on 2017/2/6.
//  Copyright © 2017年 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+PTSelector.h"
@import WebKit;
@class LXZWebViewController;
@class LXZWebViewControllerManager;

@interface LXZWebViewController : UIViewController

@property (nonatomic, strong, readonly) WKWebView *webView;

- (instancetype)initWithURLString:(NSString *)str;
- (instancetype)initWithURL:(NSURL *)url;
- (instancetype)initWithURL:(NSURL *)url cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval;
- (LXZWebViewControllerManager *)webManager;
// js 执行完native后回掉
- (void)onCallBackJsId:(NSString *)callBackId jsonStr:(NSString *)jsonStr;

@end

