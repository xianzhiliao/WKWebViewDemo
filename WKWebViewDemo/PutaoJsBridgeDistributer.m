//
//  Booker.m
//  WKWebViewDemo
//
//  Created by xianzhiliao on 2017/2/8.
//  Copyright © 2017年 edu.self. All rights reserved.
//

#import "PutaoJsBridgeDistributer.h"

@implementation PutaoJsBridgeDistributer

- (void)webViewController:(LXZWebViewController *)webViewController
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
