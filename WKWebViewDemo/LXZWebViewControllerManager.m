//
//  LXZWebViewControllerManager.m
//  WKWebViewDemo
//
//  Created by xianzhiliao on 2017/2/9.
//  Copyright © 2017年 edu.self. All rights reserved.
//

#import "LXZWebViewControllerManager.h"
#import "PutaoJsBridgeDistributer.h"

@interface LXZWebViewControllerManager()

@property (nonatomic, strong) NSMutableDictionary *mJSBridgeMap;

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
        // 1. JS call nativie
        [self registerAllJSBridge];
        [self addAllJSBridge];
    }
    return self;
}

- (void)dealloc{
    [self removeAllJSBridge];
}

#pragma mark - Properties

- (NSMutableDictionary *)mJSBridgeMap{
    if (nil == _mJSBridgeMap) {
        self.mJSBridgeMap = @{}.mutableCopy;
    }
    return _mJSBridgeMap;
}

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
    [self.mJSBridgeMap enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.config.userContentController addScriptMessageHandler:self name:key];
    }];
}

- (void)removeAllJSBridge{
    [self.mJSBridgeMap enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.config.userContentController removeScriptMessageHandlerForName:key];
    }];
}

#pragma mark - Public method

- (void)registerAllJSBridge{
    [self.mJSBridgeMap setObject:[PutaoJsBridgeDistributer class] forKey:@"PutaoH5JSBridge"];
}

#pragma mark - WKScriptMessageHandler

// 从web界面中接收到一个脚本时调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSDictionary *body = message.body;
    NSString *methodName = [body objectForKey:@"keyName"];
    NSDictionary *params = [body objectForKey:@"optParams"];
    NSString *callBack = [body objectForKey:@"callBack"];
    
    // maybe PutaoH5JSBridge或PutaoTrainH5JsBridge...
    Class clz = NSClassFromString(message.name);
    // 通过methodName 找到注册类实例化调用,如果有回掉自行执行
    [[[PutaoJsBridgeDistributer alloc]init] webViewController:self.webViewController callClz:clz method:methodName params:params callBack:callBack];
}

@end
