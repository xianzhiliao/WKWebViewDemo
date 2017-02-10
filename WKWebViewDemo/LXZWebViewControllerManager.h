//
//  LXZWebViewControllerManager.h
//  WKWebViewDemo
//
//  Created by xianzhiliao on 2017/2/9.
//  Copyright © 2017年 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXZWebViewController.h"
@import WebKit;
@class PutaoJSExecutor;

@interface LXZWebViewControllerManager : NSObject
<
WKScriptMessageHandler
>

@property (nonatomic, strong) WKWebViewConfiguration *config;
@property (nonatomic, weak) LXZWebViewController *webViewController;
+ (instancetype)sharedInstance;

@end
