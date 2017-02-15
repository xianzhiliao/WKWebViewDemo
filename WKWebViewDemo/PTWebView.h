//
//  PTWebView.h
//  WKWebViewDemo
//
//  Created by xianzhiliao on 2017/2/13.
//  Copyright © 2017年 edu.self. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "PTWebViewMessageManager.h"
#import "PutaoJSExecutor.h"
#import "PTWebProgressView.h"

@interface PTWebView : WKWebView

@property (nonatomic, weak) __kindof UIViewController *messageResponseViewController;
@property (nonatomic, strong) PTWebProgressView *progressView;
+ (PTWebViewMessageManager *)messageManager;
+ (NSURLRequest *)defaultRequestConfigWithURL:(NSURL *)url;

@end
