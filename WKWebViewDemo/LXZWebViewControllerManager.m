//
//  LXZWebViewControllerManager.m
//  WKWebViewDemo
//
//  Created by xianzhiliao on 2017/2/9.
//  Copyright © 2017年 edu.self. All rights reserved.
//

#import "LXZWebViewControllerManager.h"
#import "Booker.h"

@interface LXZWebViewControllerManager()

@property (nonatomic, strong) NSMutableDictionary *mMethodMap;

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
        [self registerAllClass];
        [self addAllScriptMessage];
    }
    return self;
}

- (void)dealloc{
    [self removeAllScriptMessage];
}

#pragma mark - Properties

- (NSMutableDictionary *)mMethodMap{
    if (nil == _mMethodMap) {
        self.mMethodMap = @{}.mutableCopy;
    }
    return _mMethodMap;
}

- (NSDictionary *)methodMap{
    return self.mMethodMap;
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

- (void)addAllScriptMessage{
    [self.methodMap enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.config.userContentController addScriptMessageHandler:self name:key];
    }];
}

- (void)removeAllScriptMessage{
    [self.methodMap enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.config.userContentController removeScriptMessageHandlerForName:key];
    }];
}

#pragma mark - Public method

- (void)registerAllClass{
    [self.mMethodMap setObject:[Booker class] forKey:@"saveContacts"];
}

#pragma mark - WKScriptMessageHandler

// 从web界面中接收到一个脚本时调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSString *methodName = [NSString stringWithFormat:@"%@:arguments:", message.name];
    SEL method = NSSelectorFromString(methodName);
    // 通过methodName 找到注册类实例化调用,如果有回掉自行执行
    Class clz = [self.methodMap objectForKey:message.name];
    [[[clz alloc]init] performSelectorSafetyWithArgs:method ,self.webViewController,message.body];
}

@end
