//
//  LXZWebViewControllerManager.m
//  WKWebViewDemo
//
//  Created by xianzhiliao on 2017/2/9.
//  Copyright © 2017年 edu.self. All rights reserved.
//

#import "LXZWebViewControllerManager.h"
#import "PutaoJsBridgeDistributer.h"
#import "PutaoJSExecutor.h"

@interface LXZWebViewControllerManager()


@end

@implementation LXZWebViewControllerManager

#pragma mark - Life cycle

+ (instancetype)sharedInstance {
    static  LXZWebViewControllerManager * instance;
    static  dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init{
    if (self = [super init]) {
        // JS call nativie
        [self addAllJSBridge];
    }
    return self;
}

- (void)dealloc{
    [self removeAllJSBridge];
}

#pragma mark - Properties

- (WKWebViewConfiguration *)config{
    if (nil == _config) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.preferences.minimumFontSize = 36;
        self.config = config;
    }
    return _config;
}

#pragma mark - Private method

- (void)addAllJSBridge{

    [[PutaoJsBridgeDistributer jsBridgeNames] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.config.userContentController addScriptMessageHandler:self name:obj];
    }];
}

- (void)removeAllJSBridge{

    [[PutaoJsBridgeDistributer jsBridgeNames] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.config.userContentController removeScriptMessageHandlerForName:obj];
    }];
}

#pragma mark - Public method


#pragma mark - WKScriptMessageHandler

// 从web界面中接收到一个脚本时调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    [PutaoJsBridgeDistributer distributerScriptMsg:message webViewController:self.webViewController];
}

@end
