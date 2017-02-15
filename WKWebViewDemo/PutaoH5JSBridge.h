//
//  Booker.h
//  WKWebViewDemo
//
//  Created by xianzhiliao on 2017/2/8.
//  Copyright © 2017年 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTWebView.h"

@interface PutaoH5JSBridge : NSObject

- (void)webView:(PTWebView *)webView
   saveContacts:(NSDictionary *)params
       callBack:(NSString *)callBack;

@end
