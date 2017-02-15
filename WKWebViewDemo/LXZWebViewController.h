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
@class PTWebViewMessageManager;
@class PTWebView;

@interface LXZWebViewController : UIViewController

@property (nonatomic, strong, readonly) PTWebView *webView;

- (instancetype)initWithURLString:(NSString *)str;
- (instancetype)initWithURL:(NSURL *)url;
- (instancetype)initWithURL:(NSURL *)url cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval;

@end

