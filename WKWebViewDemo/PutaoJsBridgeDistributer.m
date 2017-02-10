//
//  PutaoJsBridgeDistributer.m
//  WKWebViewDemo
//
//  Created by xianzhiliao on 2017/2/8.
//  Copyright © 2017年 edu.self. All rights reserved.
//

#import "PutaoJsBridgeDistributer.h"

@implementation PutaoJsBridgeDistributer

// jsBridgeNames example PutaoH5JSBridge或PutaoTrainH5JsBridge...
+ (NSArray *)jsBridgeNames{
    return @[@"PutaoH5JSBridge"];
}
+ (void)distributerScriptMsg:(WKScriptMessage *)message
           webViewController:(LXZWebViewController *)webViewController{
    // in jsBridgeNames example PutaoH5JSBridge或PutaoTrainH5JsBridge...
    Class clz = NSClassFromString(message.name);
    NSDictionary *body = message.body;
    // 根据各个jsBridge协议转换(防止一些外部jsBridge协议不一致)
    NSString *methodName = [body objectForKey:@"keyName"];
    NSDictionary *params = [body objectForKey:@"optParams"];
    NSString *callBack = [body objectForKey:@"callBack"];
    // 通过methodName 找到注册类实例化调用,如果有回掉自行执行
    [self webViewController:webViewController callClz:clz method:methodName params:params callBack:callBack];
}

+ (void)webViewController:(LXZWebViewController *)webViewController
                  callClz:(Class)clz
                   method:(NSString *)methodName
                   params:(NSDictionary *)params
                 callBack:(NSString *)callBack
{
    NSString *lastMethodName = [NSString stringWithFormat:@"webViewController:%@:callBack:",methodName];
    SEL method = NSSelectorFromString(lastMethodName);
    [[[clz alloc]init] performSelectorSafetyWithArgs:method ,webViewController,params,callBack];
}

@end
