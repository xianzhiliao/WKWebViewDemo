//
//  Booker.h
//  WKWebViewDemo
//
//  Created by xianzhiliao on 2017/2/8.
//  Copyright © 2017年 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXZWebViewController.h"

@interface PutaoJsBridgeDistributer : NSObject

- (void)webViewController:(LXZWebViewController *)webViewController
                  callClz:(Class)clz
                   method:(NSString *)methodName
                   params:(NSDictionary *)params
                 callBack:(NSString *)callBack;

@end
