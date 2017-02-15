//
//  LXZWebViewControllerManager.h
//  WKWebViewDemo
//
//  Created by xianzhiliao on 2017/2/9.
//  Copyright © 2017年 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PTWebView;
@import WebKit;
@class PutaoJSExecutor;

@interface PTWebViewMessageManager : NSObject
<
WKNavigationDelegate,
WKUIDelegate,
WKScriptMessageHandler
>

@property (nonatomic, strong) WKWebViewConfiguration *config;
@property (nonatomic, weak) PTWebView *webView;
+ (instancetype)sharedInstance;

@end
