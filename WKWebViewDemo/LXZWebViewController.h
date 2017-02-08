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

@protocol LXZWebViewControllerDelegate <NSObject>

- (void)LXZWebViewController:(LXZWebViewController *)webViewController callSelector:(SEL)selector object:(id)object;

@end

@interface LXZWebViewController : UIViewController

@property (nonatomic, strong) WKWebViewConfiguration *config;
@property (nonatomic, strong, readonly) WKWebView *webView;

- (instancetype)initWithURLString:(NSString *)str;
- (instancetype)initWithURL:(NSURL *)url;
- (instancetype)initWithURL:(NSURL *)url cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval;

@end

